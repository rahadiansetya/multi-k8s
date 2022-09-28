docker build -t rahadiansetya/multi-client:latest -t rahadiansetya/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t rahadiansetya/multi-server:latest -t rahadiansetya/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t rahadiansetya/multi-worker:latest -t rahadiansetya/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push rahadiansetya/multi-client:latest
docker push rahadiansetya/multi-server:latest
docker push rahadiansetya/multi-worker:latest

docker push rahadiansetya/multi-client:$SHA
docker push rahadiansetya/multi-server:$SHA
docker push rahadiansetya/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=rahadiansetya/multi-server:$SHA
kubectl set image deployment/client-deployment client=rahadiansetya/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=rahadiansetya/multi-worker:$SHA