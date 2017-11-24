# Openshift s2i go builder

Source code to build a  s2i go image

## Build the s2i image to your openshift cluster
```bash
oc new-app https://github.com/efaure/s2i-go.git
oc delete dc,svc s2i-go
```

## Use the s2i image to build a go project 
```bash
oc new-app s2i-go~https://github.com/ncabatoff/process-exporter.git
```

## Binary name

By default this s2i go image will run the binary produced in /opt/app-root/src/go/bin/*

To specify a binnary name it is possible to use environement var CUSTOM_BINARY_NAME
```bash
oc env dc process-exporter CUSTOM_BINARY_NAME=process-exporter
```



