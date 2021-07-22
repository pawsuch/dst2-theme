#DST2 theme, ohmyzsh
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""

function prompt_char {
	if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}

function k8s_ctx { 
  X=`oc config current-context |cut -d\/ -f1,2`
  if [ $? -eq 0 ]; then
    echo -e "K8s Context: \e[3m ${X} \e[0m";
  else
    echo ""
  fi
}

PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%}
)
%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info)
%{$fg[blue]%} $(k8s_ctx) %{$reset_color%}
$(prompt_char) '

RPROMPT=' %{$fg[green]%}[%*]%{$reset_color%}'
