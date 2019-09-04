docker build -t abibromley/multi-client:latest -t abibromley/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t abibromley/multi-server:latest -t abibromley/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t abibromley/multi-worker:latest -t abibromley/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push abibromley/multi-client:latest
docker push abibromley/multi-client:$GIT_SHA
docker push abibromley/multi-server:latest
docker push abibromley/multi-server:$GIT_SHA
docker push abibromley/multi-worker:latest
docker push abibromley/multi-worker:$GIT_SHA

kubectl apply -f k8s

kubectl set image deployments/server-deployment server=abibromley/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=abibromley/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=abibromley/multi-worker:$GIT_SHA