docker build -t jurglic/multi-k8s-client:latest -t jurglic/multi-k8s-client:$SHA -f ./client/Dockerfile ./client
docker build -t jurglic/multi-k8s-server:latest -t jurglic/multi-k8s-server:$SHA -f ./server/Dockerfile ./server
docker build -t jurglic/multi-k8s-worker:latest -t jurglic/multi-k8s-worker:$SHA -f ./worker/Dockerfile ./worker

docker push jurglic/multi-k8s-client:latest
docker push jurglic/multi-k8s-server:latest
docker push jurglic/multi-k8s-worker:latest
docker push jurglic/multi-k8s-client:$SHA
docker push jurglic/multi-k8s-server:$SHA
docker push jurglic/multi-k8s-worker:$SHA

kubectl apply -f ./k8s
kubectl set image deployment/client-deployment client=jurglic/multi-k8s-client:$SHA
kubectl set image deployment/server-deployment server=jurglic/multi-k8s-server:$SHA
kubectl set image deployment/worker-deployment worker=jurglic/multi-k8s-worker:$SHA
