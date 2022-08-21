0. This PoC was built with Docker desktop, you will need to install it. Also install yq either with brew or with chocolatey
1. First you need to login to the az cli with az login.
2. Create a new resource group with the command az group create --location $LOCATION --name $RESOURCE_GROUP_NAME
3. Download the right utility for your operating system for the aks engine from here: https://github.com/Azure/aks-engine/releases/tag/v0.70.1
4. execute the bootstrap project shell
