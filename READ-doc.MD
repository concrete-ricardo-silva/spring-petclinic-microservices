## Arquitetura
![Arquitetura Google Cloud](https://image.ibb.co/bycuen/gcp.jpg)

------
### Instalando Google Cloud Sdk

baixe o instalador em:
https://cloud.google.com/sdk/?hl=pt-br

ou via terminal: 

1. Digite o seguinte comando no prompt:
```
curl https://sdk.cloud.google.com | bash
```
2. Reinicie o shell:
```
exec -l $SHELL
```

### Outros componentes necessários
``` 
gcloud components install docker-credential-gcr
```
```
gloud components install kubectl
```

### Após a instalação do requisitos vamos criar um projeto para trabalho 

1. Execute
```
gcloud init
```
2. Nomeie o projeto 
```
gcloud projects create [PROJECT_NAME]
```
3. Verifique a criação do projeto
```
gcloud projects list 
```

>PROJECT_ID NAME PROJECT_NUMBER    
>**[PROJECT_ID]** [PROJECT_NAME] [PROJECT_NUMBER]
------

4. Use o **[PROJECT_ID]** informado para definir o projeto 

```
gcloud config set project [PROJECT_ID]
```

### Baixando os código do SCM

```
git clone https://github.com/concrete-ricardo-silva/spring-petclinic-microservices
```

1. Acesse o diretório do terraform e edite o ambiente a ser provisionado

```
cd spring-petclinic-microservices/terraform/enviroments/dev/
```
2. Edite o arquivo **connections.tf** e adicione o [PROJECT_ID] obtido anteriormente
adicione a região onde deseja provisionar o projeto;

> **Tip:** Uma lista de regiões disponíveis pode ser obtida usando o comando
```
gcloud compute regions list
```
> project = "**[PROJECT_ID]**"  
> region = "**[REGION]**" 

3. Criando uma conta de Serviço para dar permissões ao Terraform

```
gcloud iam service-accounts create terraform 
```

4. Criando credenciais para o Terraform
```
gcloud iam service-accounts keys create gce-terraform-key.json --iam-account=terraform@[PROJECT_ID].iam.gserviceaccount.com
```

### Baixando as chaves e adicionando as permissões


1. Login no Portal do Google cloud
![Logon Google Cloud](https://image.ibb.co/cMpfFS/logon.jpg)

2. Vá até APIs e Criar Credencias
![APIs on Google Cloud](https://image.ibb.co/e0MuaS/apis.jpg)

3. Selecionar **Chave de conta de Serviço**
![Service Account on Google Cloud](https://image.ibb.co/bSZEaS/serviceaccount.jpg)

4. Adicionar a Conta de serviço 
![Generate key on Google Cloud](https://image.ibb.co/iAMuaS/terraformaccount.jpg)

5. Fazer download do arquivo.json


### Exportando as credencias para uso no projeto
```
export GOOGLE_CREDENTIALS=/path_to_file/[PROJECT_ID].json
```


### Iniciando o Provisionamento **Infra As Code**

1. Dentro do diretorio do enviroment do terraform execute o comando para terraform baixar os plugins necessários

```
terraform init
``` 

2. Para iniciar a checagem dos item a serem implantados ou modificados 
```
terraform plan 
```

3. Aplicando as configurações 

```
terraform apply
```
------
### Demonstração
