#!/bin/bash
echo -e "#include <iostream>\nint main()\n{\n\tint i = 0, sum = 0;\n\tfor (i = 1; i <= 100; ++i)\n\t\tsum += i;\n\tprintf(\"%d\\\n\", sum);return 0;\n}" > temp.cpp
if [[ $? -ne 0 ]];
then
	echo "Error creating temporary file. "
	exit 1
fi
g++ temp.cpp -o temp
if [[ $? -ne 0 ]];
then
	echo "Error creating executable file. "
	exit 1
fi
chmod +x temp
./temp
rm -f temp.cpp temp # Remove the temporary file
exit 0