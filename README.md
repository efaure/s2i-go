# Openshift s2i go builder

Source code to build a  s2i go image

## Build the s2i image to your openshift cluster
```bash
oc new-build https://github.com/efaure/s2i-go.git
oc start-build s2i-go
```

## Use the s2i image to build a go project 
```bash
oc new-app s2i-go~https://github.com/prometheus/blackbox_exporter.git
```


## Use a makefile

Default build is made by running : 
 - go get -v ./...
 - go build -v -o main

It is possible to override this default behaviour to use a Makefile available in source repostiory by adding env USE_MAKEFILE=true to the build configuration

## Overwrite default source path folder

``` bash
oc new-app  s2i-go~https://github.com/kubernetes/kube-state-metrics.git#release-1.1
oc env bc kube-state-metrics BUILD_SOURCE_PATH=k8s.io/kube-state-metrics
oc start-build kube-state-metrics
```


## Define a custom binary name


By default this s2i go image will run "main" binary produced in source folder

To specify a binnary name it is possible to use environement var CUSTOM_BINARY_NAME
```bash
oc env dc process-exporter CUSTOM_BINARY_NAME=process-exporter
```



