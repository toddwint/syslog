#!/usr/bin/env bash
REPO=toddwint
APPNAME=syslog
source "$(dirname "$(realpath $0)")"/config.txt

# Create the docker container
docker run -dit \
    --name "$HOSTNAME" \
    -h "$HOSTNAME" \
    -p $IPADDR:514:514/udp \
    -p "$IPADDR":"$HTTPPORT1":"$HTTPPORT1" \
    -p "$IPADDR":"$HTTPPORT2":"$HTTPPORT2" \
    -p "$IPADDR":"$HTTPPORT3":"$HTTPPORT3" \
    -p "$IPADDR":"$HTTPPORT4":"$HTTPPORT4" \
    -e TZ="$TZ" \
    -e HTTPPORT1="$HTTPPORT1" \
    -e HTTPPORT2="$HTTPPORT2" \
    -e HTTPPORT3="$HTTPPORT3" \
    -e HTTPPORT4="$HTTPPORT4" \
    -e HOSTNAME="$HOSTNAME" \
    -e APPNAME="$APPNAME" \
    ${REPO}/${APPNAME}

# Create the webadmin html file from template
htmltemplate="$(dirname "$(realpath $0)")"/webadmin.html.template
htmlfile="$(dirname "$(realpath $0)")"/webadmin.html
cp "$htmltemplate" "$htmlfile"
sed -Ei 's/(Launch page for webadmin)/\1 - '"$HOSTNAME"'/g' "$htmlfile"
sed -Ei 's/\bIPADDR:HTTPPORT1\b/'"$IPADDR"':'"$HTTPPORT1"'/g' "$htmlfile"
sed -Ei 's/\bIPADDR:HTTPPORT2\b/'"$IPADDR"':'"$HTTPPORT2"'/g' "$htmlfile"
sed -Ei 's/\bIPADDR:HTTPPORT3\b/'"$IPADDR"':'"$HTTPPORT3"'/g' "$htmlfile"
sed -Ei 's/\bIPADDR:HTTPPORT4\b/'"$IPADDR"':'"$HTTPPORT4"'/g' "$htmlfile"

# Give the user instructions and offer to launch webadmin page
echo 'Open webadmin.html to use this application (`firefox webadmin.html &`)'
read -rp 'Would you like me to open that now? [Y/n]: ' answer
if [ -z ${answer} ]; then answer='y'; fi
if [[ ${answer,,} =~ ^y ]] 
then
    firefox "$htmlfile" &
fi
