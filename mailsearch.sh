#!/bin/bash
#######################################
# josemedeirosdealmeida@gmail.com     #
# josemedeirosdealmeida.com           #
# zectorpt                            #
#                                     #
# A good help to find mails to SPAM   #
#                                     #
# Usage:                              #
#  ./mailsearch.sh                    #
#######################################

#Ask what to search
if [[ $(echo $*) ]]; then
    searchterm="$*"
else
    read -p "Search: " searchterm
fi

#Add a + between the strings
searchterm=$(echo $searchterm | sed -e 's/\ /+/g')
echo -e '\nExtracting from URLs from Google'
lynx -dump "http://www.google.com/search?q=$searchterm&num=9999" > search
echo -e '\nExtracting from URLs from Bing\n'
sleep 1
lynx -dump "http://www.bing.com/search?q=$searchterm&count=9999" >> search
sleep 1
echo -e 'Extracting from URLs from Yahoo\n'
lynx -dump "http://search.yahoo.com/search?p=$searchterm&n=40" >> search
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
echo -e "\nCleaning URL's like google... youtube..."
sleep 1
awk '!/google/' UrlCleanListUniq > temp && mv temp UrlCleanListUniq
sleep 1
awk '!/youtube/' UrlCleanListUniq > temp && mv temp UrlCleanListUniq
sleep 1
awk '!/facebook/' UrlCleanListUniq > temp && mv temp UrlCleanListUniq
sleep 1
awk '!/quot/' UrlCleanListUniq > temp && mv temp UrlCleanListUniq
sleep 1
awk '!/url/' UrlCleanListUniq > temp && mv temp UrlCleanListUniq
sleep 1
awk '!/ssl/' UrlCleanListUniq > temp && mv temp UrlCleanListUniq

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

#Export all emails to a flat file Mails
echo -e '\nA extrair mails'
sleep 2
grep -E -o "\b[a-zA-Z0-9.-]+@[a-zA-Z0-9.-]+\.[a-zA-Z0-9.-]+\b" Level2HTML > Mails
sleep 1

#Export the file Mails sorted and uniq to MailsFinalList
echo "Search: $searchterm" > MailsFinalList
cat Mails|sort|uniq >> MailsFinalList

#Clean images from flat file
echo -e "\nCleaning trash... png"
sleep 1
awk '!/png/' MailsFinalList > temp && mv temp MailsFinalList
echo -e "\nCleaning trash... jpg"
sleep 1
awk '!/jpg/' MailsFinalList > temp && mv temp MailsFinalList
echo -e "\nCleaning trash... gif"
sleep 1
awk '!/gif/' MailsFinalList > temp && mv temp MailsFinalList
echo -e "\nCleaning trash... jpeg"
sleep 1
awk '!/jpeg/' MailsFinalList > temp && mv temp MailsFinalList
echo -e "\nCleaning trash... JPG"
sleep 1
awk '!/JPG/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/webmaster/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/postmaster/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/example/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/w3/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/email./' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/.1/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/bing/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/tripadvisor/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/yahoo/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/booking.com/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/amazonaws/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/cloudfront/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/doubleclick/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/address.com/' MailsFinalList > temp && mv temp MailsFinalList
sleep 1
awk '!/site.com/' MailsFinalList > temp && mv temp MailsFinalList
echo -e "\nDeleting temp files"
sleep 1
#rm -f Mails Level2HTML UrlCleanListUniq UrlLevelTwo UrlLevelOne UrlCleanList search
echo -e "\nDONE! Check you MailsFinalList file\n"
