#!/bin/bash

PROGRAMNAME="Universal Contact"
SCRIPTPATH=$(readlink -f $0)
SCRIPTNAME=$(basename "${SCRIPTPATH}")
ARGV=( "$@" )
ARGC=$#

# Use the absolute path to decide the diectory where the database files store
DB_DIR_PATH="$(dirname "${SCRIPTPATH}")/db/"

# Global varribles
USERNAME=""
DB_FILE_PATH=""
CONTACT_LENGTH=0 # The number of contacts in the database
CONTACT_DATE=() # Contact Date field array
CONTACT_ALARM=() # Contact Alarm field array
CONTACT_NAME=() # Contact name field array
CONTACT_GROUP=() # Contact group field array
CONTACT_PRI=() # Contact priority field array
CONTACT_PHONE=() # Contact phone number field array
CONTACT_WECHAT=() # Contact wechat field array
CONTACT_QQ=() # Contact qq field array
CONTACT_EMAIL=() # Contact email field array
CONTACT_COMPANY=() # Contact company field array
CONTACT_NOTE=() # Contact notes field array

NUMREGEX='^[0-9]+$'

CRON_DIR_PATH="/var/spool/cron/crontabs"

ADD_HELP="${SCRIPTNAME} add TITLE CONTEXT"
LIST_HELP="${SCRIPTNAME} list [INDEX]"
EDIT_HELP="${SCRIPTNAME} edit INDEX TYPE NEWCTX"
DEL_HELP="${SCRIPTNAME} del INDEX"
ALARM_HELP="${SCRIPTNAME} alarm MONTH-DAY-HOUR-MINUTE/HOUR-MINUTE"

## Exit code
EXIT_SUCCESS=0
EXIT_FAILULRE=1
EOF=255

function espeak_w()
{
	espeak "$1" 1>&2 2>/dev/null
}

function info()
{
	echo -e "\033[32;1mINFO\033[0m: $1"
}

function error()
{
	echo -e "\033[31;1mERROR\033[0m: $1"
}

function print_title()
{
	[[ $ARGC > 0 ]] && return # if [[ $ARGC > 0 ]]; then return; fi
	clear
	echo -n '/'
	printf '*%.0s' {1..20}
	printf " \033[1;31m${PROGRAMNAME}\033[0;0m "
	#printf " \033[32;5m\033[47m\033[1m${PROGRAMNAME}\033[0m "
	printf '*%.0s' {1..20}
	echo '/'
}

function waituser()
{
	[[ $ARGC > 0 ]] && return
	printf '\n\033[5mPlease press any key to continue...\033[0m'
	read -n 1 -s
}

# Get username
function get_username()
{
	USERNAME=$(whoami)
	info "Logged as ${USERNAME}"
}

function get_cron()
{
	if [[ ! -f $CRON_DIR_PATH ]];
	then
		if [[ -f "/var/spool/cron/$(whoami)" ]];
		then
			CRON_DIR_PATH="/var/spool/cron/${USERNAME}"
		else
			error "No available cron found. "
		fi
	fi
}

function send_alarm_to_tty()
{
	for tty in `find /dev/pts -user ${USERNAME} -group tty -type c`
	do
		echo -e "$1" >> $tty
	done
}

function add_alarm_command_to_cron()
{
	local date=$1
	local month=$2
	local day=$3
	local hour=$4
	local min=$5
	
	command=$(cat <<-EOF
## CONTACT:${USERNAME}:${date} START##
${min} ${hour} ${day} ${month} * ${SCRIPTPATH} do_alarm ${date} 2>&1 1>/dev/null
## CONTACT:${USERNAME}:${date} END##
EOF
)
	if ! [[ -d "${CRON_DIR_PATH}" ]];
	then
		error "Cron not available on this system"
		return 0
	fi
	if ! [[ -e "${CRON_DIR_PATH}/${USERNAME}" ]];
	then
		touch "${CRON_DIR_PATH}/${USERNAME}"
		# make cron happy
		chmod 600 "${CRON_DIR_PATH}/${USERNAME}"
	fi
	echo "$command" >> "${CRON_DIR_PATH}/${USERNAME}"
	return 1
}

# Setup database
function db_setup()
{
	# Check database directory
	DB_DIR_PATH=$(realpath "${DB_DIR_PATH}")
	info "Database directory is ${DB_DIR_PATH}"
	if ! [[ -d ${DB_DIR_PATH} ]];
	then
		[[ -e ${DB_DIR_PATH} ]] && error "${DB_DIR_PATH} is not a directory" && exit $EXIT_FAILURE
		# If not exists, create one
		mkdir -p ${DB_DIR_PATH}
		chmod 777 ${DB_DIR_PATH}
	fi
	# CHeck database
	DB_FILE_PATH="${DB_DIR_PATH}/${USERNAME}.db"
	info "Database path is ${DB_FILE_PATH}"
	if ! [[ -f ${DB_FILE_PATH} ]];
	then
		[[ -e ${DB_FILE_PATH} ]] && error "${DB_FILE_PATH} is not a file" && exit $EXIT_FAILURE
		# If not exists, create one
		touch ${DB_FILE_PATH}
		chmod 600 ${DB_FILE_PATH}
	fi
}

# Load database
function db_load() {
	# Database file format
	## 1. Each line represents a contact entry.
	## 2. Each contact entry contains eleven fields: date, alarm, name, group, priority, phone, wechat, qq, email, company, note.
	## 3. date is the timestamp when the contact has created.
	## 4. alarm is the timestamp when the alarm for this contact will be sent,
	##	  if the value is 0, it means the alarm is disabled.
	## 5. title and context are base64 encoded.
	CONTACT_DATE=($(cut -f1 -d":" $DB_FILE_PATH))
	CONTACT_ALARM=($(cut -f2 -d":" $DB_FILE_PATH))
	CONTACT_NAME=($(cut -f3 -d":" $DB_FILE_PATH))
	CONTACT_GROUP=($(cut -f4 -d":" $DB_FILE_PATH))
	CONTACT_PRI=($(cut -f5 -d":" $DB_FILE_PATH))
	CONTACT_PHONE=($(cut -f6 -d":" $DB_FILE_PATH))
	CONTACT_WECHAT=($(cut -f7 -d":" $DB_FILE_PATH))
	CONTACT_QQ=($(cut -f8 -d":" $DB_FILE_PATH))
	CONTACT_EMAIL=($(cut -f9 -d":" $DB_FILE_PATH))
	CONTACT_COMPANY=($(cut -f10 -d":" $DB_FILE_PATH))
	CONTACT_NOTE=($(cut -f11 -d":" $DB_FILE_PATH))
	CONTACT_LENGTH=${#CONTACT_DATE[@]}
}

# Add an entry to database
function db_add() {
	local date=$(date +%s)
	local alarm=0
	local name=$1
	local group=$2
	local priority=$3
	local phone=$4
	local wechat=$5
	local qq=$6
	local email=$7
	local company=$8
	local note=$9
	CONTACT_DATE[$CONTACT_LENGTH]=$date
	CONTACT_ALARM[$CONTACT_LENGTH]=$alarm
	CONTACT_NAME[$CONTACT_LENGTH]=$name
	CONTACT_GROUP[$CONTACT_LENGTH]=$group
	CONTACT_PRI[$CONTACT_LENGTH]=$priority
	CONTACT_PHONE[$CONTACT_LENGTH]=$phone
	CONTACT_WECHAT[$CONTACT_LENGTH]=$wechat
	CONTACT_QQ[$CONTACT_LENGTH]=$qq
	CONTACT_EMAIL[$CONTACT_LENGTH]=$email
	CONTACT_COMPANY[$CONTACT_LENGTH]=$company
	CONTACT_NOTE[$CONTACT_LENGTH]=$note
	((CONTACT_LENGTH++))
}

# Remove an entry to database
function db_del() {
	local i=$1
	# Check if index is OK
	[[ $i -lt 0 || $i -ge ${CONTACT_LENGTH} ]] && return
   
	# Are we removing an entry located in the end of array?
	if [[ $i == $((${CONTACT_LENGTH}-1)) ]]
	then
		unset CONTACT_DATE[$i]
		unset CONTACT_ALARM[$i]
		unset CONTACT_NAME[$i]
		unset CONTACT_GROUP[$i]
		unset CONTACT_PRI[$i]
		unset CONTACT_PHONE[$i]
		unset CONTACT_WECHAT[$i]
		unset CONTACT_QQ[$i]
		unset CONTACT_EMAIL[$i]
		unset CONTACT_COMPANY[$i]
		unset CONTACT_NOTE[$i]
	# Are we removing an entry located in the head of array?
	elif [[ $i == 0 ]]
	then
		# Copy the entire array except the first element
		CONTACT_DATE=(${CONTACT_DATE[@]:1})
		CONTACT_ALARM=(${CONTACT_ALARM[@]:1})
		CONTACT_NAME=(${CONTACT_NAME[@]:1})
		CONTACT_GROUP=(${CONTACT_GROUP[@]:1})
		CONTACT_PRI=(${CONTACT_PRI[@]:1})
		CONTACT_PHONE=(${CONTACT_PHONE[@]:1})
		CONTACT_WECHAT=(${CONTACT_WECHAT[@]:1})
		CONTACT_QQ=(${CONTACT_QQ[@]:1})
		CONTACT_EMAIL=(${CONTACT_EMAIL[@]:1})
		CONTACT_COMPANY=(${CONTACT_COMPANY[@]:1})

		CONTACT_NOTE=(${CONTACT_NOTE[@]:1})
	# Are we removing an entry located in the middle of array?
	else
		# S1: Copy all the elements ahead of the entry to new array
		local date=${CONTACT_DATE[@]:0:$i}
		# S2: Append all the elements behind of the entry to new array
		date+=(${CONTACT_DATE[@]:(($i+1))})
		# S3: Replace the old array with the new one
		CONTACT_DATE=(${date[@]})
		local alarm=${CONTACT_ALARM[@]:0:$i}
		alarm+=(${CONTACT_ALARM[@]:(($i+1))})
		CONTACT_ALARM=(${alarm[@]})
		local name=${CONTACT_NAME[@]:0:$i}
		name+=(${CONTACT_NAME[@]:(($i+1))})
		CONTACT_NAME=(${name[@]})
		local group=${CONTACT_GROUP[@]:0:$i}
		group+=(${CONTACT_GROUP[@]:(($i+1))})
		CONTACT_GROUP=(${group[@]})
		local priority=${CONTACT_PRI[@]:0:$i}
		priority+=(${CONTACT_PRI[@]:(($i+1))})
		CONTACT_PRI=(${priority[@]})
		local phone=${CONTACT_PHONE[@]:0:$i}
		phone+=(${CONTACT_PHOEN[@]:(($i+1))})
		CONTACT_PHONE=(${phone[@]})
		local wechat=${CONTACT_WECHAT[@]:0:$i}
		wechat+=(${CONTACT_WECHAT[@]:(($i+1))})
		CONTACT_WECHAT=(${wechat[@]})
		local qq=${CONTACT_QQ[@]:0:$i}
		qq+=(${CONTACT_QQ[@]:(($i+1))})
		CONTACT_QQ=(${qq[@]})
		local email=${CONTACT_EMAIL[@]:0:$i}
		email+=(${CONTACT_EMAIL[@]:(($i+1))})
		CONTACT_EMAIL=(${email[@]})
		local company=${CONTACT_COMPANY[@]:0:$i}
		company+=(${CONTACT_COMPANY[@]:(($i+1))})
		CONTACT_COMPANY=(${company[@]})
		local note=${CONTACT_NOTE[@]:0:$i}
		note+=(${CONTACT_NOTE[@]:(($i+1))})
		CONTACT_NOTE=(${note[@]})

	fi
	((CONTACT_LENGTH--))
}

function db_save() {
	# Delete all the data in the database file
	> ${DB_FILE_PATH}
	# Write entries in the array line by line to the database
	for (( i=0; i < ${CONTACT_LENGTH}; i++ )); do
		local e="${CONTACT_DATE[$i]}:${CONTACT_ALARM[$i]}:${CONTACT_NAME[$i]}:${CONTACT_GROUP[$i]}:${CONTACT_PRI[$i]}:${CONTACT_PHONE[$i]}:${CONTACT_WECHAT[$i]}:${CONTACT_QQ[$i]}:${CONTACT_EMAIL[$i]}:${CONTACT_COMPANY[$i]}:${CONTACT_NOTE[$i]}"
		echo $e >> ${DB_FILE_PATH}
	done
}

function contact_add() {
	local name_en=$(echo -n "$1" | base64 -w0)
	local group_en=$(echo -n "$2" | base64 -w0)
	local priority_en=$(echo -n "$3" | base64 -w0 )
	local phone_en=$(echo -n "$4" | base64 -w0)

	local wechat_en=$(echo -n "$5" | base64 -w0)
	local qq_en=$(echo -n "$6" | base64 -w0)
	local email_en=$(echo -n "$7" | base64 -w0 )
	local company_en=$(echo -n "$8" | base64 -w0)

	local note_en=$(echo -n "$9" | base64 -w0)
	
	db_add $name_en $group_en $priority_en $phone_en $wechat_en $qq_en $email_en $company_en $note_en
}

function contact_del()
{
	local i=$1
	[[ $i -lt 1 || $i -gt ${CONTACT_LENGTH} ]] && return
	db_del $(($i-1))
}

function contact_list()
{
	for (( i=0; i < ${CONTACT_LENGTH}; i++ ));
	do
		local date=$(date -d@"${CONTACT_DATE[$i]}" '+%Y/%m/%d %H:%M:%S')
		local name=$(echo -n "${CONTACT_NAME[$i]}" | base64 -d -w0)
		if [[ ${CONTACT_ALARM[$i]} == "0" ]];
		then
			local ala="NO "
		else
			local ala="YES"
		fi
		echo -e "$((i+1)). \033[32;1mDate\033[0m: $date \033[32;1mAlarm\033[0m: $ala \033[32;1mTitle\033[0m: $name"
	done
}

function init()
{
	print_title
	get_username
	get_cron
	db_setup
	
	info "Loading database..."
	db_load
	info "Loaded ${CONTACT_LENGTH} entries from database."
	
	info "Initialization done!"
	waituser
}

function add()
{
	print_title
	echo -n "Please input the name: "
	espeak_w "Please input the name."
	read name
	
	echo -n "Please input the group: "
	espeak_w "Please input the group."
	read group
	
	echo -n "Please input the priority: "
	espeak_w "Please input the priority."
	read priority
	
	echo -n "Please input the phone number: "
	espeak_w "Please input the phone number."
	read phone
	
	echo -n "Please input the wechat: "
	espeak_w "Please input the wechat."
	read wechat
	
	echo -n "Please input the qq number: "
	espeak_w "Please input the qq number."
	read qq
	
	echo -n "Please input the email: "
	espeak_w "Please input the email."
	read email
	
	echo -n "Please input the company: "
	espeak_w "Please input the company."
	read company
	
	echo "Please input the notes (press [Ctrl+D] to finish):"
	espeak_w "Please input the notes .Attention press [Ctrl+D] to finish."
	local note=$(< /dev/stdin)
	
	contact_add "$name" "$group" "$priority" "$phone" "$wechat" "$qq" "$email" "$company" "$note"
	
	echo
	info "New Contact added!"
	espeak_w "New Contact added."
}

function edit()
{
	print_title
	if [[ ${CONTACT_LENGTH} == 0 ]];
	then
		info "There is no contacts stored in your database!"
		espeak_w "There is no contacts stored in your database."
		return
	fi
	echo "Please select the contact you want to edit from the following list:"
	espeak_w "Please select the contact you want to edit from the following list."
	contact_list

	if [[ ${CONTACT_LENGTH} == 1 ]];
	then
		option="1"
	else
		echo "You can use 0 to go back to the main menu. "
		echo -e -n "\nPlease input the index [1-${CONTACT_LENGTH}]: "
		espeak_w "Please input the index. Use 0 to go back. "
		read option
	fi

	if [[ $option == "Q" || $option == "q" || $option == "0" ]];
	then
		echo "Going back to the main menu. "
		espeak_w "Going back. "
		return
	fi
	if ! [[ $option =~ $NUMREGEX ]];
	then
		error "Please input a vaill number!"
		espeak_w "Please input a vaill number."
		return
	fi
	if ! [[ $option > 0 && $option < $((CONTACT_LENGTH+1)) ]];
	then
		error "Index Out of Range [1-${CONTACT_LENGTH}]!"
		espeak_w "Index Out of Range."
		return
	fi

	echo -e "\nSelected Contact: $option"
	espeak_w "Please select a Contact."
	((opt--))
	echo -n "Do you want to edit the name? [Y/N]: "
	espeak_w "Do you want to edit the name?Y for Yes while N for No."
	read confirm
	if [[ "$confirm" == "Y" || "$confirm" == "y" ]];
	then
		local oldname=$(echo -n "${CONTACT_NAME[$option]}" | base64 -d -w0)
		echo -e "\033[32;1mOld Name:\033[0m $oldname"
		espeak_w "The old name is $oldname."
		echo -ne "\033[32;1mNew Name:\033[0m "
		espeak_w "Please input the new name."
		read newname
		CONTACT_NAME[$option]=$(echo -n "$newname" | base64 -w0)
	fi



	echo -n "Do you want to edit the group? [Y/N]: "
	espeak_w "Do you want to edit the group?Y for Yes while N for No."
	read confirm
	if [[ "$confirm" == "Y" || "$confirm" == "y" ]];
	then
		local oldgroup=$(echo -n "${CONTACT_GROUP[$option]}" | base64 -d -w0)
		echo -e "\033[32;1mOld Group:\033[0m $oldgroup"
		espeak_w "The old group is $oldgroup."
		echo -ne "\033[32;1mNew Group:\033[0m "
		espeak_w "Please input the new group."
		read newgroup
		CONTACT_GROUP[$option]=$(echo -n "$newgroup" | base64 -w0)
	fi


	echo -n "Do you want to edit the priority? [Y/N]: "
	espeak_w "Do you want to edit the priority?Y for Yes while N for No."
	read confirm
	if [[ "$confirm" == "Y" || "$confirm" == "y" ]];
	then
		local oldpriority=$(echo -n "${CONTACT_PRI[$option]}" | base64 -d -w0)
		echo -e "\033[32;1mOld Priority:\033[0m $oldpriority"
		espeak_w "The old priority is $oldpriority."
		echo -ne "\033[32;1mNew Priority:\033[0m "
		espeak_w "Please input the new priority."
		read newpriority
		CONTACT_PRI[$option]=$(echo -n "$newpriority" | base64 -w0)
	fi



	echo -n "Do you want to edit the phone number? [Y/N]: "
	espeak_w "Do you want to edit the phone number?Y for Yes while N for No."
	read confirm
	if [[ "$confirm" == "Y" || "$confirm" == "y" ]];
	then
		local oldphone=$(echo -n "${CONTACT_PHONE[$option]}" | base64 -d -w0)
		echo -e "\033[32;1mOld Phone:\033[0m $oldphone"
		espeak_w "The old phone is $oldphone."
		echo -ne "\033[32;1mNew Phone:\033[0m "
		espeak_w "Please input the new phone."
		read newphone
		CONTACT_PHONE[$option]=$(echo -n "$newphone" | base64 -w0)
	fi



	echo -n "Do you want to edit the wechat? [Y/N]: "
	espeak_w "Do you want to edit the wehcat?Y for Yes while N for No."
	read confirm
	if [[ "$confirm" == "Y" || "$confirm" == "y" ]];
	then
		local oldwechat=$(echo -n "${CONTACT_WECHAT[$option]}" | base64 -d -w0)
		echo -e "\033[32;1mOld Wechat:\033[0m $oldwechat"
		espeak_w "The old name is $oldwechat."
		echo -ne "\033[32;1mNew Wechat:\033[0m "
		espeak_w "Please input the new wechat."
		read newwechat
		CONTACT_WECHAT[$option]=$(echo -n "$newwechat" | base64 -w0)
	fi


	echo -n "Do you want to edit the qq? [Y/N]: "
	espeak_w "Do you want to edit the qq?Y for Yes while N for No."
	read confirm
	if [[ "$confirm" == "Y" || "$confirm" == "y" ]];
	then
		local oldqq=$(echo -n "${CONTACT_QQ[$option]}" | base64 -d -w0)
		echo -e "\033[32;1mOld QQ:\033[0m $oldqq"
		espeak_w "The old qq is $oldqq."
		echo -ne "\033[32;1mNew QQ:\033[0m "
		espeak_w "Please input the new qq."
		read newqq
		CONTACT_QQ[$option]=$(echo -n "$newqq" | base64 -w0)
	fi




	echo -n "Do you want to edit the email? [Y/N]: "
	espeak_w "Do you want to edit the email?Y for Yes while N for No."
	read confirm
	if [[ "$confirm" == "Y" || "$confirm" == "y" ]];
	then
		local oldmail=$(echo -n "${CONTACT_EMAIL[$option]}" | base64 -d -w0)
		echo -e "\033[32;1mOld Email:\033[0m $oldmail"
		espeak_w "The old Email is $oldmail."
		echo -ne "\033[32;1mNew Email:\033[0m "
		espeak_w "Please input the new Email."
		read newemail
		CONTACT_EMAIL[$option]=$(echo -n "$newemail" | base64 -w0)
	fi




	echo -n "Do you want to edit the company? [Y/N]: "
	espeak_w "Do you want to edit the company?Y for Yes while N for No."
	read confirm
	if [[ "$confirm" == "Y" || "$confirm" == "y" ]];
	then
		local oldcompany=$(echo -n "${CONTACT_COMPANY[$option]}" | base64 -d -w0)
		echo -e "\033[32;1mOld Company:\033[0m $oldcompany"
		espeak_w "The old company is $oldcompany."
		echo -ne "\033[32;1mNew Company:\033[0m "
		espeak_w "Please input the new company."
		read newcompany
		CONTACT_COMPANY[$option]=$(echo -n "$newcompany" | base64 -w0)
	fi


	echo -n "Do you want to edit the note? [Y/N]: "
	espeak_w "Do you want to edit the note?Y for Yes while N for No."
	read confirm
	if [[ "$confirm" == "Y" || "$confirm" == "y" ]];
	then
		local oldnote=$(echo -n "${CONTACT_NOTE[$option]}" | base64 -d -w0)
		echo -e "\033[32;1mOld Note:\033[0m \n$oldnote"
		espeak_w "The ole note is $oldnote."
		echo -e "\033[32;1mNew Note:\033[0m (press [Ctrl+D to finish]"
		espeak_w "Please input a new note.Attention (press [Ctrl+D to finish]."
		local newnote=$(< /dev/stdin)
		CONTACT_NOTE[$option]=$(echo -n "$newnote" | base64 -w0)
	fi

	echo
	info "Done!"
}

function del()
{
	print_title
	if [[ ${CONTACT_LENGTH} == 0 ]];
	then
		info "There is no contacts stored in your database!"
		espeak_w "There is no contacts stored in your database!"
		return
	fi
	echo "Please select the contact you want to delete from the following list: "
	espeak_w "Please select the contact you want to delete from the following list. "
	contact_list

	if [[ ${CONTACT_LENGTH} == 1 ]];
	then
		option="1"
	else
		echo "You can use 0 to go back to the main menu. "
		echo -e -n "\nPlease input the index [1-${CONTACT_LENGTH}]: "
		espeak_w "Please input the index. Use 0 to go back. "
		read option
	fi

	if [[ $option == "Q" || $option == "q" || $option == "0" ]];
	then
		echo "Going back to the main menu. "
		espeak_w "Going back. "
		return
	fi
	if ! [[ $option =~ $NUMREGEX ]];
	then
		error "Please input a vaill number!"
		espeak_w "Please input a vaill number."
		return
	fi
	if ! [[ $option > 0 && $option < $((CONTACT_LENGTH+1)) ]];
	then
		error "Index Out of Range [1-${CONTACT_LENGTH}]!"
		espeak_w "Index Out of Range ."
		return
	fi

	echo -e "\nSelected Contact: $option"
	espeak_w "Please select a Contact."
	echo -e "\033[31;1mDO YOU REALLY WANT TO DELETE THIS CONTACT?\033[0m"
	espeak_w "DO YOU REALLY WANT TO DELETE THIS CONTACT?"
	echo -n "[Input YES to continue, else to abort]: "
	espeak_w "Input YES to continue, else to abort. "
	read confirm

	if [[ $confirm == "YES" ]];
	then
		contact_del $option
		echo "Done!"
		espeak_w "Done."
	else
		echo "Aborted."
		espeak_w "Aborted."
	fi
}

function alarm()
{
	print_title
	if [[ ${CONTACT_LENGTH} == 0 ]];
	then
		info "Sorry, there is no contacts stored in your database! "
		espeak_w "Sorry, there is no contacts stored in your database! "
		return
	fi
	echo "Please select the contact you want to set/cancel alarm from the following list: "
	espeak_w "Please select the contact you want to set or cancel alarm from the following list. "
	contact_list

	if [[ ${CONTACT_LENGTH} == 1 ]];
	then
		option="1"
	else
		echo "You can use 0 to go back to the main menu. "
		echo -en "\nPlease input the index [1-${CONTACT_LENGTH}]: "
		espeak_w "Please input the index. Use 0 to go back. "
		read option
	fi

	if [[ $option == "Q" || $option == "q" || $option == "0" ]];
	then
		echo "Going back to the main menu. "
		espeak_w "Going back. "
		return
	fi
	if ! [[ $option =~ $NUMREGEX ]];
	then
		error "Please input a vaill number!"
		espeak_w "Please input a vaill number."
		return
	fi
	if ! [[ $option > 0 && $option < $((CONTACT_LENGTH+1)) ]];
	then
		error "Index Out of Range [1-${CONTACT_LENGTH}]!"
		espeak_w "Index Out of Range."
		return
	fi
	echo -e "\nSelected Contact: $option"
	((opt--))
	if [[ ! ${CONTACT_ALARM[$option]} == '0' ]];
	then
		CONTACT_ALARM[$option]='0'
		((opt++)) # Related to the index shown
		info "Selected Contact $option alarm is now cancelled. "
		espeak_w "Selected Contact $option alarm is now cancelled. "
		return
	fi
	espeak_w "Please select a contact. "
	echo -e "Set an alarm to remind yourself to call back! "
	espeak_w "Set an alarm to remind yourself to call back! "
	echo -e "The format is as flollows: "
	espeak_w "The format is as flollows. "
	echo -e "Month/Day Hour:Minute"
	espeak_w "Month/Day Hour:Minute"
	echo -e "Note that this is a 24-hour schedule"
	espeak_w "Note that this is a 24-hour schedule"

	echo -ne "Input: "
	read alarm_date

	local alarm_ts=$(date -d"$(date +%Y)/$alarm_date:00" +%s)
	if [[ -z "$alarm_ts" ]];
	then
		error "$alarm_date is not a vaild date! "
		espeak_w "$alarm_date is not a vaild date! "
		return
	fi
	local now=$(date +%s)
	if [[ (( alarm_ts -le now)) ]];
	then
		error "Alarm date should not be earlier than present time. "
		espeak_w "Alarm date should not be earlier than present time. "
		return
	fi
	local month=$(date -d@"$alarm_ts" +%m)
	local day=$(date -d@"$alarm_ts" +%d)
	local hour=$(date -d@"$alarm_ts" +%H)
	local min=$(date -d@"$alarm_ts" +%M)

	local date=${CONTACT_DATE[$option]}
	add_alarm_command_to_cron $date $month $day $hour $min
	if [[ $? -eq 1 ]];
	then
		CONTACT_ALARM[$option]=$alarm_ts
		echo "Done! Your contact will be alarmed at $(date -d@"$alarm_ts" '+%Y/%m/%d %H:%M:%S')"
		espeak_w "Done! Your contact will be alarmed at $(date -d@"$alarm_ts" '+%Y/%m/%d %H:%M:%S')"
	fi
}

function list()
{
	print_title
	if [[ ${CONTACT_LENGTH} == 0 ]];
	then
		info "There is no contacts stored in your database!"
		espeak_w "There is no contacts stored in your database!"
		return
	fi
	echo "Available Contact:"
	espeak_w "Available Contact is as followed."
	contact_list
	
	if [[ ${CONTACT_LENGTH} == 1 ]];
	then
		echo -en "\nPlease input 1 to view contact context, or Q to return to menu: "
		espeak_w "Please input 1 to view contact context, or Q to return to menu."
	else
		echo -en "\nPlease input [1-${CONTACT_LENGTH}] to view contact context, or Q to return to menu: "
		espeak_w "Please input [1-${CONTACT_LENGTH}] to view contact context, or Q to return to menu."
	fi
	read option

	while :
	do
		if [[ $option == "Q" || $option == "q" || $option == "0" ]];
		then
			return
		elif ! [[ $option =~ $NUMREGEX ]];
		then
			error "Please input a vaill number!"
			espeak_w "Please input a vaill number."
		elif ! [[ $option > 0 && $option < $((CONTACT_LENGTH+1)) ]];
		then
			error "Index Out of Range [1-${CONTACT_LENGTH}]!"
			espeak_w "Index out of range."
		else
			print_title
			((opt--))
			local date=$(date -d@"${CONTACT_DATE[$option]}" '+%Y/%m/%d %H:%M:%S')
			local name=$(echo -n "${CONTACT_NAME[$option]}" | base64 -d -w0)
			local group=$(echo -n "${CONTACT_GROUP[$option]}" | base64 -d -w0)
		
		
			local priority=$(echo -n "${CONTACT_PRI[$option]}" | base64 -d -w0)
			local phone=$(echo -n "${CONTACT_PHONE[$option]}" | base64 -d -w0)
		

			local wechat=$(echo -n "${CONTACT_WECHAT[$option]}" | base64 -d -w0)
			local qq=$(echo -n "${CONTACT_QQ[$option]}" | base64 -d -w0)


			local email=$(echo -n "${CONTACT_EMAIL[$option]}" | base64 -d -w0)
			local company=$(echo -n "${CONTACT_COMPANY[$option]}" | base64 -d -w0)


			local note=$(echo -n "${CONTACT_NOTE[$option]}" | base64 -d -w0)
			

			echo -e "\033[32;1mDate\033[0m: $date"
			espeak_w "Date: $date."
			echo -e "\033[32;1mName\033[0m: $name"
			espeak_w "Name:$name."
			echo -e "\033[32;1mGroup\033[0m: $group"
			espeak_w "Group:$group."
			echo -e "\033[32;1mPriority\033[0m: $priority"
			espeak_w "Priority:$priority"
		
		
		
			echo -e "\033[32;1mPhone\033[0m: $phone"
			espeak_w "Phone:$phone."
			echo -e "\033[32;1mWechat\033[0m: $wechat"
			espeak_w "Wechat:$wechat."
			echo -e "\033[32;1mQQ\033[0m: $qq"
			espeak_w "QQ:$qq"


			echo -e "\033[32;1mEmail\033[0m: $email"
			espeak_w "Email:$email."
			echo -e "\033[32;1mCompany\033[0m: $company"
			espeak_w "Company:$company."
			echo -e "\033[32;1mNote\033[0m: \n$note\n"
			espeak_w "Note:$note"
		
			waituser
			list
			return
		fi
		echo -n "Input:"
		read option
	done
}

function exit_program()
{
	clear
	info "Saving database..."
	db_save
	info "Saved ${CONTACT_LENGTH} entries to database."
	echo -e "\n\033[32;1mThank you for using Universal Contact. \nWish you a better tomorrow! \033[0m"
	espeak_w "Thanks for using our program. Have a nice day!"
	exit $EXIT_SUCCESS
}

function menu()
{
	print_title
	echo -e "\033[32;1mWelcome, ${USERNAME}! \033[0m\n"
	espeak_w "Welcome, ${USERNAME}! "

	echo "Available Options:  "
	echo -e "\t1 = \033[32m[A]\033[0mdd Contact"
	echo -e "\t2 = \033[32m[D]\033[0melete Contact"
	echo -e "\t3 = \033[32m[E]\033[0mdit Contact"
	echo -e "\t4 = \033[32m[L]\033[0mist Contact"
	echo -e "\t5 = \033[32m[S]\033[0met Alarm for a Contact"
	echo -e "\t0 = \033[32m[Q]\033[0muit this program"

	echo -ne "\nPlease select an option to continue [A/D/E/L/S/Q]: "
	espeak_w "Please select an option."
	read option
	
	case $option in
		"1" | "A" | "a")
			add
		;;
		"2" | "D" | "d")
			del
		;;
		"3" | "E" | "e")
			edit
		;;
		"4" | "L" | "l")
			list
		;;
		"5" | "S" | "s")
			alarm
		;;
		"0" | "Q" | "q")
			exit_program
		;;
		*)
			error "Unknow option!"
			espeak_w "Unkow option."
		;;
	esac
	
	waituser
}

function add_command()
{
	if [[ $ARGC < 3 ]];
	then
		echo "USAGE ${ADD_HELP}"
		return
	fi
	local name=${ARGV[1]}
	local group=${ARGV[2]}
	local priority=${ARGV[3]}
	local phone=${ARGV[4]}
	local wechat=${ARGV[5]}
	local qq=${ARGV[6]}
	local email=${ARGV[7]}
	local company=${ARGV[8]}
	local note=${ARGV[9]}
	
	db_load
	contact_add "$name" "$group" "$priority" "$phone" "$wechat" "$qq" "$email" "$company" "$note"
	db_save
	espeak_w "Please input the name: "
	echo -e "\033[32;1mName\033[0m: $name"
	
	espeak_w "Please input the group: "
	echo -e "\033[32;1mGroup\033[0m: $group"
	
	espeak_w "Please input the priority: "
	echo -e "\033[32;1mPriority\033[0m: $priority"
	
	espeak_w "Please input the phone: "
	echo -e "\033[32;1mPhone\033[0m: $phone"
	
	espeak_w "Please input the wechat: "
	echo -e "\033[32;1mWechat\033[0m: $wechat"
	
	espeak_w "Please input the QQ: "
	echo -e "\033[32;1mQQ\033[0m: $qq"
	
	espeak_w "Please input the Email: "
	echo -e "\033[32;1mEmail\033[0m: $email"
	
	espeak_w "Please input the company: "
	echo -e "\033[32;1mCompany\033[0m: $company"
	
	espeak_w "Please input the note: "
	echo -e "\033[32;1mNote\033[0m: \n$note\n"
	info "New Contact added!"
	espeak_w "New Contact added! "
}

function edit_command()
{
	if [[ $ARGC < 4 ]];
	then
		echo "USAGE ${EDIT_HELP}"
		return
	fi
	local idx=${ARGV[1]}
	local type=${ARGV[2]}
	local new=${ARGV[3]}
	
	db_load
	if [[ ${CONTACT_LENGTH} == 0 ]];
	then
		info "There is no contacts stored in your database!"
		espeak_w "There is no contacts stored in your database."
		return
	fi
	if ! [[ $idx =~ $NUMREGEX ]];
	then
		error "$idx is not a vaill number!"
		espeak_w "$idx is not a vaill number."
		return
	fi
	if ! [[ $idx > 0 && $idx < $((CONTACT_LENGTH+1)) ]];
	then
		error "Index Out of Range [1-${CONTACT_LENGTH}]!"
		espeak_w "Index Out of Range."
		return
	fi
	((idx--))
	case $type in
		"name")
			CONTACT_NAME[$idx]=$(echo -n "$new" | base64 -w0)
		;;
		"group")
			CONTACT_CONTEXT[$idx]=$(echo -n "$new" | base64 -w0)
		;;
		"priority")
			CONTACT_PRI[$idx]=$(echo -n "$new" | base64 -w0)
		;;	

		"phone")
			CONTACT_PHONE[$idx]=$(echo -n "$new" | base64 -w0)
		;;
		"wechat")
			CONTACT_WECHAT[$idx]=$(echo -n "$new" | base64 -w0)
		;;
		"qq")
			CONTACT_QQ[$idx]=$(echo -n "$new" | base64 -w0)
		;;

		"email")
			CONTACT_EMAIL[$idx]=$(echo -n "$new" | base64 -w0)
		;;
		"company")
			CONTACT_COMPANY[$idx]=$(echo -n "$new" | base64 -w0)
		;;
		"note")
			CONTACT_NOTE[$idx]=$(echo -n "$new" | base64 -w0)
		;;
		*)
			error "Unknow type!"
		;;
	esac
	db_save
	echo "Done!"
}

function del_command()
{
	if [[ $ARGC < 2 ]];
	then
		echo "USAGE ${DEL_HELP}"
		return
	fi
	local idx=${ARGV[1]}
	
	db_load
	if [[ ${CONTACT_LENGTH} == 0 ]];
	then
		info "There is no contacts stored in your database!"
		espeak_w "There is no contacts stored in your database."
		return
	fi
	if ! [[ $idx =~ $NUMREGEX ]];
	then
		error "$idx is not a vaill number!"
		espeak_w "$idx is not a vaill number!"
		return
	fi
	if ! [[ $idx > 0 && $idx < $((CONTACT_LENGTH+1)) ]];
	then
		error "Index Out of Range [1-${CONTACT_LENGTH}]!"
		espeak_w "Index Out of Range."
		return
	fi
	contact_del $idx
	db_save
	echo "Done!"
}

function list_command()
{
	if [[ $ARGC < 2 ]];
	then
		db_load
		if [[ ${CONTACT_LENGTH} == 0 ]];
		then
			info "There is no contacts stored in your database!"
			espeak_w "There is no contacts stored in your database."
			return
		fi
		echo "Available Contact:"
		espeak_w "Available Contact."
		contact_list
	else
		local idx=${ARGV[1]}
		
		db_load
		if [[ ${CONTACT_LENGTH} == 0 ]];
		then
			info "There is no contacts stored in your database!"
			espeak_w "There is no contacts stored in your database!"
			return
		fi
		if ! [[ $idx =~ $NUMREGEX ]];
		then
			error "$idx is not a vaill number!"
			espeak_w "$idx is not a vaill number!"
			return
		fi
		if ! [[ $idx > 0 && $idx < $((CONTACT_LENGTH+1)) ]]; then
			error "Index Out of Range [1-${CONTACT_LENGTH}]!"
			espeak_w "Index Out of Range [1-${CONTACT_LENGTH}]!"
			return
		fi
		((idx--))
		local date=$(date -d@"${CONTACT_DATE[$idx]}" '+%Y/%m/%d %H:%M:%S')
		local name=$(echo -n "${CONTACT_NAME[$idx]}" | base64 -d -w0)
		local group=$(echo -n "${CONTACT_GROUP[$idx]}" | base64 -d -w0)
		local priority=$(echo -n "${CONTACT_PRI[$idx]}" | base64 -d -w0)
		local phone=$(echo -n "${CONTACT_PHONE[$idx]}" | base64 -d -w0)
	

		local wechat=$(echo -n "${CONTACT_WECHAT[$idx]}" | base64 -d -w0)
		local qq=$(echo -n "${CONTACT_QQ[$idx]}" | base64 -d -w0)
		local email=$(echo -n "${CONTACT_EMAIL[$idx]}" | base64 -d -w0)
		local company=$(echo -n "${CONTACT_COMPANY[$idx]}" | base64 -d -w0)
		local note=$(echo -n "${CONTACT_NOTE[$idx]}" | base64 -d -w0)


		echo -e "\033[32;1mDate\033[0m: $date"
		espeak_w "Date:$date"
		echo -e "\033[32;1mName\033[0m: $name"
		espeak_w "Name:$name."
		echo -e "\033[32;1mGroup\033[0m: $group"
		espeak_w "Group:$group."
		echo -e "\033[32;1mPriority\033[0m: $priority"
		espeak_w "Priority:$priority"			
		echo -e "\033[32;1mPhone\033[0m: $phone"
		espeak_w "Phone:$phone."
		echo -e "\033[32;1mWechat\033[0m: $wechat"
		espeak_w "Wechat:$wechat."
		echo -e "\033[32;1mQQ\033[0m: $qq"
		espeak_w "QQ:$qq"


		echo -e "\033[32;1mEmail\033[0m: $email"
		espeak_w "Email:$email."
		echo -e "\033[32;1mCompany\033[0m: $company"
		espeak_w "Company:$company."
		echo -e "\033[32;1mNote\033[0m: \n$note\n"
		espeak_w "Note:$note"
	
	
	fi
}

function alarm_command()
{
	if [[ $ARGC < 2 ]];
	then
		echo "USAGE ${ALARM_HELP}"
		return
	fi
	local idx=${ARGV[1]}
	local alarm_date=${ARGV[2]}
	
	db_load
	if [[ ${CONTACT_LENGTH} == 0 ]];
	then
		info "There is no contacts stored in your database!"
		espeak_w "There is no contacts stored in your database!"
		return
	fi
	if ! [[ $idx =~ $NUMREGEX ]];
	then
		error "$idx is not a vaill number!"
		espeak_w "$idx is not a vaill number!"
		return
	fi
	if ! [[ $idx > 0 && $idx < $((CONTACT_LENGTH+1)) ]];
	then
		error "Index Out of Range [1-${CONTACT_LENGTH}]!"
		espeak_w "Index Out of Range."
		return
	fi
	((idx--))
	local date=${CONTACT_DATE[$idx]}
	
	IFS='-' read -ra alarm_date <<< "$alarm_date"
	if [[ ${#alarm_date[@]} == 2 ]];
	then
		local month=$(date +%m)
		local day=$(date +%d)
		local hour=${alarm_date[0]}
		local min=${alarm_date[1]}
	elif [[ ${#alarm_date[@]} == 4 ]];
	then
		local month=${alarm_date[0]}
		local day=${alarm_date[1]}
		local hour=${alarm_date[2]}
		local min=${alarm_date[3]}
	else
		return
	fi
	local alarm_ts=$(date -d"$(date +%Y)/$month/$day $hour:$min:00" +%s)
	if [[ "$?" != "0" ]];
	then
		error "$alarm_date is not a vaild date!"
		espeak_w "$alarm_date is not a vaild date!"
		return
	fi
	local now=$(date +%s)
	if [[ (( alarm_ts -le now)) ]];
	then
		error "alarm date should not be earlier than present time"
		espeak_w "alarm date should not be earlier than present time."
		return
	fi
	
	add_alarm_command_to_cron $date $month $day $hour $min
	CONTACT_ALARM[$idx]=$alarm_ts
	
	db_save
	echo "Done!"
}

function do_alarm_command()
{
	if [[ $ARGC < 1 ]];
	then
		return
	fi
	local alarm_date=${ARGV[1]}
	
	db_load
	if [[ ${CONTACT_LENGTH} == 0 ]];
	then
		return
	fi
	local idx=0
	while [[ $idx < ${CONTACT_LENGTH} ]];
	do
		if [[ ${CONTACT_DATE[$idx]} == $alarm_date ]];
		then
			break
		fi
		((idx++))
	done
	if [[ $idx -ge ${CONTACT_LENGTH} ]];
	then
		error "Cannot find contact (date: $date)"
		espeak_w "Cannot find contact ."
		return
	fi
	if [[ ${CONTACT_ALARM[$idx]} == '0' ]];
	then
		error "Alarm not enabled"
		espeak_w "Alarm not enabled"
		return
	fi
	local date=$(date -d@"${CONTACT_DATE[$idx]}" '+%Y/%m/%d %H:%M:%S')
	local name=$(echo -n "${CONTACT_NAME[$idx]}" | base64 -d -w0)
	local group=$(echo -n "${CONTACT_GROUP[$idx]}" | base64 -d -w0)
	local priority=$(echo -n "${CONTACT_PRI[$idx]}" | base64 -d -w0)
	local phone=$(echo -n "${CONTACT_PHONE[$idx]}" | base64 -d -w0)

	local wechat=$(echo -n "${CONTACT_WECHAT[$idx]}" | base64 -d -w0)
	local qq=$(echo -n "${CONTACT_QQ[$idx]}" | base64 -d -w0)
	local email=$(echo -n "${CONTACT_EMAIL[$idx]}" | base64 -d -w0)
	local company=$(echo -n "${CONTACT_COMPANY[$idx]}" | base64 -d -w0)
	local note=$(echo -n "${CONTACT_NOTE[$idx]}" | base64 -d -w0)


	local msg=">> \033[32;5m\033[47m\033[1mALARM!!!\033[0m <<\n"
	local msg="${msg}\033[32;1mDate\033[0m: $date\n"
	local msg="${msg}\033[32;1mName\033[0m: $name\n"
	local msg="${msg}\033[32;1mGroup\033[0m: $group\n"
	local msg="${msg}\033[32;1mPriority\033[0m: $priority\n"
	


	local msg="${msg}\033[32;1mPhone\033[0m: $phone\n"
	local msg="${msg}\033[32;1mWechat\033[0m: $wechat\n"
	local msg="${msg}\033[32;1mQQ\033[0m: $qq\n"
	local msg="${msg}\033[32;1mEmail\033[0m: $email\n"


	local msg="${msg}\033[32;1mCompany\033[0m: $company\n"
	local msg="${msg}\033[32;1mNote\033[0m: \n$note\n"
	

	send_alarm_to_tty "$msg"
	
	CONTACT_ALARM[$idx]=0
	local regex="/## CONTACT:${USERNAME}:${alarm_date} START##/,/## CONTACT:${USERNAME}:${alarm_date} END##/d"
	sed -i "$regex" "${CRON_DIR_PATH}/${USERNAME}"
	
	db_save
}

function help_command()
{
	echo "USAGE ${ADD_HELP}"
	echo "USAGE ${EDIT_HELP}"
	echo "USAGE ${DEL_HELP}"
	echo "USAGE ${LIST_HELP}"
	echo "USAGE ${ALARM_HELP}"
}

function dispose_command()
{
	echo
	local option=${ARGV[0]}
	case $option in
		"add")
			add_command
		;;
		"edit")
			edit_command
		;;
		"del")
			del_command
		;;
		"list")
			list_command
		;;
		"alarm")
			alarm_command
		;;
		"help")
			help_command
		;;
		"do_alarm")
			do_alarm_command
		;;
		*)
			error "Unknow option!"
			espeak_w "Unknow option!"
			exit $EXIT_FAILURE
		;;
	esac
}

encrypted_result=""

function encrypt()
{
	encrypted_result=`echo -n "$*" | base64`
}

function verify()
{
	verify_commandline="$1 $2"
	$verify_commandline
	if [[ ! "$encrypted_result" == "$3" ]];
	then
		error "The title has been modified, program exited due to security factors. "
		espeak_w "The title has been modified, program exited due to security factors. "
		exit $EOF
	fi
	contact_path=`readlink -m $0`
	contact_sha256=`sha256sum "$contact_path" | awk '{print $1}'`
	correct_sha256=`curl https://cloud-inspired.goosebt.com/contact.txt 2>/dev/null`
	if [[ ! "$contact_sha256" =~ "$contact_sha256" ]];
	then
		error "This file has been modified, program exited due to security factors. "
		espeak_w "This file has been modified, program exited due to security factors. "
		exit $EOF
	fi
	espeak_w "Please enter your serial number: "
	echo -n "Please enter your serial number: "
	read auth
	auth_sha256=`echo -n "$auth" | sha256sum | awk '{print $1}'`
	if [[ ! "$correct_sha256" =~ "$auth_sha256" ]];
	then
		error "Sorry, you have no access. "
		espeak_w "Sorry, you have no access. "
		exit $EOF
	fi
}

verify "encrypt" "$PROGRAMNAME" "VW5pdmVyc2FsIENvbnRhY3Q="



# Init program
if ! [[ ${ARGV[0]} == "help" ]];
then
	init
fi

if [[ $ARGC == 0 ]];
then
	while :
	do
		menu 
	done
else
	dispose_command
fi

exit $EXIT_SUCCESS
