#!/bin/bash
keyvault_name="keyvaultlogs"
rg_name="keyvaultlogs"
secret_name_prefix="mysecret"
value_prefix="myvalue"
option=$1

case $option in 
    -c|--create)
        num_secrets=$2
        if [ -z "$num_secrets" ];
        then
            echo "Please specify the number of secrets to create. Type $0 -h for more details."
            exit 0
        fi
        for i in $(seq 1 $num_secrets);
        do
            secret_name="$secret_name_prefix-$i"
            value="$value_prefix-$i"
            echo "Creating secret $secret_name with value $value in Azure Key Vault $keyvault_name"
            az keyvault secret set -n "$secret_name" --vault-name $keyvault_name --value "$value" >/dev/null 2>&1
        done
        ;;
    -r|--read)
        num_secrets=$2
        if [ -z "$num_secrets" ];
        then
            echo "Please specify the number of secrets to read. Type $0 -h for more details."
            exit 0
        fi
        for i in $(seq 1 $num_secrets);
        do
            secret_name="$secret_name_prefix-$i"
            value=$(az keyvault secret show -n $secret_name --vault-name $keyvault_name --query value 2>/dev/null)
            if [ -z "$value" ];
            then
                echo "Secret $secret_name not found in Azure Key Vault $keyvault_name"
            else
                echo "Reading secret $secret_name from Azure Key Vault $keyvault_name. Value: $value"
            fi
        done
        ;;
    -d|--delete)
        num_secrets=$2
        if [ -z "$num_secrets" ];
        then
            echo "Please specify the number of secrets to delete. Type $0 -h for more details."
            exit 0
        fi
        for i in $(seq 1 $num_secrets);
        do
            secret_name="$secret_name_prefix-$i"
            echo "Deleting secret $secret_name from Azure Key Vault $keyvault_name"
            az keyvault secret delete -n $secret_name --vault-name $keyvault_name >/dev/null
        done
        ;;
    -l|--list)
        echo "Secrets in Key Vault $keyvault_name:"
        az keyvault secret list --vault-name $keyvault_name --query [].id -o tsv
        ;;
    *)
        echo "This script can be used to generate load on an Azure Key Vault, creating and reading secrets"
        echo "Instructions:"
        echo "  $0 -h:     shows this help"
        echo "  $0 -l:     list secrets in key vault"
        echo "  $0 -c 30:  creates 30 secrets" 
        echo "  $0 -r 10:  reads 10 secrets"
        echo "  $0 -d 10:  deletes 10 secrets"
        exit 0
        ;; 
esac

