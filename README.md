# sgx-hello-world

## Run in docker

> 硬件模式 +docker 执行

```bash
docker run \
	--name=test_sgx_hello_world \
	--device=/dev/isgx \
	-v /var/run/aesmd/aesm.socket:/var/run/aesmd/aesm.socket \
	lqshow/sgx-hello-world
	
Tue Oct  6 03:38:48 2020
Hello world From SGX Enclave!
Tue Oct  6 03:38:49 2020
Hello world From SGX Enclave!
Tue Oct  6 03:38:50 2020
Hello world From SGX Enclave!
Tue Oct  6 03:38:51 2020
Hello world From SGX Enclave!
Tue Oct  6 03:38:52 2020
Hello world From SGX Enclave!
Tue Oct  6 03:38:53 2020
Hello world From SGX Enclave!
Tue Oct  6 03:38:54 2020
Hello world From SGX Enclave!
Tue Oct  6 03:38:55 2020
Hello world From SGX Enclave!
```

## Run in k8s

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sgx-helloworld
spec:
  replicas: 1
  selector:
    matchLabels:
      app: sgx-helloworld
  template:
    metadata:
      labels:
        app: sgx-helloworld
    spec:
      containers:
      - image: lqshow/sgx-hello-world
        imagePullPolicy: Always
        name: sgx-helloworld
        securityContext:
          privileged: true
        resources:
          limits:
            cpu: 250m
            memory: 512Mi
        volumeMounts:
        - mountPath: /var/run/aesmd/aesm.socket
          name: aesmsocket
      volumes:
      - hostPath:
          path: /var/run/aesmd/aesm.socket
          type: Socket
        name: aesmsocket
```