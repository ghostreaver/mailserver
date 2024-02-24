#!/usr/bin/env python3
# coding: utf-8

# Import libraries
import smtplib


# Display prompt in the console
def prompt(val):
    return input(val).strip()


# Retrieve the mail parameters
mailfrom = prompt("From: ")
maildest = prompt("Dest: ").split()
subject = prompt("Subject: ").split()
print("Enter message, end with ^D (Unix) or ^Z (Windows):")

# Add the 'From' and 'To' headers at the start
msg = ("From: %s\r\nTo: %s\r\nSubject: %s\r\n\r\n" % (mailfrom, ", ".join(maildest), ", ".join(subject)))
while True:
    try:
        line = input()
    except EOFError:
        break
    if not line:
        break
    msg = msg + line

# Execute the mailer
print("Message length is", len(msg))
server = smtplib.SMTP('localhost')
server.set_debuglevel(1)
server.sendmail(mailfrom, maildest, msg)
server.quit()
