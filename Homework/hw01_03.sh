#!/bin/bash

# Connact two strings
# 
# a + b

# Get input
a=$1
b=$2
if [[ -z "$a" ]]; then
	read -p "Please enter the first string: " a
fi
if [[ -z "$b" ]]; then
	read -p "Please enter the second string: " b
fi

# Connect
c=$a$b
echo -e "\e[1;31mString a: \e[0m"
echo $a
echo -e "\e[1;31mString b: \e[0m"
echo $b
echo -e "\e[1;31mString c (a + b): \e[0m"
echo $c
exit 0