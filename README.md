# awscli-mfa-manager
An easier way to manage multiple AWS accounts with MFA via CLI

## Purpose:

If you manage multiple Amazon Web Serivce (AWS) accounts and they leverage MFA for a secondary form of authentication it becomes cumbersome to login at the CLI.  This script will make the process a bit easier I hope.

## Requirements:

This only works on Mac OS currently though it could be adapted easily to work on Linux.  Therefore Mac OS is a requirement and as of writing only Catalina (10.15) has been tested.

An AWS Credentials file formatted like the following:

`[AWS Account 1]`<br>
`region=us-west-2<`br>
`aws_access_key_id=access_key_goes_here`<br>
`aws_secret_access_key=access_secret_access_key_goes_here`<br>
`mfa_serial=arn:aws:iam::012345678901:mfa/username`<br>


`[AWS Account 2]`<br>
`region=us-west-2`<br>
`aws_access_key_id=access_key_goes_here`<br>
`aws_secret_access_key=access_secret_access_key_goes_here`<br>
`mfa_serial=arn:aws:iam::012345678901:mfa/username`<br>


`[AWS Account 3]`<br>
`region=us-west-1`<br>
`aws_access_key_id=access_key_goes_here`<br>
`aws_secret_access_key=access_secret_access_key_goes_here`<br>
`mfa_serial=arn:aws:iam::012345678901:mfa/username`<br>


This file should be located in your /Users/username/.aws directory.

You also need to create your access key and MFA setup for AWS Cli.  See the Notes Section for more info.<br>

The MFA serial, access keys, etc are all located under your "My Security Credentials"  page in the AWS Management console.  The mfa_serial is under the section labled "Multi-factor authentication".  You need the whole line starting with arn and ending with your username.  Do not include the part in parenthesis.

For Example<br>
<br>
`arn:aws:iam::012345678901:mfa/username`


## How to use

This is a bash executable.  A Dot Command file, it looks like filename.command in OS X, can be double clicked from the Finder to be run.  If it isn't working then most likely the permissions need to be set to executable.  Run the following on the aws-mfa.command file in a terminal window:  chmod +x aws-mfa.command

Once your permissions are set just double click the file to launch.

If you do not have a credentials file in your .aws directory it will attempt to create one.  This is very rudimentary and doesn't do any error checking AT ALL.  If you put in bogus data it will accept it and write the credentials file out that way.

If you have already created a "credentials" file then it will attempt to read it and then present you with login options.  I advise that you back it up in case bad things happen.

Once you have authenticated with MFA it will open a new window that can be used to access the AWS account you authenticated with.
Only this terminal window is authorized to access the AWS account.  If you close it your sessions will end.

## Notes

If you would like to open more sessions with the current authentication you just need to paste the source text found at the top of the first terminal window opened into a new window.

example "source $HOME/.Ag2th"

If it ruins everything on your computer... Sorry.

### URLs that are helpful in understanding how this works.

`Creating Access Keys in AWS - ` https://aws.amazon.com/premiumsupport/knowledge-center/create-access-key/

`Authenticating with MFA - ` https://aws.amazon.com/premiumsupport/knowledge-center/authenticate-mfa-cli/

`MFA in AWS - ` https://docs.aws.amazon.com/IAM/latest/UserGuide/id_credentials_mfa.html


