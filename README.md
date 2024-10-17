Inspired by https://github.com/mathiasbynens/dotfiles

- Setup scripts for my Ubuntu machine

`./my_ubuntu_setup --help` (No guarantees!)

## Setup stow links

The stow managed files are in the `stow_files` directory. To setup the links, run the following command:

```bash
stow -t ~ stow_files
```

Use the adopt flag when setting up the links for the first time. This will copy files from the target directory to the stow directory.
But be careful, this will overwrite the files in the stow directory.

```bash
stow -t ~ stow_files --adopt
```

