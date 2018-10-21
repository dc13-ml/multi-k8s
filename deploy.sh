docker build -t dc13ml/multi-client:latest -t dc13ml/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t dc13ml/multi-server:latest -t dc13ml/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t dc13ml/multi-worker:latest -t dc13ml/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push dc13ml/multi-client:latest
docker push dc13ml/multi-client:$SHA
docker push dc13ml/multi-server:latest
docker push dc13ml/multi-server:$SHA
docker push dc13ml/multi-worker:latest
docker push dc13ml/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=dc13ml/multi-server:$SHA
kubectl set image deployments/client-deployment client=dc13ml/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=dc13ml/multi-worker:$SHA