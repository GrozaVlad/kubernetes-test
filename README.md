# Kubernetes PoC

1. This PoC was built with Docker Desktop,the nginx ingress configuration requires it, you will need to install it from [_here_](https://docs.docker.com/desktop/). 

2. You will need to login to the az cli with _**az login**_.

3. Create a new resource group with the command _**az group create --location $LOCATION --name $RESOURCE_GROUP_NAME**_

4. Download the right utility for your operating system for the aks engine from [_here_](https://github.com/Azure/aks-engine/releases/tag/v0.70.1). Save it in the root of the project

5. You will need to generate the cluster with the following command:

    ./aks-engine deploy --dns-prefix "$RESOURCE_GROUP_NAME" \
        --resource-group "$RESOURCE_GROUP_NAME" \
        --location "$LOCATION" \
        --api-model ./kubernetes.json \
        --subscription-id "$SUBSCRIPTION_ID" \
        --auto-suffix

6. The deploy command will generate an _output directory.Execute export KUBECONFIG=_output/$NAME_OF_THE_GENERATED_FOLDER/kubeconfig/$FILE, in order for kubectl to be able to connect to the private cluster. After you exported it run _**kubectl get all**_ to make sure you can connect to the cluster.

7. Execute the bootstrap project shell ./bootstrap_project.sh. This script will create the pods, services, ingress controller and networking rules for the cluster.

8. If you want to tweak the images there is an additional shell script for building the docker images. Be warned that you will need to change the deployments.yaml if you push to your own public repository