Helm structure
------------------
Chart.yaml
Values.yaml
Templates
	Deployment.yaaml
	Service.yaml
	_helpers.tbl
	Ingress.yaml
	
Commands
--------------
Create 
Install
Repo add
Search

Prerequisites
-------------------
Azure cli

Chocolatey - from ps with admin mode
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

Helm
Choco install kubernetes-helm

Kubectl
az aks install-cli

Git
Choco install git

az cli commands
az group create --name AKSRG --location eastus
az acr create --resource-group AKSRG --name aksreg --sku Basic
az aks create -g AKSRG -n testproj --location eastus --attach-acr akscontainerhub --generate-ssh-keys
az aks get-credentials --resource-group AKSRG --name testproj --admin

Clone repo https://github.com/Rakeshwebtech/django-aks.git 

Or

Create a new chart with helm create webfrontend

helm install webfrontend webfrontend/

helm list

Helm delete webfrontend 
