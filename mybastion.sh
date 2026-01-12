#!/bin/bash

# Define variables


BASTION_ID="ocid1.bastion.oc1.ca-toronto-1.amaaaaaavrxjjqyaglberz67hn473y5vbm6fympvnv35ooxfm3e57bfgenjq"                    # The OCID of the Bastion
TARGET_RESOURCE_ID="ocid1.instance.oc1.ca-toronto-1.an2g6ljrvrxjjqycz4lbxsdzgil7fvbsu5zju7ahhifmt3ml5a4ydeqmchoa"  # The OCID of the Windows instance (compute)
TARGET_PRIVATE_IP="10.0.2.80"    # Private IP of the Windows target
TARGET_PORT=3389                                  # RDP port for Windows (usually 3389)
COMPARTMENT_ID="ocid1.compartment.oc1..aaaaaaaa4yygxadxsx7yxgixghlug5igqbnni5ubm7zes423g2fqfbdhte6a"             # Compartment where Bastion resides
LOCAL_PORT=8282
BASTION_KEY=/Users/Rajesh.Madhavarao/.ssh/bastion


# 1. Create the Bastion session for port forwarding
echo "Creating the Bastion session..."
SESSION_ID=$(oci bastion session create-port-forwarding \
    --bastion-id $BASTION_ID \
    --target-resource-id $TARGET_RESOURCE_ID \
    --display-name "x" \
    --target-private-ip $TARGET_PRIVATE_IP \
    --target-port $TARGET_PORT \
    --wait-for-state SUCCEEDED \
    --ssh-public-key-file /Users/Rajesh.Madhavarao/.ssh/bastion.pub \
    --query 'data.resources[0].identifier' --raw-output \
    )

if [ -z "$SESSION_ID" ]; then
  echo "Error: Failed to create Bastion session."
  exit 1
fi

echo "Bastion session created with ID: $SESSION_ID"

# 2. Get the Bastion session connection details (SSH command)
echo "Fetching session connection details..."
SESSION_DETAILS=$(oci bastion session get --session-id $SESSION_ID --query 'data' --raw-output)

echo "Establishing port forwarding for RDP on localhost:$LOCAL_PORT..."
#eval "$SSH_COMMAND -L $LOCAL_PORT:$TARGET_PRIVATE_IP:$TARGET_PORT" &
eval "ssh -i $BASTION_KEY -N -L $LOCAL_PORT:$TARGET_PRIVATE_IP:$TARGET_PORT -p 22 $SESSION_ID@host.bastion.ca-toronto-1.oci.oraclecloud.com" &
echo "Port forwarding established. You can now connect to the Windows target using RDP client at localhost:$LOCAL_PORT."

# 4. Optionally, clean up the session after you're done
# Uncomment the following lines if you want to delete the session after RDP connection
# echo "Cleaning up the Bastion session..."
# oci bastion session delete --session-id $SESSION_ID --force
# echo "Bastion session deleted."

