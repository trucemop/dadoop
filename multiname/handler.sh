#!/bin/bash

function editDns {
	NAME=`echo $1 | awk '{print $1}'`
	REMOTE_ADDRESS=`echo $INPUT | awk '{print $2}'`
	EXISTING=`cat /etc/dnsmasq.d/0hosts | grep "/${NAME}/"`
	if [[ -z "`echo ${EXISTING}`" ]] ; then
		echo address=\"/${NAME}/${2}\" >> /etc/dnsmasq.d/0hosts
		service dnsmasq restart
	fi
}

function handleUserEvent {
	case "${SERF_USER_EVENT}" in
		add-me)
			INPUT=`cat`
			editDns ${INPUT}
			;;
		*)
	esac
}


case "${SERF_EVENT}" in
	member-join)	
		INPUT=`cat`
		editDns ${INPUT}
		;;
	user)
		handleUserEvent
		;;
	*)
esac

