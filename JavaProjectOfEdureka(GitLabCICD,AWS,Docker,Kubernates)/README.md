# abctechnologies code
"# assignment1" 

kubectl create secret docker-registry gitlab-token-auth \
  --docker-server=https://registry.gitlab.com \
  --docker-username=<your_email> \
  --docker-password="<api_key>" \
  --docker-email=<your_email>

#DNS ISSUE:
kubectl -n kube-system rollout restart deployment coredns

#ForDocumationOfProject Drop Email on pankajshah349@gmail.com
