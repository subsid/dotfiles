import type { ExtensionAPI, ExtensionContext } from "@mariozechner/pi-coding-agent";

const PLAN_MODE_TOOLS = ["read", "grep", "find", "ls", "bash"];
const PLAN_WIDGET_ID = "plan-mode-widget";
const PLAN_STATUS_ID = "plan-mode-status";
const PLAN_STATE_TYPE = "plan-mode-state";

const SAFE_BASH_PATTERNS = [
	/^\s*pwd\b/,
	/^\s*ls\b/,
	/^\s*find\b/,
	/^\s*grep\b/,
	/^\s*rg\b/,
	/^\s*fd\b/,
	/^\s*cat\b/,
	/^\s*head\b/,
	/^\s*tail\b/,
	/^\s*sed\s+-n\b/,
	/^\s*awk\b/,
	/^\s*sort\b/,
	/^\s*uniq\b/,
	/^\s*wc\b/,
	/^\s*file\b/,
	/^\s*stat\b/,
	/^\s*tree\b/,
	/^\s*eza\b/,
	/^\s*git\s+(status|log|diff|show|branch)\b/i,
	/^\s*npm\s+(list|ls|view|info|search|outdated|audit)\b/i,
	/^\s*yarn\s+(list|info|why|audit)\b/i,
	/^\s*pnpm\s+(list|ls|info|why|audit)\b/i,
];

interface PlanModeState {
	enabled: boolean;
	previousTools?: string[];
}

function isSafeBashCommand(command: string): boolean {
	return SAFE_BASH_PATTERNS.some((pattern) => pattern.test(command));
}

export default function planModeExtension(pi: ExtensionAPI): void {
	let enabled = false;
	let previousTools: string[] | undefined;

	function persistState(): void {
		pi.appendEntry<PlanModeState>(PLAN_STATE_TYPE, {
			enabled,
			previousTools,
		});
	}

	function updateUi(ctx: ExtensionContext): void {
		if (!enabled) {
			ctx.ui.setStatus(PLAN_STATUS_ID, undefined);
			ctx.ui.setWidget(PLAN_WIDGET_ID, undefined);
			return;
		}

		ctx.ui.setStatus(PLAN_STATUS_ID, ctx.ui.theme.fg("warning", "⏸ plan"));
		ctx.ui.setWidget(PLAN_WIDGET_ID, [
			ctx.ui.theme.fg("accent", "Plan mode active"),
			ctx.ui.theme.fg("muted", "Read-only tools: read, grep, find, ls, bash"),
			ctx.ui.theme.fg("muted", "Use /plan off to restore normal tools"),
		]);
	}

	function enablePlanMode(ctx: ExtensionContext): void {
		if (enabled) {
			updateUi(ctx);
			return;
		}

		enabled = true;
		previousTools = pi.getActiveTools();
		pi.setActiveTools(PLAN_MODE_TOOLS);
		persistState();
		updateUi(ctx);
		ctx.ui.notify("Plan mode enabled", "info");
	}

	function disablePlanMode(ctx: ExtensionContext): void {
		if (!enabled) {
			updateUi(ctx);
			return;
		}

		enabled = false;
		pi.setActiveTools(previousTools && previousTools.length > 0 ? previousTools : ["read", "bash", "edit", "write"]);
		previousTools = undefined;
		persistState();
		updateUi(ctx);
		ctx.ui.notify("Plan mode disabled", "info");
	}

	function restoreState(ctx: ExtensionContext): void {
		const branchEntries = ctx.sessionManager.getBranch();
		const savedState = [...branchEntries]
			.reverse()
			.find((entry) => entry.type === "custom" && entry.customType === PLAN_STATE_TYPE) as
			| { data?: PlanModeState }
			| undefined;

		if (savedState?.data) {
			enabled = savedState.data.enabled;
			previousTools = savedState.data.previousTools;
		} else {
			enabled = false;
			previousTools = undefined;
		}

		if (pi.getFlag("plan") === true) {
			enabled = true;
			if (!previousTools || previousTools.length === 0) {
				previousTools = pi.getActiveTools();
			}
		}

		if (enabled) {
			pi.setActiveTools(PLAN_MODE_TOOLS);
		}

		updateUi(ctx);
	}

	pi.registerFlag("plan", {
		description: "Start in read-only plan mode",
		type: "boolean",
		default: false,
	});

	pi.registerCommand("plan", {
		description: "Toggle read-only plan mode",
		handler: async (args, ctx) => {
			const action = args.trim().toLowerCase();

			if (action === "on") {
				enablePlanMode(ctx);
				return;
			}

			if (action === "off") {
				disablePlanMode(ctx);
				return;
			}

			if (action === "status") {
				ctx.ui.notify(enabled ? "Plan mode is enabled" : "Plan mode is disabled", "info");
				return;
			}

			if (enabled) {
				disablePlanMode(ctx);
			} else {
				enablePlanMode(ctx);
			}
		},
	});

	pi.registerShortcut("ctrl+alt+p", {
		description: "Toggle read-only plan mode",
		handler: async (ctx) => {
			if (enabled) {
				disablePlanMode(ctx);
			} else {
				enablePlanMode(ctx);
			}
		},
	});

	pi.on("before_agent_start", async () => {
		if (!enabled) return;

		return {
			message: {
				customType: "plan-mode-context",
				display: false,
				content: `[PLAN MODE ACTIVE]
You are in read-only planning mode.

Rules:
- Do not modify files.
- Do not use edit or write.
- Use only the active read-only tools.
- If you use bash, use only safe read-only inspection commands.
- Explore the codebase before proposing changes.
- Ask clarifying questions if requirements are ambiguous.

Output requirements:
- Summarize what you found.
- Produce a numbered implementation plan.
- Call out risks, dependencies, and tests that would need updates.`,
			},
		};
	});

	pi.on("tool_call", async (event) => {
		if (!enabled || event.toolName !== "bash") return;

		const command = String(event.input.command ?? "").trim();
		if (isSafeBashCommand(command)) return;

		return {
			block: true,
			reason: `Blocked in plan mode. Bash is limited to safe read-only commands.\nCommand: ${command}`,
		};
	});

	pi.on("session_start", async (_event, ctx) => {
		restoreState(ctx);
	});

	pi.on("session_tree", async (_event, ctx) => {
		restoreState(ctx);
	});
}
