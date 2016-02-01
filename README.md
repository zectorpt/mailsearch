# mailsearch
This script use Google to download a list of URL's based on your search.

The script download all the HTML and grep all to a flat file. After this, the script process all the links in the HTML and generate a new output file (second level of links)

If you need a lot of emails and don't want stay a lot of time browsing in boring sites... Use my script.

A normal search could take about 2hr's (depending your connection)

Tested under Ubuntu 15.10

Pre requirements:
lynx curl awk

If you want to improve it: <br />
 1 - Next step is to split the huge file (with split for example) that is downloaded and run parallel scripts to process it. <br />
 2 - Choose How many levels of Links do you want download <br />
 3 - Add more Search engines (the sintaxe change between Search Engines) <br />

----------------------------------------------------
Usage:

apt-get install git-all (debian based) <br />
OR <br />
yum install git-all (RedHat based)<br /><br />

git clone https://github.com/zectorpt/mailsearch.git <br />
cd mailsearch <br />
chmod 755 mailsearch.sh <br />
./mailsearch.sh

Or... copy parte and be happy... <br />
---------------------------------------------------

If you like it, star my repo and don't delete my email <br />
josemedeirosdealmeida@gmail.com <br />
josemedeirosdealmeida.com
