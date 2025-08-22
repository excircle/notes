# How To Implement Metal LB

This document provides instructions for implementing Metal LB

```bash
# grab the existing config, inject strictARP, re-apply in one go
kubectl -n kube-system get cm kube-proxy -o yaml \
  | sed '/^  ipvs:/a\    strictARP: true' \
  | kubectl apply -f -
```

# BASH Commands

```bash
k -n metallb-system apply -f pool.yaml 
k -n metallb-system apply -f advert.yaml 
kubectl create deployment nginx-test --image=nginx
kubectl expose deployment nginx-test   --port=80   --target-port=80   --type=LoadBalancer   --name=nginx-lb
kubectl get svc nginx-lb -w
history
```

# How to access

Check the `svc` and use the port to access the host:

```bash
akalaj@minio1:~/metallb$ kubectl get svc nginx-lb
NAME       TYPE           CLUSTER-IP    EXTERNAL-IP    PORT(S)        AGE
nginx-lb   LoadBalancer   10.102.6.37   192.168.1.90   80:32508/TCP   2m28s
```

In the above example, `32508` is the port where nginx is accessible.

Visit: `http://minio1:32508/`