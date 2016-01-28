#!/bin/bash

#Pede termo da pesquisa
if [[ $(echo $*) ]]; then
    searchterm="$*"
else
    read -p "Search: " searchterm
fi

#Adiciona + entre as palavras
searchterm=$(echo $searchterm | sed -e 's/\ /+/g')
echo -e '\nExtraindo URLs\n'
lynx -dump "http://www.google.co.uk/search?q=$searchterm&num=9999" > search
sleep 1
cat search | grep -Eo '(http|https)://[^/"]+' > UrlCleanList
cat UrlCleanList |sort| uniq > UrlCleanListUniq

while read -r line
  do
     curl -s "$line" >> UrlLevelOne
#    lynx -dump $line >> site
  done < UrlCleanListUniq

echo -e '\nA extrair mails'

sleep 2
grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" UrlLevelOne > Mails
sleep 1
cat Mails|sort|uniq > MailsFinalList
