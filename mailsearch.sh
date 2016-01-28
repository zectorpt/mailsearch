#!/bin/bash

#Pede termo da pesquisa
if [[ $(echo $*) ]]; then
    searchterm="$*"
else
    read -p "Pesquisa: " searchterm
fi

#Adiciona + entre as palavras
searchterm=$(echo $searchterm | sed -e 's/\ /+/g')
echo -e '\nExtraindo URLs\n'
lynx -dump "http://www.google.co.uk/search?q=$searchterm&num=9999" > search
sleep 1
cat search |awk '{print $1}'|grep www > UrlCleanList
rm -f search

while read -r line
  do
     curl -s "$line" >> UrlLevelOne
#    lynx -dump $line >> site
  done < UrlCleanList
echo -e '\nA extrair mails'
sleep 2
grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" UrlLevelOne > Mails
sleep 1
cat Mails|sort|uniq > MailsFinalList
