#!/bin/sh
#
#
censor_on=`printf '\e[30m\e[40m'`;	# set fore- and backgroud-color to black
censor_off=`printf '\e[39m\e[49m'`;	# reset colors to default

# print statement
echo "Das schlimme an Zensur ist ${censor_on}dass man nichts sieht${censor_off}"
