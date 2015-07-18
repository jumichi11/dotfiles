export LANG=ja_JP.UTF-8
HISTFILE=$HOME/.zsh-history
HISTSIZE=100000
SAVEHIST=100000

#�p�X�̐ݒ�
PATH=/usr/local/bin:$PATH
PATH=~/bin:$PATH
export MANPATH=/usr/local/share/man:/usr/local/man:/usr/share/man

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias git='nocorrect git'

## �⊮�@�\�̋���
autoload -Uz compinit
compinit

autoload colors
colors
case ${UID} in
0)
	PROMPT='%{${fg[green]}%} %n %{${reset_color}%}'
	RPROMPT='%{${fg[yellow]}%} [%~] %{${reset_color}%}'
	;;
*)
	PROMPT='%{${fg[green]}%} %n %{${reset_color}%}'
	RPROMPT='%{${fg[yellow]}%} [%~] %{${reset_color}%}'
	;;
esac

## �R�A�_���v�T�C�Y�𐧌�
# limit coredumpsize 102400

## �o�͂̕����񖖔��ɉ��s�R�[�h�������ꍇ�ł��\��
unsetopt promptcr

## �F���g��
setopt prompt_subst

## �r�[�v��炳�Ȃ�
#setopt nobeep

## �����R�}���h jobs �̏o�͂��f�t�H���g�� jobs -l �ɂ���
setopt long_list_jobs

## �⊮���ꗗ�Ńt�@�C���̎�ʂ��}�[�N�\��
setopt list_types

## �T�X�y���h���̃v���Z�X�Ɠ����R�}���h�������s�����ꍇ�̓��W���[��
setopt auto_resume

## �⊮�����ꗗ�\��
setopt auto_list

## ���O�Ɠ����R�}���h���q�X�g���ɒǉ����Ȃ�
setopt hist_ignore_dups

## cd ���Ɏ����� push
setopt autopushd

## �����f�B���N�g���� pushd ���Ȃ�
setopt pushd_ignore_dups

## �t�@�C������ #, ~, ^ �� 3 �����𐳋K�\���Ƃ��Ĉ���
setopt extended_glob

## TAB �ŏ��ɕ⊮����؂�ւ���
setopt auto_menu

## zsh �̊J�n, �I���������q�X�g���t�@�C���ɏ�������
setopt extended_history

## =command �� command �̃p�X���ɓW�J����
setopt equals

## --prefix=/usr �Ȃǂ� = �ȍ~���⊮
setopt magic_equal_subst

## �q�X�g�����Ăяo���Ă�����s����ԂɈ�U�ҏW
setopt hist_verify

# �t�@�C�����̓W�J�Ŏ������ł͂Ȃ����l�I�Ƀ\�[�g
setopt numeric_glob_sort

## �o�͎�8�r�b�g��ʂ�
setopt print_eight_bit

## �q�X�g�������L
setopt share_history

## �⊮���̃J�[�\���I����L����
zstyle ':completion:*:default' menu select=1

## �⊮���̐F�Â�
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

## �f�B���N�g���������� cd
setopt auto_cd

## �J�b�R�̑Ή��Ȃǂ������I�ɕ⊮
setopt auto_param_keys

## �f�B���N�g�����̕⊮�Ŗ����� / �������I�ɕt�����A���̕⊮�ɔ�����
setopt auto_param_slash

## �X�y���`�F�b�N
setopt correct

## jkobayashi add
echo Callme
export PATH=$PATH:/usr/local/vim74/bin/
export PATH=$PATH:~/java_wrapper
alias vim='/usr/local/vim74/bin/vim.exe'
alias ec='explorer .'
alias gnuplot='/cygdrive/c/Program\ Files\ \(x86\)/gnuplot/bin/gnuplot.exe'
export TERM=xterm
export PLANTUML_PATH="`cygpath -w \`which plantuml.jar\``"


bindkey -v

alias -s txt=/usr/local/vim74/bin/vim.exe

## cdr system stuff.
autoload -Uz chpwd_recent_dirs cdr add-zsh-hook
add-zsh-hook chpwd chpwd_recent_dirs
# �G���g���������Ȃ�Ƃ�����҂�d��
# https://github.com/zsh-users/zsh/blob/zsh-5.0.4/Functions/Chpwd/chpwd_recent_filehandler#L39
# zstyle ':chpwd:*' recent-dirs-max 5000
zstyle ':chpwd:*' recent-dirs-max 100
zstyle ':chpwd:*' recent-dirs-default yes
zstyle ':completion:*' recent-dirs-insert both

#percol���g�����f�B���N�g������
# {{{
# cd �������L�^
typeset -U chpwd_functions
CD_HISTORY_FILE=${HOME}/.cd_history_file # cd �����̋L�^��t�@�C��
function chpwd_record_history() {
    echo $PWD >> ${CD_HISTORY_FILE}
}
chpwd_functions=($chpwd_functions chpwd_record_history)

# percol ���g���� cd �����̒�����f�B���N�g����I��
# �ߋ��̖K��񐔂������قǑI�����̏�ɗ���
function percol_get_destination_from_history() {
    sort ${CD_HISTORY_FILE} | uniq -c | sort -r | \
        sed -e 's/^[ ]*[0-9]*[ ]*//' | \
        sed -e s"/^${HOME//\//\\/}/~/" | \
        percol | xargs echo
}

# percol ���g���� cd �����̒�����f�B���N�g����I���� cd ����E�B�W�F�b�g
function percol_cd_history() {
    local destination=$(percol_get_destination_from_history)
    [ -n $destination ] && cd ${destination/#\~/${HOME}}
    zle reset-prompt
}
zle -N percol_cd_history

# percol ���g���� cd �����̒�����f�B���N�g����I�����C���݂̃J�[�\���ʒu�ɑ}������E�B�W�F�b�g
function percol_insert_history() {
    local destination=$(percol_get_destination_from_history)
    if [ $? -eq 0 ]; then
        local new_left="${LBUFFER} ${destination} "
        BUFFER=${new_left}${RBUFFER}
        CURSOR=${#new_left}
    fi
    zle reset-prompt
}
zle -N percol_insert_history
# }}}

function exists { which $1 &> /dev/null }

if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(history -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^x:' percol_select_history
fi

# C-x ; �Ńf�B���N�g���� cd
# C-x i �Ńf�B���N�g����}��
bindkey '^x;' percol_cd_history
bindkey '^xi' percol_insert_history

#cygstart����g���q���X�g
alias -s bib=cygstart
alias -s cif=cygstart
alias -s eps=cygstart
alias -s pdf=cygstart
alias -s png=cygstart
alias -s ppt=cygstart
alias -s pptx=cygstart
alias -s ps=cygstart
alias -s tex=cygstart
alias -s txt=cygstart
alias -s vasp=cygstart
alias -s vesta=cygstart
alias -s xls=cygstart
alias -s xlsx=cygstart
alias -s xsf=cygstart
alias -s jpg=cygstart
alias -s jpeg=cygstart


alias c='cygstart'
