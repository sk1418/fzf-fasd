# fzf + fasd

Forked from wookayin's [fzf-fasd](https://github.com/wookayin/fzf-fasd). Rewrote the script by adding some features that can be convenient.

A shell plugin that integrates [fzf] and [fasd]:
--- tab completion of `z` with fzf's directory fuzzy search!
--- tab completion of `v` with fzf's file fuzzy search!

### Usage

```bash
z [dir name slug]<TAB>

alias v=nvim # or vim or other editor 
v [somename name slug]<TAB>
```

Provided two fasd-files and fasd-dir widgets, default binding:

```bash
bindkey '^X^F' fasd_files_to_fzf
bindkey '^X^d' fasd_dirs_to_fzf
```

can be mapped to other keys

### Configuration

To configure fzf height or [any other options](https://github.com/junegunn/fzf#environment-variables) passed to fzf, tune `FZF_TMUX_HEIGHT` or `FZF_DEFAULT_OPTS` for all fzf widgets (e.g. CTRL-T), or `FZF_FASD_OPTS` for fzf-fasd only.

For example:

```bash
export FZF_TMUX_HEIGHT='40%'    # default height is 40%
export FZF_DEFAULT_OPTS='--height 80%'
export FZF_FASD_OPTS='--prompt "fasd_cd> "'
```

### Installation

Make sure that you have [fzf] and [fasd] installed.

Clone the repo and simply source the `fzf-fasd.plugin.zsh` in your `.zshrc`

Or:

[zplug]:

```
zplug "sk1418/fzf-fasd"
```

or use your favorite plugin manager.

### See Also

- [fz], which inspired this plugin.

### License

[MIT License](LICENSE) (c) 2017-2020 Jongwook Choi

[fzf]: https://github.com/junegunn/fzf
[fasd]: https://github.com/clvv/fasd
[zplug]: https://github.com/zplug/zplug
[fz]: https://github.com/changyuheng/fz
