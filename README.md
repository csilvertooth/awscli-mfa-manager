# awscli-mfa-manager
An easier way to manage multiple AWS accounts with MFA via CLI

## Purpose:

If you manage multiple Amazona Web Serivce (AWS) accounts and they leverage MFA for a secondary form of authentication if becomes cumbersome to login.  This script will make the process a bit easier I hope.

## Requirements:

This only works on Mac OS currently though it could be adapted easily to work on Linux.  Therefore Mac OS is a requirement and as of writing only Catalina (10.15) has been tested.

An AWS Credentials file formatted like the following:

[AWS Account 1]
region=us-west-2
aws_access_key_id=access_key_goes_here
aws_secret_access_key=access_secret_access_key_goes_here
mfa_serial=arn:aws:iam::012345678901:mfa/username

[AWS Account 2]
region=us-west-2
aws_access_key_id=access_key_goes_here
aws_secret_access_key=access_secret_access_key_goes_here
mfa_serial=arn:aws:iam::012345678901:mfa/username

[AWS Account 3]
region=us-west-1
aws_access_key_id=access_key_goes_here
aws_secret_access_key=access_secret_access_key_goes_here
mfa_serial=arn:aws:iam::012345678901:mfa/username


This file should be located in your /Users/username/.aws directory.

## How to use

This is a bash executable.  .Command files in OS X can be double clicked from the Finder to be run.  If it isn't working then most likely the permissions need to be set to executable.  chmod +x aws-mfa.command
