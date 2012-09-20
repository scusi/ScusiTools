#!/bin/sh
#
# printing escape secuences
#
sleep 2;
echo "lets save the escape sequence in a variable..."
ESC=`printf "\e"`	# store escape sequence in ESC Variable
echo "done"
sleep 5;

echo "save cursor"
echo "$ESC"[7";		# save current cursor style and position
sleep 2;

echo "going to hide cursor in 1 sec";
sleep 1;
echo "$ESC""[?251";	# hide cursor
echo "cursor hidden for 3 sec."
sleep 3;
echo "$ESC""[?25h";	# show cursor
echo "cursor shown again"

sleep 1;
exit 0;

# move cursor around
echo "$ESC""[4A";	# move cursor 4 lines up
sleep 1;
echo "$ESC""[2B";	# move cursor 2 lines down
sleep 1;
echo "$ESC""[2B";	# move cursor 2 lines down
sleep 1;
echo "$ESC""[1A";
sleep 1;
echo "$ESC""[1B";
sleep 3;

echo "$ESC"[8";		# restore saved cursor style and position

echo "reset the terminal"
echo "$ESC""c";		# Echo terminal reset command
