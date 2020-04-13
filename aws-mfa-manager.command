#!/bin/bash
#  aws-mfa.sh(command)
#  
#  Created by Christopher Silvertooth on 3/24/2020.
#
wDir="`dirname \"$0\"`"
IFS=$'\n'


function create_credential () {
    
    echo -e "Enter AWS Account Name (No Spaces): "
    read AWSName
    AWSNameFmt=`echo $AWSName | sed -e 's/ /-/g'`
    echo "You entered $AWSNameFmt as the AWS Account Name.  Press 1 if it is correct: "
    #echo "You entered $AWSName as the AWS Account Name.  Press 1 if it is correct: "
    read CONTINUE
    if [[ $CONTINUE == 1 ]]
        then
        echo "Continuing."
        else
        echo -e "Enter AWS Account Name: "
        read AWSName
        read CONTINUE 
    fi

    echo "[$AWSNameFmt]" >> $credFile
    
    echo -e "Enter region: "
    read region
    echo "region=$region" >> $credFile

    echo -e "Enter AWS Access Key ID: "
    read awsaccesskeyid
    echo "aws_access_key_id=$awsaccesskeyid" >> $credFile

    echo -e "Enter AWS Secret Access Key: "
    read awssecretaccesskey
    echo "aws_secret_access_key=$awssecretaccesskey" >> $credFile

    echo -e "Enter MFA Serial: "
    read mfaserialarn
    echo "mfa_serial=$mfaserialarn" >> $credFile

    echo \n >> $credFile
    echo "Would you like to create more credential entries? y/n : "

    read create_more_creds_unmodified
    create_more_creds=`echo $create_more_creds_unmodified | tr [:upper:] [:lower:] | cut -c 1`
}


function get_mfa_auth () {

    echo Enter MFA Code:
    read MFACode
}

function create_session () {

aws --profile $awsProfile sts get-session-token --duration 86400 \
--serial-number $arnMFA --token-code $MFACode --output text \
| awk '{printf("export AWS_ACCESS_KEY_ID=\"%s\"\nexport AWS_SECRET_ACCESS_KEY=\"%s\"\nexport AWS_SESSION_TOKEN=\"%s\"\nexport AWS_SECURITY_TOKEN=\"%s\"\n",$2,$4,$5,$5)}' | tee ~/.$awsProfile

}

echo "           ********************************************************"
echo "           *             AWS CLI MFA Authenticator                *"
echo "           *                                                      *"
echo "           ********************************************************"
echo

credFile="$HOME/.aws/credentials"

# Check for .aws directory
if [[ -d $HOME/.aws ]]
    then
        echo "AWS Directory found."
    else
        echo "No AWS Directoty found.  Lets setup a credential file."
        mkdir $HOME/.aws
        create_credential
fi

# Check for aws credentials file
if [[ -f $HOME/.aws/credentials ]]
    then
        echo "Credentials file found."
    else
        echo "No AWS Credentials file found.  Lets setup a credential file."
        touch $credFile
    
    create_credential
    while [ $create_more_creds == "y" ];
        do
            create_credential
        done
        echo "Credential creation complete."
fi



ProfileArray=($(awk '/\[/,/\]/' $credFile | sed -e 's/\[\(.*\)\]/\1/'))
title="Choose AWS Profile "
prompt="Pick a profile:"

echo "$title"
PS3="$prompt "

select awsProfile in "${ProfileArray[@]}" "Quit"; do
        echo $REPLY
            if (( REPLY == 1 + ${#ProfileArray[@]} )) ; then
                echo "Quitting."
                break
            elif (( REPLY > 0 && REPLY < ${#ProfileArray[@]} )) ; then
                echo  "You picked $awsProfile." #which is file $REPLY
                arnMFA=($(awk '/\'$awsProfile'/,/\'${ProfileArray[$REPLY]}'/' $HOME/.aws/credentials | grep -v $awsProfile | grep -v ${ProfileArray[$awsProfile]} | grep -v -e '^[[:space:]]*$' | grep -e "mfa_serial" | sed 's/mfa_serial=//g' ))
                echo "Authentication with "$arnMFA
                get_mfa_auth
                create_session
                osascript -e 'tell application "Terminal" to do script "source $HOME/.'$awsProfile'"'
            elif (( REPLY == ${#ProfileArray[@]} )) ; then
                echo  "You picked $awsProfile." #which is file $REPLY
                arnMFA=($(awk '/\'$awsProfile'/,/\'NR'/' $HOME/.aws/credentials | grep -v $awsProfile | grep -v ${ProfileArray[$awsProfile]} | grep -v -e '^[[:space:]]*$' | grep -e "mfa_serial" | sed 's/mfa_serial=//g' ))
                echo "Authentication with "$arnMFA
                get_mfa_auth
                create_session
                osascript -e 'tell application "Terminal" to do script "source $HOME/.'$awsProfile'"'
            else
            echo "Invalid option. Try another one."
            fi
done
