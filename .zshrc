# The following lines were added by compinstall

zstyle ':completion:*' completer _expand _complete _ignored
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' max-errors 1 not-numeric
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle :compinstall filename '/home/rootman/.zshrc'
autoload -U colors 
autoload -U compinit compinit
# eval 'dircolors -b'
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=1000
setopt appendhistory autocd notify
unsetopt beep
bindkey -v
# End of lines configured by zsh-newuser-install
# initial Promt
autoload -Uz promptinit
promptinit 
prompt bart
# set default browser
export BROWSER2="w3m"

########################
####### Alias ##########
########################
alias ls='ls --color=auto -hF'
alias lsd='ls -ld *(-/DN)'
alias lsa='ls -ld .*'
alias f='find |grep'
alias df='df -h'
alias mkdir='mkdir -p -v'
alias grep='grep --color=auto'
alias c="clear"
alias dir='ls -lh --color=auto'
alias gvim='gvim -geom 82x35'
alias ..='cd ..'
alias A='sudo pacman-color -S'
alias As='pacman-color -Ss'
alias hr='hash -r'
alias sduo='sudo'

# Tools and Programm
#
alias gochroot='sudo nice -n 19 chroot /home/rootman/openmoko/archmobile/work /bin/bash -l'
alias proxmark='~/src/proxmark3-read-only/client/proxmark3'
alias proxmark_snoop='~/src/proxmark3-read-only/client/snoop'
alias neo_start='sudo /etc/rc.d/openmoko-usb-networking restart'

# Console Stuff
alias xmplayer='mplayer -fs -stop-xscreensaver -shuffle'
alias vmplayer='mplayer -fs -stop-xscreensaver'
# safety features
# alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'                    
# alias ln='ln -i'
#
# Pacman alias examples
alias pacupg='sudo pacman-color -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
alias pacin='sudo pacman-color -S'           # Install specific package(s) from the repositories
alias pacins='sudo pacman-color -U'          # Install specific package not from the repositories but from a file 
alias pacre='sudo pacman-color -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
alias pacrem='sudo pacman-color -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
alias pacrep='pacman-color -Si'              # Display information about a given package in the repositories
alias pacreps='pacman-color -Ss'             # Search for package(s) in the repositories
alias pacloc='pacman-color -Qi'              # Display information about a given package in the local database
alias paclocs='pacman-color -Qs'             # Search for package(s) in the local database

# GLOBAL ALIAS
# ############
# command L equivalent to command |less
alias -g L='|less' 
########################
#### Keybindings #######
########################
bindkey "\e[1~" beginning-of-line # Home
bindkey "\e[4~" end-of-line # End
bindkey "\e[5~" beginning-of-history # PageUp
bindkey "\e[6~" end-of-history # PageDown
bindkey "\e[2~" quoted-insert # Ins
bindkey "\e[3~" delete-char # Del
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\e\e[C" forward-word
bindkey "\e\e[D" backward-word
bindkey "\e[Z" reverse-menu-complete # Shift+Tab
# for rxvt
bindkey "\e[7~" beginning-of-line # Home
bindkey "\e[8~" end-of-line # End
# for non RH/Debian xterm, can't hurt for RH/Debian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
########################
###### Exports #########
########################
export DEVKITPRO=$HOME/src/proxmark3/
export DEVKITARM=$DEVKITPRO/devkitARM
export PATH=${PATH}:${DEVKITARM}/bin

########################
###### Functions #######
########################
#
#Funktion for ps -ax | grep 'ARGUMENT'
funtion psa()
	{ ps -ax | grep $@ }

# Function to uncompress different files
function x()
{
if [ -f "$1" ] ; then
case "$1" in
*.tar.bz2) tar xjf "$1" ;;
*.tar.gz) tar xzf "$1" ;;
*.tar.bz) tar xzf "$1" ;;
*.tar.Z) tar xzf "$1" ;;
*.bz2) bunzip2 "$1" ;;
*.rar) unrar x "$1" ;;
*.gz) gunzip "$1" ;;
*.jar) unzip "$1" ;;
*.tar) tar xf "$1" ;;
*.tbz2) tar xjf "$1" ;;
*.tgz) tar xzf "$1" ;;
*.zip) unzip "$1" ;;
*.Z) uncompress "$1" ;;
*.7z) 7z x "$1" ;;
*) echo "'$1' cannot be extracted." ;;
esac
else
echo "'$1' is not a valid archive."
fi
}

# Funtctiom Smartcompress
#Usage: smartcompress <file> (<type>)
#Description: compresses files or a directory.  Defaults to tar.gz
  smartcompress() {
        if [ $2 ]; then
                case $2 in
                        tgz | tar.gz)   tar -zcvf$1.$2 $1 ;;
                        tbz2 | tar.bz2) tar -jcvf$1.$2 $1 ;;
                        tar.Z)          tar -Zcvf$1.$2 $1 ;;
                        tar)            tar -cvf$1.$2  $1 ;;
                        gz | gzip)      gzip           $1 ;;
                        bz2 | bzip2)    bzip2          $1 ;;
                        *)
                        echo "Error: $2 is not a valid compression type"
                        ;;
                esac
        else
                smartcompress $1 tar.gz
        fi
  }
#Funktion Show-Archive
# Usage: show-archive <archive>
# Description: view archive without unpack
  show-archive() {
        if [[ -f $1 ]]
        then
                case $1 in
                        *.tar.gz)      gunzip -c $1 | tar -tf - -- ;;
                        *.tar)         tar -tf $1 ;;
                        *.tgz)         tar -ztf $1 ;;
                        *.zip)         unzip -l $1 ;;
                        *.bz2)         bzless $1 ;;
                        *)             echo "'$1' Error. Please go away" ;;
                esac
        else
                echo "'$1' is not a valid archive"
        fi
  }

  folsym() {
    if [[ -e $1 || -h $1 ]]; then
        file=$1
    else
        file=`which $1`
    fi
    if [[ -e $file || -L $file ]]; then
        if [[ -L $file ]]; then
            echo `ls -ld $file | perl -ane 'print $F[7]'` '->'
            folsym `perl -le '$file = $ARGV[0];
                              $dest = readlink $file;
                              if ($dest !~ m{^/}) {
                                  $file =~ s{(/?)[^/]*$}{$1$dest};
                              } else {
                                  $file = $dest;
                              }
                              $file =~ s{/{2,}}{/}g;
                              while ($file =~ s{[^/]+/\.\./}{}) {
                                  ;
                              }
                              $file =~ s{^(/\.\.)+}{};
                              print $file' $file`
        else
            ls -d $file
        fi
    else
        echo $file
    fi
  }

# Function SMBMOUNT 
# Usage: smbmount <server> <share> <domain/workgroup> 
# Info you have to create a credential file for every domain/workgroup with user and password befor running the function 
function smbmount()
{
	dir=/media/smbshares/
	echo "sudo mount -t cifs "//$1/$2" "$dir$1/$2" -o credentials=/root/.smbcredentials_$3,workgroup="$3""
	if [ -d $dir$1/$2 ] ; then
	if [ "$(ls -A $dir$1/$2)" ] ; then
		echo "Share $1/$2 is already mounted" 
	return 1	
	fi
	echo "Server=$1 Share=$2 Path=$dir$2 Workgroup=$3"
	echo "Share $2 has been successfully mounted"
else
	sudo mkdir -p "$dir$1/$2"
	echo "Folder $1/$2 has been created" 
	sudo mount -t cifs "//$1/$2" "$dir$1/$2" -o credentials=/root/.smbcredentials_$3,workgroup="$3" 
	echo "Share $2 has been successfully mounted"
fi
}

# Mkdir && cd
 mcd() 
 { mkdir -p "$@"; cd "$@" }

# Übersetzung bei dict.leo.org
   leo() { w3m "http://dict.leo.org/?search=$*" }

# Set shutdown Timer 
# Usage: timer <time in minutes> 
#
timer()
	{ sudo shutdown -t 60 -h "$@" "Shutdown Timer has been activated will go down in $@ minutes" }

function mstsc()
{ rdesktop -n roman -k de -a 16 -u unitit -g 1024x768 -d mp.local $1.mp.local } 

funktion say_de()
{ espeak -v de "$@"}
funktion say()
{ espeak "$@"}

funktion gochroot_neo()
{
	cd "/home/rootman/Openmoko/shr/chroot/shr-chroot"
	echo "change to directory and start chroot"
	pwd
	sudo ./shr-chroot.sh
	echo "Enter the chroot"
	su - bitbake
	echo "change to bitbake user"
	cd shr-unstable
	
	echo " to build unstable packages"
	. ./setup-env 
	echo "build env"
	bitbake -k shr_image
	echo "bitbake "shr_image""
} 

function xxrandr()
{
		~/scripts/xrandr_docking.sh right
	}
