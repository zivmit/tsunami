# Tsunami
EKS environment and a Helm chart of Tsunami network security scanner


### dockerimage preperations
I used the instructions and created the docker image of tsunami, stored in my dockerhub. 

### service  infrastructure
I created an EKS cluster the will demo a production enviroment (workergourp with an autoscaling). 
move to ./prod-eks folder, run:
$ terraform init 
$ terraform plan
$ terraform apply

connect to the EKS cluster (prerequsits AWSCLI, Kubectl)
$ aws eks --region eu-west-2 update-kubeconfig --name prod-eks

$ kubectl config set-cluster \
<CLUSTER_NAME> \
--server=<SERVER_ADDRESS> \
--certificate-authority=<CLUSTER_CERTIFICATE>kubectl config set-cluster \
<CLUSTER_NAME> \
--server=<SERVER_ADDRESS> \
--certificate-authority=<CLUSTER_CERTIFICATE>


### service deployment
the Desired state was to use gitops metodology and to have a tool like Argo to have the ability to represent the production applications state in the repository files.
since its a home assignment I used native Helm commands for deploy the application. 
I chosed to use CronJob workload type to represent the Tsunami-security-scanner since its an action that we will schedule for once in a period of time( week/ few days)
after the scan is done we can free the pod resources. 

I didnt finished my solution because the scanning resaults are availeable only from the stdout (kubectl logs for the relevant evicted pod), which is not a production solution, a production solution that i belive can be good one is to add a sidecar container of a log shipper like FluentD and to publish the logs into a logs datasource. 


