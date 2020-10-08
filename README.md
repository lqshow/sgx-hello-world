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

## Troubleshooting

### 依赖 Intel SGX PSW(Platform Software) 

如果容器内未安装 PSW，报以下错误

```bash
./app: error while loading shared libraries: libsgx_urts.so: cannot open shared object file: No such file or directory
```

### 需要开启容器特权模式可使用 SGX

非特权模式下，pod 一直处于 CrashLoopBackOff 状态

```bash
➜ kubectl logs -f sgx-helloworld-76dbf445bc-h476l
Failed to create enclave, ret code: 8198, enclave file: /project/enclave.signed.so
Enter a character before exit ...
```
