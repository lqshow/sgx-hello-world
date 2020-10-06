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