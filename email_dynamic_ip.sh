#!/bin/bash

function isRoot() {
	if [ "${EUID}" -ne 0 ]; then
		echo "You need to run this script as root"
		exit 1
	fi
}

# Check OS version
function checkOS() {
	if [[ -e /etc/debian_version ]]; then
		source /etc/os-release
		OS="${ID}"
		if [[ ${ID} == "debian" || ${ID} == "raspbian" || ${ID} == "ubuntu" ]]; \
    then
			if [[ ! ${VERSION_ID} -lt 10 ]]; then
				echo "Your version of Debian (${VERSION_ID}) is not supported. Please \
        use Debian 10 Buster"
				exit 1
      else
        # stop here - install a program send mail
        apt install
			fi

		fi
	else
		echo "Your linux distribution is not supported, supported distribution are"
    echo "   - Debian"
    echo "   - Ubuntu"
    echo "   - Raspbian"
		exit 1
	fi
}

function get_public_ip() {
  # get public ip
  public_ip=$(grep -m 1 -oE '^[0-9]{1,3}(\.[0-9]{1,3}){3}$' <<< "$(wget \
    -T 10 -t 1 -4qO- "http://ip1.dynupdate.no-ip.com/" || curl -m 10 -4Ls \
    "http://ip1.dynupdate.no-ip.com/")")

    echo $public_ip
}


echo $(get_public_ip)
