Pre Reqs
Criar Projeto Google Cloud
Instalar o google SDK
Configurar o gcloud init
Ativar Google Kubernetes Engine API

Clonar o repo:

entrar no diretorio do terraform/enviroments/dev
Definir projeto e região no connections.tf
remover o terraform.tfstate.backup e o terraform.tfstate (coloquei no gitignore mas nao ta rolando)
terraform init
terraform plan
terraform apply

Set Up CI
gcloud container clusters get-credentials jenkins-dev --zone zona_escolhida
executar os comandos kubernetes:
cd raiz_do_repo/k8s/ci
./k8s.sh

Status dos pods e services:

kubectl get pods --namespace jenkins
kubectl get services --namespace jenkins

Dashboard do kubernetes:

kubectl proxy &
rodar : kubectl config view | grep -A10 "name: $(kubectl config current-context)" | awk '$1=="access-token:"{print $2}'
acessar localhost:8001 e escolher a opcao token, e colocar o token resultado do comando acima

Acessar o CI:

kubectl describe ingress jenkins --namespace jenkins
Acessar o Address do ultimo comando, (ja é ip fixo!) login jenkins e a senha CHANGE_ME

Set Uo API


https://cloud.google.com/solutions/continuous-delivery-jenkins-kubernetes-engine
