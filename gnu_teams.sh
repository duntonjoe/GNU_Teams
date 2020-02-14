#!/bin/bash
print_greeter(){
	clear
	read -d '\n' greeter <<-"_EOF_"
	/*       _\|/_
	         (o o)
	 +----oOO-{_}-OOo-----------------------------------+
	 |  ____ _   _ _   _   _____                        |
	 | / ___| \\ | | | | | |_   _|__  __ _ _ __ ___  ___ |
	 || |  _|  \\| | | | |   | |/ _ \\/ _` | '_ ` _ \\/ __||
	 || |_| | |\\  | |_| |   | |  __/ (_| | | | | | \\__ \\|
	 | \\____|_| \\_|\\___/    |_|\\___|\\__,_|_| |_| |_|___/|
	 |                                                  |
	 +-------------------------------------------------*/
	_EOF_
	echo "$greeter" | lolcat; printf "\n"
}

gnu_teams() {
	clear
	touch MY_DATA_X6Q36
	echo "Grabbing Users... "
	x=1
	sp="/-\|"
	echo -n ' '
	
	for i in {60..86} 
	do 
		host=$(ssh 166.66.64.$i "cat /etc/hostname")
		ssh 166.66.64.$i "who | cut -d' ' -f 1" | \
			(mapfile -t; echo "${MAPFILE[0]}@$host") >> MY_DATA_X6Q36
		printf "\b${sp:i++%${#sp}:1}"
	done
	printf "\n"
	clear
	echo $'\e[1;31m'Users Online: $'\e[0m'
	grep -v '^[@]' MY_DATA_X6Q36 > MY_DATA_X6Q36.tmp
	rm MY_DATA_X6Q36
	while read LINE
	do
		echo $'\e[1;35m'"-> "$LINE $'\e[0m'
	done < MY_DATA_X6Q36.tmp
	
	printf "\n"
	read -p "select a \"user@host\" => " selection
	target=$(grep "$selection" MY_DATA_X6Q36.tmp) 
	targetHost=$(echo "$target" | cut -d "@" -f 2)
	targetUser=$(echo "$target" | cut -d "@" -f 1)
	echo "type !goodbye to quit"
	read -p "Enter Message: " message
	while [ "$message" != "!goodbye" ]
	do
		ssh "$USER"@"$targetHost" "echo $message | write $targetUser"
		read -p "=> " message
	done	
	rm MY_DATA_X6Q36.tmp
}

show_help(){
	print_greeter
	echo $'\e[1;31m'Please Select One of The Following: $'\e[0m'
	

}

main_menu(){
	echo $'\e[1;31m'Please Select One of The Following: $'\e[0m'
	echo "1) Run GNU Teams"
	echo "2) Configure SSH Keys"
	echo "3) Help"
	echo "4) Exit"
	read -p "=> " choice
	case $choice in
		1)
			gnu_teams
			;;
		2)	
			configure_ssh
			;;
		3)
			show_help
			;;
		4)	exit
			;;
		*)
			read -p "Invalid Input, Press <ENTER> to Continue..."
			print_greeter
			main_menu
			;;
	esac
}

#main:
clear
print_greeter
main_menu
