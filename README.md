1. This PoC was built with Docker desktop, you will need to install it. 
2. First you need to login to the az cli with az login.
3. Create a new resource group with the command az group create --location $LOCATION --name $RESOURCE_GROUP_NAME
4. Download the right utility for your operating system for the aks engine from here: https://github.com/Azure/aks-engine/releases/tag/v0.70.1
5. You will need to generate the cluster with the following command:
./aks-engine deploy --dns-prefix "$RESOURCE_GROUP_NAME" \
    --resource-group "$RESOURCE_GROUP_NAME" \
    --location "$LOCATION" \
    --api-model ./kubernetes.json \
    --subscription-id "$SUBSCRIPTION_ID" \
    --auto-suffix
6. export KUBECONFIG=_output/$NAME_OF_THE_GENERATED_FOLDER/kubeconfig/$FILE
7. execute the bootstrap project shell ./bootstrap_project.sh