docker build -t candamir/multi-client:latest -t candamir/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t candamir/multi-server:latest -t candamir/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -f candamir/multi-worker:latest -t candamir/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push candamir/multi-client:latest
docker push candamir/multi-server:latest
docker push candamir/multi-worker:latest

docker push candamir/multi-client:$SHA
docker push candamir/multi-server:$SHA
docker push candamir/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=candamir/multi-server:$SHA
kubectl set image deployments/client-deployment client=candamir/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=candamir/multi-worker:$SHA