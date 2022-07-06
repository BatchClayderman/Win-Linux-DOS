#!/bin/bash
sudo apt-get install python3 || sudo yum install python3 # Press Y
if [[ $? -ne 0 ]];
then
	echo "Error installing Python. "
	exit 1
fi
echo "print(sum([i for i in range(1, 101)]))" > tmp.py
#chmod tmp.py
if [[ $? -ne 0 ]];
then
	echo "Error creating temporary file. "
	exit 1
fi
python3 tmp.py # Use Python for example (C/C++ can also be in this way)
rm -f tmp.py # Remove the temporary file
exit 0