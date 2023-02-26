docker build -t pankaj349/multi-client:latest -t pankaj349/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t pankaj349/multi-server:latest -t pankaj349/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t pankaj349/multi-worker:latest -t pankaj349/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push  pankaj349/multi-client:latest
docker push  pankaj349/multi-server:latest
docker push  pankaj349/multi-worker:latest

docker push  pankaj349/multi-client:$SHA
docker push  pankaj349/multi-server:$SHA
docker push  pankaj349/multi-worker:$SHA

kubectl apply -f k8s/

kubectl set image deployments/client-deployment client=pankaj349/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=pankaj349/multi-worker:$SHA
kubectl set image deployments/server-deployment server=cygnetops/multi-server-pgfix-5-11:latest