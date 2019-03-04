#
# shell prompt variables cheatsheet
#
#    \h – Hostname
#    \W – Current working directory
#    \u – Current username
#
#    \t – time
#    \d – date
#    \n – newline
#    \s – Shell name
#    \W – Current working directory
#    \w – The full path of the current working directory.
#    \u – Current username
#    \H – Display FQDN hostname
#    \h – Hostname
#    \# – The command number of this command.
#    \! – The history number of the current command
#
export PS1="\w\[\033[m\]\$ "
export CLICOLOR=1

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"
#set completion-ignore-case On
#set show-all-if-ambiguous on
#Fuzzy Finder fzf
#[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#Colorscheme: a,blck;b,red;c,grn;d,brwn;e,blu;f,mgnta;g,cyan;h,lghtgrey;
#	   A,bdBlck(shws as grey);B,bldRed;C,bldGrn;D,bldBrw/Ylw;E,bldBlu;
#	   F,bldMgnta;G,bldCyan;H,bldGray/white;x,defaultbckgrnd 
export LSCOLORS=BxFxBxDxCxegedabagacad
#Attrb.Order:Directory,SymLnk,Sockt,pipe,Executable,blck special, character special,exec with setuid bit, exec w setgid bit, dir wrtable to others, w sticky bit, dir wrtable to others wout sticky bit

#export LSCOLORS=ExFxBxDxCxegedabagacad
alias ls='ls -GFh'

#   Set Paths
#   ------------------------------------------------------------
    export PATH="$PATH:/usr/local/bin/"
    export PATH="/usr/local/git/bin:/sw/bin/:/usr/local/bin:/usr/local/:/usr/local/sbin:/usr/local/mysql/bin:$PATH"
    export PATH="/usr/local/opt/openssl/bin:$PATH"
    export PATH="$PATH:~/bin/"
    export PATH="$PATH:/Users/punk_rockguy/Documents/Coding/Flutter/flutter/bin"
#   Set Default Editor (change 'Nano' to the editor of your choice)
#   ------------------------------------------------------------
    export EDITOR=/usr/bin/vim

#   -----------------------------
#   2. MAKE TERMINAL BETTER
#   -----------------------------

###############Encryption Source###################

enc () { openssl enc -aes-256-cbc -salt -in "$1" -out "$2";} #Encrypt 
dec () { openssl enc -d -aes-256-cbc -in "$1" -out "$2"; } #Decrypt 

################################Editing Source#############3

swiff () { cp "$1" "$1.swiff" && vi -c 'wq' -r "$1"; mv "$1" "$1.xswiff" && mv "$1.swiff" "$1" && diff "$1" "$1.xswiff"; rm "$1.xswiff" ; } #swapdiff
vswiff () { cp "$1" "$1.swdiff" && vi -c 'wq' -r "$1"; mv "$1" "$1.xswdiff" && mv "$1.swdiff" "$1" && vimdiff "$1" "$1.xswdiff" && rm $1".xswdiff"; } #swapvimdiff

#############VMware Virtualization Source############################
#Could Be shortened to an externa VMWare File

wvm-start () {
VM=$1
vmPath="$(find ~/Documents -maxdepth "9" -iname "*$VM*.vmx" 2> >(grep -v 'Permission denied' >&2))"
vmrun -T ws start "$vmPath" nogui;
}

wvm-stop () {
VM=$1
vmPath="$(find ~/Documents -maxdepth "9" -iname "*$VM*.vmx" 2> >(grep -v 'Permission denied' >&2))"
vmrun -T ws stop "$vmPath" soft;
}

wvm-reset () {
VM=$1
vmPath="$(find ~/Documents -maxdepth "9" -iname "*$VM*.vmx" 2> >(grep -v 'Permission denied' >&2))"
vmrun -T ws reset "$vmPath" soft;
}

wvm-suspend () {
VM=$1
vmPath="$(find ~/Documents -maxdepth "9" -iname "*$VM*.vmx" 2> >(grep -v 'Permission denied' >&2))"
vmrun -T ws suspend "$vmPath" soft;
}

wvm-pause () {
VM=$1
vmPath="$(find ~/Documents -maxdepth "9" -iname "*$VM*.vmx" 2> >(grep -v 'Permission denied' >&2))"
vmrun -T ws pause "$vmPath" soft;
}

wvm-unpause () {
VM=$1
vmPath="$(find ~/Documents -maxdepth "9" -iname "*$VM*.vmx" 2> >(grep -v 'Permission denied' >&2))"
vmrun -T ws unpause "$vmPath" soft;
}

wvm-run () {
#takes 2 arguments gu & pwdPath
VM=$1
vmPath="$(find ~/Documents -maxdepth "9" -iname "*$VM*.vmx" 2> >(grep -v 'Permission denied' >&2))"
gu=$2
gp="$(gpg --decrypt $pwdPath)"
echo "$vmPath"
#pwdPath=$3
pwdPath="$HOME/.gnupg/.xvm/"$VM"/"$VM"Xy.gpg"
cmd=$3

#check for tools
chkTools="`vmrun checkToolsState "$vmPath"`" 
echo $chkTools
if [ "!$chkTools" = "running" ]
then
echo "VMTools Havent been installed. Installing..."
vmrun installTools "$vmPath"

fi

vmrun -T ws -gu "$gu" -gp "$gp" runProgramInGuest "$vmPath" -activeWindow /bin/bash "$cmd"  ;

gIP="`vmrun -T ws getGuestIPAddress "$vmPath"`"
echo "IP is: $gIP " 

#############

#VM="/Users/punk_rockguy/Documents/Virtual Machines.localized/Dbxiatan.vmwarevm/Dbxiatan.vmx"
#pwdPath="$HOME/.gnupg/.xvm/"$VM"/"$VM"Xy.gpg"
#hIP="`ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 | head -n 1`"
#pwdX="$(gpg --decrypt $pwdPath)"
#FILE="$HOME/.ssh/($VM)Xy"
#if[ ! -f FILE ] ssh-keygen -f ($VM)Xy -t ecdsa -b 521 & ssh-copy-id -i ~/.ssh/($VM)Xy $user@$host
#vmrun -T ws -gu Dbxiatan -gp $pwdX start "$VM" nogui & sleep 5;
 
#ssh -Y xyryu@$gIP "terminology -e ssh punk_rockguy@$hIP"  
}

wvm-gls () {
#takes 2 arguments gu & pwdPath
VM=$1
vmPath="$(find ~/Documents -maxdepth "9" -iname "*$VM*.vmx" 2> >(grep -v 'Permission denied' >&2))"
gu=$2
pwdPath=$3
cmd=$4
gp="$(gpg --decrypt $pwdPath)"

vmrun -T ws -gu $gu -gp $gp listProcessesInGuest "$vmPath";
}

wvm-create () {
vmware-vdiskmanager
}

DbxTerm (){
pwdPath="$HOME/DbxiXy.gpg"
VM="/Users/punk_rockguy/Documents/Virtual Machines.localized/Dbxiatan.vmwarevm/Dbxiatan.vmx"
hIP="$(ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 | head -n 1)"
pwdX="$(gpg --decrypt $pwdPath)"
#FILE="$HOME/.ssh/($VM)Xy"
#if[ ! -f FILE ] ssh-keygen -f ($VM)Xy -t ecdsa -b 521 & ssh-copy-id -i ~/.ssh/($VM)Xy $user@$host
vmrun -T ws -gu Dbxiatan -gp $pwdX start "$VM" nogui;
gIP="$(vmrun -T ws getGuestIPAddress "$VM")"
echo "IP is: $gIP " 
 
ssh -Y xyryu@$gIP terminology & 
#password_command = gpg --decrypt $pwdPath.enc
}

wvm-getip (){
VM="$1"

pwdPath="$HOME/.gnupg/.mxy/"$VM"Xy.gpg"
hIP="$(ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 | head -n 1)"
pwdX="$(gpg --decrypt $pwdPath)"
#FILE="$HOME/.ssh/($VM)Xy"
#if[ ! -f FILE ] ssh-keygen -f ($VM)Xy -t ecdsa -b 521 & ssh-copy-id -i ~/.ssh/($VM)Xy $user@$host
gIP="$(vmrun -T ws getGuestIPAddress "$VM")"
echo "IP is: $gIP " 
 
#password_command = gpg --decrypt $pwdPath.enc
}

terminology (){
pwdPath="$HOME/DbxiXy.gpg"
VM="/Users/punk_rockguy/Documents/Virtual Machines.localized/Dbxiatan.vmwarevm/Dbxiatan.vmx"
hIP="`ifconfig | grep "inet " | grep -v 127.0.0.1 | cut -d\  -f2 | head -n 1`"
pwdX="$(gpg --decrypt $pwdPath)"
#FILE="$HOME/.ssh/($VM)Xy"
#if[ ! -f FILE ] ssh-keygen -f ($VM)Xy -t ecdsa -b 521 & ssh-copy-id -i ~/.ssh/($VM)Xy $user@$host
vmrun -T ws -gu Dbxiatan -gp $pwdX start "$VM" nogui & sleep 5;
gIP="`vmrun -T ws getGuestIPAddress "$VM"`"
echo "IP is: $gIP " 
 
ssh -Y xyryu@$gIP "terminology -e ssh punk_rockguy@$hIP"  
#password_command = gpg --decrypt $pwdPath.enc
}

##########################Image Manipulation
smartresize() {
   mogrify -path "$3" -filter Triangle -define filter:support=2 -thumbnail "$2" -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB "$1"
}

mv_seqnum(){
  a=1
  for i in $@; do
    new=$(printf "%04d.jpg" "$a")
    mv -- "$i" "$new"
    let a=a+1
  done
}

img_size_folder(){
  mkdir $1
  cp *.jpg $1
  cd $1
  mogrify -r $2 *.jpg
  cd ..
}

create_image_sizes(){
  mv_seqnum
  img_size_folder big 1620
  img_size_folder full 1920
  img_size_folder medium 1024
  img_size_folder small 450
}


thmbFld() {
mkdir thmbnails
for f in `find ./ .jpg`; 
do   
 smartresize $f 300 thmbnails;
done
}

smrtRz() {
   mogrify -path thumbnails -filter Triangle -define filter:support=2 -thumbnail 300 -unsharp 0.25x0.08+8.3+0.045 -dither None -posterize 136 -quality 82 -define jpeg:fancy-upsampling=off -define png:compression-filter=5 -define png:compression-level=9 -define png:compression-strategy=1 -define png:exclude-chunk=all -interlace none -colorspace sRGB $1
}


xrgthmb(){
S=$1 
F=$2
mkdir $F;
#mkdir thumbnails;
find . -iname "*.jpg" -type f -print0 | xargs -P 8 -I {} ~/bin/smartresize.sh '{}' "$S" "$F" 
}

xthmb(){
S=$1 
F=$2
mkdir $F;
#mkdir thumbnails;
find . -iname "*.jpg" -type f | parallel ~/bin/smartresize.sh {} $S $F 
}

#alias xargs="xargs -0"
alias dir='ll'
alias bar='pianobar'			    #"'To the Bar'"... echo "I'm Sick" (Spaghetti Incident Gs N'R* ) 
alias vi="vim"				    # Preferred version of Vim
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
#alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                       # Preferred 'ls' implementation
alias less='less -FSRXc'                    # Preferred 'less' implementation
cd() { builtin cd "$@"; ls; }               # Always list directory contents upon 'cd'
alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels
alias edit='vim'                           # edit:Opens any file in sublime editor
alias ~="cd ~"                              # ~:            Go Home
alias c='clear'                             # c:            Clear terminal display
alias which='type -all'                     # which:        Find executables
alias path='echo -e ${PATH//:/\\n}'         # path:         Echo all executable Paths
alias show_options='shopt'                  # Show_options: display bash options settings
alias fix_stty='stty sane'                  # fix_stty:     Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'   # cic:          Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }        # mcd:          Makes new Dir and jumps inside
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias vmrun="/Applications/VMWare\ Fusion.app/Contents/Library/vmrun"
alias VBoxManage="/Applications/VirtualBox.app/Contents/MacOS/VBoxManage"

#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.            Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<EOT
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }

# ---------------------------
#   4. SEARCHING
#   ---------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }


#   ---------------------------
#   5. PROCESS MANAGEMENT
#   ---------------------------

#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }

#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'

#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'

#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'
#   ---------------------------
#   6. NETWORKING
#   ---------------------------

alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs

#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }


#   ---------------------------------------
#   7. SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------

alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user

#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"

#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'

#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"

#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

#   ---------------------------------------
#   8. WEB DEVELOPMENT
#   ---------------------------------------

alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page

#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }


#   ---------------------------------------
#   9. REMINDERS & NOTES
#   ---------------------------------------

#   remove_disk: spin down unneeded disk
#   ---------------------------------------
#   diskutil eject /dev/disk1s3

#   to change the password on an encrypted disk image:
#   ---------------------------------------
#   hdiutil chpass /path/to/the/diskimage

#   to mount a read-only disk image as read-write:
#   ---------------------------------------
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify

#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo

#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/punk_rockguy/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/punk_rockguy/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/punk_rockguy/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/punk_rockguy/Downloads/google-cloud-sdk/completion.bash.inc'; fi
