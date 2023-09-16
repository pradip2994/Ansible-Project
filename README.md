# Automating Nginx Installation and Webpage Deployment on AWS EC2 with Ansible


![Untitled Diagram drawio](https://github.com/pradip2994/Ansible-Project/assets/124191442/71631d2f-b783-4c0f-bdb9-fcbfb5f59f73)




## Launch EC2 instance with name terraform-server

**Install terraform**
```
https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli
```

To Check which version is install enter below command
```
$terraform -version
```

![Screenshot 2023-09-16 115226](https://github.com/pradip2994/Ansible-Project/assets/124191442/86884aa2-de96-48f7-88d8-90f8e24927f9)


**Install AWS ClI**

```
$sudo apt-get update
$sudo apt-get install awscli 
```

![Screenshot 2023-09-16 121223](https://github.com/pradip2994/Ansible-Project/assets/124191442/9656ec33-864f-4907-b821-f6773f613517)


**After installing the AWS CLI, you need to configure it with your AWS credentials. You can do this by running the aws configure command and providing your AWS Access Key ID, Secret Access Key, default region, and output format. These credentials should have appropriate permissions for the AWS services you want to manage.**

```
$aws configure
```

![Screenshot 2023-09-16 121630](https://github.com/pradip2994/Ansible-Project/assets/124191442/3f090a0b-82d4-4159-9010-e57a00d0475b)

## Create directory name terraform and create file : **providers.tf** **variables.tf** **main.tf**

![Screenshot 2023-09-16 123559](https://github.com/pradip2994/Ansible-Project/assets/124191442/37c5d6d0-a1ad-4b31-ad11-a19ad416a900)
![Screenshot 2023-09-16 123619](https://github.com/pradip2994/Ansible-Project/assets/124191442/6c7cb95a-f9cc-46d9-908d-42b9fb0d67e4)
![Screenshot 2023-09-16 123701](https://github.com/pradip2994/Ansible-Project/assets/124191442/dc177dd8-7eea-4cb4-b9fb-8bcc5ebfda5f)
![Screenshot 2023-09-16 123724](https://github.com/pradip2994/Ansible-Project/assets/124191442/65d73b13-8066-43f0-a7e2-9a44f928bac7)


After creating .tf files enter command :

```
$sudo terraform fmt
```
This command is used to Reformat your configuration in the standard style.

terraform init command is used to initialize a Terraform working directory

```
terraform init
```

![Screenshot 2023-09-16 123856](https://github.com/pradip2994/Ansible-Project/assets/124191442/bffcc996-075c-4e04-9c06-b06655850a2c)

terraform validate command Checks whether the configuration is valid.

```
terraform validate
```

![Screenshot 2023-09-16 123926](https://github.com/pradip2994/Ansible-Project/assets/124191442/05591f7f-7b59-487c-8a8b-f74ccaf832fa)

terraform plan Shows changes required by the current configuration.

```
terraform plan
```
![Screenshot 2023-09-16 124015](https://github.com/pradip2994/Ansible-Project/assets/124191442/5297a5ba-b58f-4a9a-8f38-5bbc37a3823d)
![Screenshot 2023-09-16 124040](https://github.com/pradip2994/Ansible-Project/assets/124191442/7a15be23-9a8f-42ac-a3db-f8a650e14e4f)

terraform apply command create or update infrastructure.

```
terraform apply
```

![Screenshot 2023-09-16 124057](https://github.com/pradip2994/Ansible-Project/assets/124191442/8586391e-c07f-4a46-b690-f608f50ad4a8)
![Screenshot 2023-09-16 124119](https://github.com/pradip2994/Ansible-Project/assets/124191442/e2c13523-ffe4-4250-92b6-80e42ec27b96)

### Now we can see in below image that terraform has created ansible control node, Node-1 and Node-2

![Screenshot 2023-09-16 125843](https://github.com/pradip2994/Ansible-Project/assets/124191442/f7c3e569-b978-45d8-b076-db491d208bb5)

## Now connect to Ansible control node using SSH.
![Screenshot 2023-09-16 055012](https://github.com/pradip2994/Ansible-Project/assets/124191442/9a9aaed2-1d6b-47e2-a84e-d77effae1247)

**Install Ansible**

Add the Ansible PPA repository using the following command:
```
$sudo apt-add-repository ppa:ansible/ansible
```

Update the package using following commands

```
$sudo apt update
```

Install Ansible using the following command:

```
$sudo apt install ansible -y
```

After the installation is complete, check the version of Ansible using the following command:

```
$ansible --version
```

Copy the private key from your local machine to  Ansible control node at (/home/ubuntu/.ssh).

**Copy the private key to the Ansible control node by creating a new file ansible_key at /home/ubuntu/.ssh and pasting the private key in ansible_key.**

```
$vim ansible_key
```

![Screenshot 2023-09-16 060829](https://github.com/pradip2994/Ansible-Project/assets/124191442/78fa1bd4-ccb1-4b0f-8e59-f57b74a64616)

Give permissions to the ansible_key file using the chmod command.

```
$sudo chmod 600 ansible_key
```

![Screenshot 2023-09-16 060918](https://github.com/pradip2994/Ansible-Project/assets/124191442/86349fd3-95a5-4260-a44c-ac45fd3b52dc)

Create inventory file at location /etc/ansible/hosts

```
$sudo vi /etc/ansible/hosts
```
we can create inventory file anyware.
Inventory file is a text file that contains a list of hostnames or IP addresses of remote servers that Ansible can manage.
![Screenshot 2023-09-16 061722](https://github.com/pradip2994/Ansible-Project/assets/124191442/4a2b2103-c146-44e8-b6ea-6493ccbc785f)

Add the IP addresses of the servers and also add private key file location to use for authentication.

![Screenshot 2023-09-16 061704](https://github.com/pradip2994/Ansible-Project/assets/124191442/3851964a-a1a3-4707-9cca-0d8b3e70aba2)

After you have added the hosts to the file, you can verify the inventory of hosts that Ansible can manage using the ansible-inventory command.

```
$ansible-inventory --list -y
```

ansible-inventory command with the --list option is used to generate a JSON or YAML representation of your Ansible inventory. When you use the -y option, it specifies that the output format should be in YAML. 

![Screenshot 2023-09-16 061858](https://github.com/pradip2994/Ansible-Project/assets/124191442/604f63d8-f592-47e4-b702-38cdc9141daf)

To test that Ansible is able to connect to your nodes, you can use the following command:

```
ansible all -m ping
```

![Screenshot 2023-09-16 061944](https://github.com/pradip2994/Ansible-Project/assets/124191442/69dd2318-b441-4d93-b2a1-7fd744f226ae)

Now create with name ansible and enter inside.

```
$mkdir ansible
```

![Screenshot 2023-09-16 063233](https://github.com/pradip2994/Ansible-Project/assets/124191442/e60a6681-977e-4703-9083-027001e6821b)

### Now deploy a webpage using the ansible playbook

Create a file index.html in the ansible directory, and add some sample content

```
$sudo nano index.html
```

![Screenshot 2023-09-16 063350](https://github.com/pradip2994/Ansible-Project/assets/124191442/4484e355-1201-43ec-9a22-e8cc8dcb59ea)

write YAML file to install nginx and replacing .html file from index.html, in the playbook directory:

```
$sudo vi webserver.yaml
```

![Screenshot 2023-09-16 064446](https://github.com/pradip2994/Ansible-Project/assets/124191442/0fd54217-34e6-4cb4-b5cb-2105566b1206)

This playbook will copy the index.html file to the default Nginx web server document root directory at /var/www/html/

Run the playbook

```
$ansible-playbook webserver.yaml
```

![Screenshot 2023-09-16 064536](https://github.com/pradip2994/Ansible-Project/assets/124191442/4f15fc58-7510-4003-a3a8-9e7be2fe6815)

Once the playbook finishes executing, open a web browser and enter the public IP address of EC2 instances.

## Node-1
![Screenshot 2023-09-16 064925](https://github.com/pradip2994/Ansible-Project/assets/124191442/af9891f9-1642-47dc-9d34-3d35991d6d3c)


## Node-2

![Screenshot 2023-09-16 064938](https://github.com/pradip2994/Ansible-Project/assets/124191442/5616d475-6a84-4448-8fc6-860148f579b8)


