#!/usr/bin/env ruby
require 'unix_crypt'
require 'randomstring'
PASSWORDS_FILE = "passwords.txt"
PASSWD_FILE_OUT = "passwd"
SHADOW_FILE_OUT = "shadow"

USERNAME_PREFIX = "user"
LAST_PASSWORD_CHANGE = 17082 # last password change (days since jan 1 1970)
PASS_CHANGE_WAIT_DAYS = 0 # how many days left before user can change password
PASS_EXPIRATION_DAYS = 99999 # how many of days before password expires
PASS_EXPIRATION_NOTICE = 7 # how many days notice to give on expiration
INACTIVE = "" # account disabled days after password expiration
EXPIRE = "" # days since jan 1 1970 that account is disabled
USER_COMMENTS = "" # any extra info about users
USER_DIRECTORY = ""
USER_SHELL = "/usr/sbin/nologin"

FILE_IN = File.read(PASSWORDS_FILE).lines.map do |line|
  line.strip
end
SHADOW_FILE = FILE_IN.each_with_index.map do |pass, index|
  [
    USERNAME_PREFIX + (index+1).to_s,
    UnixCrypt::MD5.build(pass, Randomstring.generate(8)),
    LAST_PASSWORD_CHANGE,
    PASS_CHANGE_WAIT_DAYS,
    PASS_EXPIRATION_DAYS,
    PASS_EXPIRATION_NOTICE,
    INACTIVE,
    EXPIRE,
  ].map do |element|
    element.to_s
  end.join(":") + ":"
end.join("\n")

PASSWD_FILE = FILE_IN.each_with_index.map do |pass, index|
  [
    USERNAME_PREFIX + (index+1).to_s,
    "x",
    index+1,
    index+1,
    USER_COMMENTS,
    USER_DIRECTORY,
    USER_SHELL,
  ].map do |element|
    element.to_s
  end.join(":")
end.join("\n")

File.write(PASSWD_FILE_OUT, PASSWD_FILE)
File.write(SHADOW_FILE_OUT, SHADOW_FILE)
