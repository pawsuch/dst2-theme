ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[green]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}!"
ZSH_THEME_GIT_PROMPT_CLEAN=""
IC=$(printf "\U1f608")
PRM=$(printf "\U2B91")
function prompt_char {
    if [ $UID -eq 0 ]; then echo "%{$fg[red]%}#%{$reset_color%}"; else echo $; fi
}
function k8s_ctx {
  PP=$(printf "\U2b55")
  if [ -z $K8 ]; then
    k8ctls=(oc kubectl)
    for k in "${k8ctls[@]}"; do
      hash "$k"
      if [ $? -eq 0 ]; then export K8="$k"; break;  fi
    done
  fi

  X=`$K8 config current-context |cut -d\/ -f1,2`
  if [ $? -eq 0 ]; then
    echo -e "$PP\e[3m ${X} \e[0m";
  else
    echo ""
  fi
}
PROMPT='%(?, ,%{$fg[red]%}FAIL%{$reset_color%})
%{$fg[red]%}$(k8s_ctx)%{$reset_color%}
%{$fg[magenta]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}: %{$fg_bold[blue]%}%~%{$reset_color%}$(git_prompt_info)
%{$fg[green]%}$PRM  %{$reset_color%}'
RPROMPT='%{$fg[green]%}[%*]%{$reset_color%}'
