docker build -t janakasteph/multi-client:latest -t janakasteph/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t janakasteph/multi-server:latest -t janakasteph/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t janakasteph/multi-worker:latest -t janakasteph/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push janakasteph/multi-client:latest
docker push janakasteph/multi-server:latest
docker push janakasteph/multi-worker:latest

docker push janakasteph/multi-client:$SHA
docker push janakasteph/multi-server:$SHA
docker push janakasteph/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=janakasteph/multi-server:$SHA
kubectl set image deployments/client-deployment client=janakasteph/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=janakasteph/multi-worker:$SHA