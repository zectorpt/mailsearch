#!/bin/bash
#Generate process script
cat <<EOF > helper1.sh
#!/bin/bash
numberoflines=$(cat xaa|wc -l)
while read -r line
  do
     curl -s "$line" >> Level2HTML
     echo "We need to process more $numberoflines lines"
     ((numberoflines--))
  done < xaa
EOF
cat <<EOF > helper2.sh
#!/bin/bash
numberoflines=$(cat xab|wc -l)
while read -r line
  do
     curl -s "$line" >> Level2HTML
     echo "We need to process more $numberoflines lines"
     ((numberoflines--))
  done < xab
EOF
chmod 755 helper1.sh
chmod 755 helper2.sh
sleep 1
/bin/bash helper1.sh > log1 &
/bin/bash helper2.sh > log2 &
