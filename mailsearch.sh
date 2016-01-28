#!/bin/bash
#######################################
# josemedeirosdealmeida@gmail.com     #
# josemedeirosdealmeida.com           #
#A good help to find mails to SPAM    #
#                                     #
#Usage:                               #
# ./mailsearch.sh                     #
#######################################

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
sleep 2

#Implement counter 1
numberoflines=$(cat UrlCleanListUniq|wc -l)

#Get all html of the sites to UrlLevelOne
while read -r line
  do
     curl -s "$line" >> UrlLevelOne
     echo "We need to process more $numberoflines lines"
     ((numberoflines--))
  done < UrlCleanListUniq

#grep all html of UrlLevelOne and export to UrlLevelTwo and after this, to UrlCleanListUniq
cat UrlLevelOne | grep -Eo '(http|https)://[^/"]+' > UrlLevelTwo
sleep 1
cat UrlLevelTwo |sort| uniq > UrlCleanListUniq

#Implement counter 2
numberoflines=$(cat UrlCleanListUniq|wc -l)

#Get all html of the sites to Level2HTML
echo -e "\nA exportar os $numberoflines resultados para Level2HTML"
while read -r line
  do
     curl -s "$line" >> Level2HTML
     echo "We need to process more $numberoflines lines"
     ((numberoflines--))
  done < UrlCleanListUniq

echo -e '\nA extrair mails'

#Export all emails to a flat file Mails
sleep 2
grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" Level2HTML > Mails
sleep 1

#Export the file Mails sorted and uniq to MailsFinalList
cat Mails|sort|uniq > MailsFinalList
echo -e "\nCleaning trash... png"
sleep 1
sed "/^[^ ]png\png/d" MailsFinalList > MailsFinalList1
echo -e "\nCleaning trash... jpg"
sleep 1
sed "/^[^ ]jpg\jpg/d" MailsFinalList1 > MailsFinalList2
echo -e "\nCleaning trash... gif"
sleep 1
sed "/^[^ ]gif\gif/d" MailsFinalList2 > MailsFinalList
sleep 1
echo -e "\nDeletemp temp files"
sleep 1
rm -f Mails
rm -f Level2HTML
rm -f UrlCleanListUniq
rm -f UrlLevelTwo
rm -f UrlLevelOne
rm -f UrlCleanList
rm -f MailsFinalList1
rm -f MailsFinalList2
rm -f search
echo -e "\nDONE! Check you MailsFinalList file\n"
