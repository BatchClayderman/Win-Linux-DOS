#!/bin/bash
sudo apt-get install python3 || sudo yum install python3 # Press Y
if [[ $? -ne 0 ]];
then
	echo "Error installing Python. "
	exit 1
fi
echo -e "lists = []" > prime_1000.py
echo -e "for i in range(2, 1000):" >> prime_1000.py
echo -e "\tfor j in range(2, int(i ** 0.5) + 1):" >> prime_1000.py
echo -e "\t\tif i % j == 0:" >> prime_1000.py
echo -e "\t\t\tbreak" >> prime_1000.py
echo -e "\telse:" >> prime_1000.py
echo -e "\t\tlists.append(i)" >> prime_1000.py
echo -e "print(lists)" >> prime_1000.py
#chmod 777 prime_1000.py
if [[ $? -ne 0 ]];
then
	echo "Error creating temporary file. "
	exit 1
fi
python3 prime_1000.py # Use Python for example (C/C++ can also be in this way)
rm -f prime_1000.py # Remove the temporary file
exit 0