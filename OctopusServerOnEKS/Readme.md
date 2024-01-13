################## Deploy the Octopus Server on the EKS ############################

1. MSSQL Server.
    - Deployment File[Done].
    - Service File[Done].
    - Storage Class File[Done].
    - Persistent Volume Claim File[Done].

2. Octopus Deployment Server.
    - Deployment File[Done].
    - Service File[Done].
    - Storage Class File[Done].
    - Persistent Volume Claim File[Done].
    - Ingress File[Done].

3. Create the Cluster:
eksctl create cluster --name=octopus --region=us-east-1 --without-nodegroup

4 Enable IAM Roles for Pods:
eksctl utils associate-iam-oidc-provider --cluster=octopus --region=us-east-1 --approve

5. Create the NodeGroup:
eksctl create nodegroup --cluster=octopus --region=us-east-1 --name=octopus-ng --node-type=t3.medium --nodes=2 --node-min=2 --nodes-max=3 --node-volume-size=8 --ssh-public-key=teamcity-key --node-private-networking --managed --asg-access --external-dns-access --full-ecr-access --alb-ingress-access

6. Install the EBS Driver:
Create the IAM Policy Amazon_EBS_CSI_Driver using iam_policy_ebs.json.
kubectl apply -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.25"

7. Install the AWS ELB Controller.
aws iam create-policy --policy-name AWSLoadBalancerControllerIAMPolicy --policy-document file://iam_policy.json
eksctl create iamserviceaccount --cluster=octopus --namespace=kube-system --name=aws-load-balancer-controller --role-name AmazonEKSLoadBalancerControllerRole --attach-policy-arn=arn:aws:iam::338689921066:policy/AWSLoadBalancerControllerIAMPolicy --approve
helm install aws-load-balancer-controller eks/aws-load-balancer-controller -n kube-system --set clusterName=octopus --set serviceAccount.create=false --set serviceAccount.name=aws-load-balancer-controller --set region=us-east-1 --set vpcId=vpc-00c09050e999d928d --set image.repository=602401143452.dkr.ecr.us-east-1.amazonaws.com/amazon/aws-load-balancer-controller  

8. Install the DNS Recorder.
Create the IAM Policy AllowExternalDNSUpdates using iam_policy_dns.json.
eksctl create iamserviceaccount --cluster=octopus --namespace=default --name=external-dns --attach-policy-arn=arn:aws:iam::338689921066:policy/AllowExternalDNSUpdates --approve
kubectl apply -f DNS.yaml

9. Removing the All Resources:
    1. kubectl delete -f Octopus-manifests/
    2. kubectl delete -f MSSQL-manifests/
    3. kubectl delete -f MSSQL-manifests/
    4. kubectl delete -k "github.com/kubernetes-sigs/aws-ebs-csi-driver/deploy/kubernetes/overlays/stable/?ref=release-1.25"
    5. eksctl create nodegroup --cluster=octopus
    6. eksctl delete cluster --name=octopus


************ Credentials *************
SQL Password:Admin@123
Octopus Deployment Server:
    Username: pankaj
    Password: Admin@1234#