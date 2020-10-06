FROM ubuntu:18.04 as builder

# Install Prerequisites
RUN apt-get update && apt-get install -yq --no-install-recommends \
    ca-certificates \
    build-essential \
    wget

# Install SGX SDK
WORKDIR /opt/intel
RUN wget https://download.01.org/intel-sgx/sgx-linux/2.11/distro/ubuntu18.04-server/sgx_linux_x64_sdk_2.11.100.2.bin \
    && chmod +x sgx_linux_x64_sdk_2.11.100.2.bin \
    && echo yes | ./sgx_linux_x64_sdk_2.11.100.2.bin


# STEP 1 Build executable binary
WORKDIR /workspace

# Copy source code from the host
COPY ./ ./

RUN make build

# STEP 2 Build a small image
FROM ubuntu:18.04 as sample

RUN apt-get update && apt-get install -y \
    g++ \
    libcurl4-openssl-dev \
    libprotobuf-dev \
    libssl-dev \
    make \
    wget \
    gnupg \
    module-init-tools

# Install the Intel(R) SGX PSW
RUN echo 'deb [arch=amd64] https://download.01.org/intel-sgx/sgx_repo/ubuntu bionic main' | tee /etc/apt/sources.list.d/intel-sgx.list \
    && wget -qO - https://download.01.org/intel-sgx/sgx_repo/ubuntu/intel-sgx-deb.key | apt-key add - \
    && apt-get update && apt-get install -y \

    # Install launch service
    libsgx-launch \
    libsgx-urts \

    # Install EPID-based attestation service:
    libsgx-epid \

    #  Install algorithm agnostic attestation service
    libsgx-quote-ex

WORKDIR /project

# Copy our static executable binary
COPY --from=builder /workspace/src/app /workspace/src/enclave.signed.so /workspace/src/enclave.so ./

CMD ["/project/app"]