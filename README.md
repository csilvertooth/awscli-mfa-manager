# awscli-mfa-manager
An easier way to manage multiple AWS accounts with MFA via CLI

## Purpose:

If you manage multiple Amazona Web Serivce (AWS) accounts and they leverage MFA for a secondary form of authentication if becomes cumbersome to login.  This script will make the process a bit easier I hope.

## Requirements:

This only works on Mac OS currently though it could be adapted easily to work on Linux.  Therefore Mac OS is a requirement and as of writing only Catalina (10.15) has been tested.

An AWS Credentials file formatted like the following:


[AWS Account 1]<br>
region=us-west-2<br>
aws_access_key_id=access_key_goes_here<br>
aws_secret_access_key=access_secret_access_key_goes_here<br>
mfa_serial=arn:aws:iam::012345678901:mfa/username<br>


[AWS Account 2]<br>
region=us-west-2<br>
aws_access_key_id=access_key_goes_here<br>
aws_secret_access_key=access_secret_access_key_goes_here<br>
mfa_serial=arn:aws:iam::012345678901:mfa/username<br>


[AWS Account 3]<br>
region=us-west-1<br>
aws_access_key_id=access_key_goes_here<br>
aws_secret_access_key=access_secret_access_key_goes_here<br>
mfa_serial=arn:aws:iam::012345678901:mfa/username<br>



This file should be located in your /Users/username/.aws directory.

## How to use

This is a bash executable.  .Command files in OS X can be double clicked from the Finder to be run.  If it isn't working then most likely the permissions need to be set to executable.  Run the following on aws-mfa.command in a terminal window:  chmod +x aws-mfa.command

Once your permissions are set just double click the file to launch.

If you do not have a credentials file in your .aws directory it will attempt to create one.  This is very rudimentary and doesn't do any error checking.  If you put in bogus data it will accept it and write the credentials file out that way.

If you have already created a "credentials" file then it will attempt to read it and then present you with login options.

Once you have authenticated with MFA it will open a new window that can be used to access the AWS account you authenticated with.
Only this terminal window is authorized to access the AWS account.  If you close it your sessions will end.

## NOTE

If you would like to open more sessions with the current authentication you just need to pasted the source text found at the top of the first terminal window opened into a new window.

example "source $HOME/.Ag2th"

