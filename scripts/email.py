#!/usr/bin/python

import imaplib
import subprocess
import os

def password():
    proc = subprocess.Popen("lpass show --password mail.de", shell=True, stdout=subprocess.PIPE)
    password = proc.stdout.read()
    return password.decode().replace('\n', '')

def user():
    proc = subprocess.Popen("lpass show --username mail.de", shell=True, stdout=subprocess.PIPE)
    user = proc.stdout.read()
    return user.decode().replace('\n', '')

try:
	obj = imaplib.IMAP4_SSL('imap.mail.de', 993)
	obj.login(user(), password())
	obj.select()
	if len(obj.search(None, 'unseen')[1][0].split()) == 0:
		print("")
	elif len(obj.search(None, 'unseen')[1][0].split()) == 1:
		print("1 new Mail")
	else:
		print(str(len(obj.search(None, 'unseen')[1][0].split())) + " new Mails")
except imaplib.socket.gaierror:
	print("")
