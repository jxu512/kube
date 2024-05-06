#Run pod
kubectl run nginx-1 --image=nginx --port=80
#or
kubectl create deployment nginx-2 --image=nginx --port=80

# Expose port with NodePort, pod -> run=nginx-1 (Selector)
kubectl expose pod nginx-1 --port=80 --type=NodePort
#or, deploy -> app=nginx (Selector). service name is same as deploy, can set service name: --name=helm-nginx-node-port
kubectl expose deploy nginx-2 --port=80 --type=NodePort
# For deployment, this also works
kubectl create svc nodeport nginx --tcp=80

# Tunnel to cluster, this command shows url for the service
minikube service nginx-1 --url
# check that tunnel process is running
ps -ef | grep docker@127.0.0.1
#Now, access url: http://node-ip:NodePort
#Find node IP by
kubectl describe node minikube | grep InternalIP

# Can use port-forward for testing, this will forward 127.0.0.1:32555 to nginx on kube
kubectl expose pod nginx --port=80 --name nginx-3
kubectl port-forward service/nginx-3 32555:80

