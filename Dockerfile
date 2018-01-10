# This image provides an environment for building and running Go applications.

FROM openshift/base-centos7

ENV GO_MINOR_VERSION=8 \
    GO_PATCH_VERSION=3

ENV GO_VERSION=1.${GO_MINOR_VERSION} \
    GOPATH=$HOME/go \
    GOBIN=$HOME/go/bin \
    PATH=$PATH:$HOME/go/bin:/usr/local/go/bin

LABEL io.k8s.description="Platform for building and running Go applications" \
      io.k8s.display-name="Go ${GO_VERSION}" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,go,go1${GO_MINOR_VERSION}" \
      io.openshift.s2i.scripts-url="image://${STI_SCRIPTS_PATH}"


# Install Go toolchain
RUN yum clean all -y && \
    (curl -L https://storage.googleapis.com/golang/go${GO_VERSION}${GO_PATCH_VERSION:+.}${GO_PATCH_VERSION}.linux-amd64.tar.gz | \
        tar -xz -C /usr/local)

# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/ $STI_SCRIPTS_PATH

USER 1001

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/RUN
