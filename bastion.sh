#!/bin/zsh

#Exit on error
set -e

SLEEP=120

#BASTION=ocid1.bastion.oc1.ca-toronto-1.amaaaaaavrxjjqyads6zpxztsj6vgismyw3kywli3xjqwv565hsrnoixs62q
BASTION=ocid1.bastion.oc1.ca-toronto-1.amaaaaaavrxjjqyaglberz67hn473y5vbm6fympvnv35ooxfm3e57bfgenjq
REGION="ca-toronto-1"

#SSH_PUB_KEY="/Users/${USER}/SSH/bastion.pub"
SSH_PUB_KEY="/Users/Rajesh.Madhavarao/.ssh/bastion.pub"

# for some reason, the session gets created with first letter upper-case.
SESS_NAME=${(C)USER}

get_session_ocid() {
	SESS_OCID=$(oci bastion session list --bastion-id ${BASTION} --session-lifecycle-state ACTIVE --display-name ${SESS_NAME} --all  | jq -r '.data[] | .id')
}

#Do we already have an active session in the Bastion service
get_session_ocid

if [ -z "${SESS_OCID}" ]; then
	echo "We need to create a new session"
	SESS_OCID=$(oci  bastion session create --bastion-id ${BASTION} --target-resource-details /Users/Rajesh.Madhavarao/Documents/Terraform/proj2/instance.json --display-name ${SESS_NAME} --ssh-public-key-file $SSH_PUB_KEY | jq -r '.data.id')
	echo "Created a new session: ${SESS_OCID}"
	echo "It takes a moment to start the new session, so we will nap for ${SLEEP} seconds"
	sleep ${SLEEP}
	get_session_ocid
	if [ -z "$SESS_OCID" ]; then
		echo "Might be it took a bit longer than we thought. Try again in a moment."
		exit 1
	fi
else
	echo "Found active session: "
fi

IP=$(jq -r '.targetResourcePrivateIpAddress' bast.json)

ssh -o ProxyCommand="ssh -W %h:%p -p 3389 $SESS_OCID@host.bastion.${REGION}.oci.oraclecloud.com" opc@${IP} #Add your port forward etc here

