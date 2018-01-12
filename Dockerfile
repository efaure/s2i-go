# This image provides an environment for building and running Go applications.

FROM registry.access.redhat.com/devtools/go-toolset-7-rhel7:7

ENV STI_SCRIPTS_PATH=/usr/libexec/s2i  \
    STI_SCRIPTS_URL=image:///usr/libexec/s2i  

LABEL io.k8s.description="Platform for building and running Go applications" \
      io.k8s.display-name="Go s2i" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="builder,go" \
      io.openshift.s2i.scripts-url="image://${STI_SCRIPTS_PATH}"


# Copy the S2I scripts from the specific language image to $STI_SCRIPTS_PATH
COPY ./s2i/ $STI_SCRIPTS_PATH

USER root
RUN yum repolist
RUN yum install -y --disablerepo='*' --enablerepo rhel-7-server-rpms -y git
RUN chmod -R g+w /opt/rh/go-toolset-7/root/usr/share/gocode \
  && chown -R default:default /opt/rh/go-toolset-7/root/usr/share/gocode
USER 1001

# Set the default CMD to print the usage of the language image
CMD $STI_SCRIPTS_PATH/run
