# Mailsearch - The powerful mail catcher!
This script use Google, Bing and Yahoo to download a list of URL's based on your search.

The script download all the HTML and grep it to a flat file. After this, process all the links in the HTML and generate a new output file (second level of links).

If you need a lot of emails and don't want stay a lot of time browsing in boring sites... Use my script.

A normal search could take about 2hr's (depending your connection) and will download around 50MB.

Tested under Ubuntu 15.10

Pre requirements:
lynx curl awk

If you want to improve it: <br />
 1 - Next step is to split the huge file (with split for example) that is downloaded and run parallel scripts to process it. <br />
 2 - Allow user to chose how many levels of Links he want download <br />
 3 - Add more Search engines (the sintaxe change between Search Engines) <br />

----------------------------------------------------
Usage:

apt-get install git-all (Debian based) <br />
OR <br />
yum install git-all (RedHat based)<br /><br />

git clone https://github.com/zectorpt/mailsearch.git <br />
cd mailsearch <br />
chmod 755 mailsearch.sh <br />
./mailsearch.sh

Or... copy & paste and be happy... <br />

---------------------------------------------------

If you like it, star my repo and don't delete my email from source code<br />
josemedeirosdealmeida@gmail.com <br />
josemedeirosdealmeida.com
