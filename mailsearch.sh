#!/bin/bash

#Pede termo da pesquisa
if [[ $(echo $*) ]]; then
    searchterm="$*"
else
    read -p "Search: " searchterm
fi

#Adiciona + entre as palavras and export to search file
searchterm=$(echo $searchterm | sed -e 's/\ /+/g')
echo -e '\nExtraindo URLs\n'
lynx -dump "http://www.google.co.uk/search?q=$searchterm&num=9999" > search
sleep 1

#grep the urls sorted and uniq to UrlCleanListUniq
cat search | grep -Eo '(http|https)://[^/"]+' > UrlCleanList
cat UrlCleanList |sort| uniq > UrlCleanListUniq

#Get all html of the sites to UrlLevelOne
while read -r line
  do
     curl -s "$line" >> UrlLevelOne
  done < UrlCleanListUniq

#grep all html of UrlLevelOne and export to UrlLevelTwo and after this, to UrlCleanListUniq
cat UrlLevelOne | grep -Eo '(http|https)://[^/"]+' > UrlLevelTwo
sleep 1
cat UrlLevelTwo |sort| uniq > UrlCleanListUniq


#Get all html of the sites to Level2HTML
while read -r line
  do
     curl -s "$line" >> Level2HTML
  done < UrlCleanListUniq

echo -e '\nA extrair mails'

#Export all emails to a flat file Mails
sleep 2
grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" Level2HTML > Mails
sleep 1

#Export the file Mails sorted and uniq to MailsFinalList
cat Mails|sort|uniq > MailsFinalList
rm -f Mails
rm -f Level2HTML
rm -f UrlCleanListUniq
rm -f UrlLevelTwo
rm -f UrlLevelOne
rm -f UrlCleanList
rm -f search
