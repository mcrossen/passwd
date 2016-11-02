# Dummy Passwd Generator
This utility was created as part of project 7 for CS 465 at BYU. For that project, we were tasked to create fake /etc/passwd and /etc/shadow files and then use john the ripper to crack them.

## Usage
The script consumes a list of passwords from a file named "passwords.txt" in the working directory. It then creates two new files: 'passwd' and 'shadow'. Before these files can be used with John the Ripper, they must be unshadowed. Here is an example:
```bash
./dummypasswd.rb
unshadow passwd shadow > unshadowed
```

## Experiment
passwordmeter.com contains a simple utility that gauges how secure a password is. For this lab, I created a few different passwords for each password strength that the site listed. These categories are: very weak, weak, good, and strong. I created fake passwd files for each of these categories and recorded how long it took to crack each file. We were told to use the lab machines in the CS department, but these don't have John the Ripper installed on them. Instead, I used a simple raspberry pi as my cracking minion.

## Results
The following table shows how long each category took to crack.

category  | time
--------- | ----
very weak | 3 s
weak      |   s
good      |   s
strong    |   s
