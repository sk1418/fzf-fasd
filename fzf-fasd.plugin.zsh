# fzf-fasd integration
# original author: @wookayin
# rewrote: @sk1418
# MIT License (c) 2017-2025


# fasd+fzf integration (ZSH only)
#
#--------------------------------------------------
# z, v command completion
#--------------------------------------------------
function __zv_fasd_completion() {
  local args=(${(z)LBUFFER})
  local cmd=${args[1]}
  # triggered only at the command 'z'; fallback to default
  if [[ "$cmd" != "z" && "$cmd" != "v" ]]; then
    zle ${__fzf_fasd_default_completion:-expand-or-complete}
    return
  fi
  case "$cmd" in
    'z') 
      zle __fasd_to_fzf_completion 'dir' 1 ;;
    'v')
      zle __fasd_to_fzf_completion 'file' 1 ;;
  esac
}

#--------------------------------------------------
# fasd dir on fzf completion
#--------------------------------------------------
function fasd_files_to_fzf() {
  zle __fasd_to_fzf_completion 'file' 0
}

#--------------------------------------------------
# fasd dir on fzf completion
#--------------------------------------------------
function fasd_dirs_to_fzf() {
  zle __fasd_to_fzf_completion 'dir' 0
}

#--------------------------------------------------
# fasd on fzf
# arg1: type (files|dir)
# arg2: if enable query: 0 (No)/ 1 (yes)
#--------------------------------------------------
function __fasd_to_fzf_completion(){
  local fasd_type="$1" # type: dir/file
  local with_query="$2" # 0 (No)/ 1 (yes)
  local args slug selected
  args=(${(z)LBUFFER})

  if [[ ! -z $with_query && "${#args}" -gt 1 ]]; then
    eval "slug=${args[-1]}"
    unset "args[-1]"
  fi

  local result=""
  case "$fasd_type" in
    'dir')
      result=$(fasd -dlR "$slug");;
    'file')
      result=$(fasd -flR "$slug");;
  esac

  local selected=$(echo "$result" | __fzf "$slug")
  # return completion result with $selected
  if [[ -n "$selected" ]]; then
    if [[ $fasd_type == "dir" && "$selected" != */ ]]; then
      selected="${selected}/"
    fi
    selected=$(printf %q "$selected")
    LBUFFER="${args[@]} $selected"
  else
    return
  fi

  zle redisplay
  typeset -f zle-line-init >/dev/null && zle zle-line-init
}

# fzf command for internal using
function __fzf() {
  FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} $FZF_DEFAULT_OPTS $FZF_FASD_OPTS" 
  fzf --query="$1" --reverse --exit-0 --select-1 --bind 'shift-tab:up,tab:down' 
}

[ -z "$__fzf_fasd_default_completion" ] && {
  binding=$(bindkey '^I')
  [[ $binding =~ 'undefined-key' ]] || __fzf_fasd_default_completion=$binding[(s: :w)2]
  unset binding
}

zle -N  __fasd_to_fzf_completion

zle     -N     fasd_files_to_fzf
bindkey '^X^F' fasd_files_to_fzf

zle     -N     fasd_dirs_to_fzf
bindkey '^X^d' fasd_dirs_to_fzf

zle     -N   __zv_fasd_completion
bindkey '^I' __zv_fasd_completion

# vim: ft=sh ts=2 sw=2 et
