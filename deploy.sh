docker build -t maunconsultancy/multi-client:latest -t maunconsultancy/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maunconsultancy/multi-server:latest -t maunconsultancy/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maunconsultancy/multi-worker:latest -t maunconsultancy/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push maunconsultancy/multi-client:latest
docker push maunconsultancy/multi-server:latest
docker push maunconsultancy/multi-worker:latest

docker push maunconsultancy/multi-client:$SHA
docker push maunconsultancy/multi-server:$SHA
docker push maunconsultancy/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=maunconsultancy/multi-server:$SHA
kubectl set image deployments/client-deployment client=maunconsultancy/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=maunconsultancy/multi-worker:$SHA