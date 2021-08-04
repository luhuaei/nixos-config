grey='\e[0;90m'

function josh_prompt {
  (( spare_width = ${COLUMNS} ))
  prompt=" "

  path_size=${#PWD}
  user_machine_size=${#${(%):-%n@%m-}}

  (( spare_width = ${spare_width} - (${user_machine_size} + ${path_size}) ))

  while [ ${#prompt} -lt $spare_width ]; do
    prompt=" $prompt"
  done

  prompt="%{%F{green}%}$PWD$prompt%{%F{red}%}$(rvm_prompt_info || rbenv_prompt_info)%{$reset_color%}"

  echo $prompt
}

setopt prompt_subst

PROMPT='
%n@%m $(josh_prompt)
%(?,%{%F{green}%},%{%F{red}%})⚡%{$reset_color%} '
