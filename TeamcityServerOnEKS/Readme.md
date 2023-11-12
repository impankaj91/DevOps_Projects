# Topic: Host the Teamcity Server on the EKS.

# Code files created as below:
1. create saprate teamcity namespace or virtual boundary on EKS(namespace.yml):
2. for storage to store the all data of teamcity create the following file:
    1. ebc-sc.yml -> storage class file for AWS ElasticBlockStore.
    2. pvc.yml -> File to claim the storage from EBS.
3. teamcity server to run on aws ec2 using eks below files:
    1. deployment.yml
    2. service.yml

# Infrastructure commands:

1. Create the teamcity cluster using the below command:
    eksctl create cluster --name=teamcity --region=us-east-1 --without-nodegroup

2. To enable the AWS Roles for EKS:
    eksctl utils associate-iam-oidc-provider --cluster=teamcity --region=us-east-1 --approve

3. Create EC2 NodeGroup in Private Subnet:
    eksctl create nodegroup --cluster=teamcity --name=teamcity-nodes --region=us-east-1 --node-type=t3.medium --nodes-min=1 --nodes-max=1 --node-volume-size=8 --ssh-public-key=teamcity-key --instance-name=teamcity-server --node-private-networking --managed --asg-access --external-dns-access --alb-ingress-access

4. Install EBS CSI Drive on Cluster:
    1. Attach EC2 full access to the EKS Cluster Role.
    2. kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.25"

5. Rollout the Deployment:
    kubectl apply -f TeamcityServer/


# Cleanup the Resource After Sucessful Implementation:

1. Remove the All Application Resource: kubectl delete -f TeamcityServer/
2. Remove EBS CSI Driver: kubectl delete -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.25"
3. Remove NodeGroup: eksctl delete nodegroup --name=teamcity-nodes --cluster=teamcity
4. Remove Cluster: 