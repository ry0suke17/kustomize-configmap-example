# kustomize-configmap-example

Created an example of applying ConfigMap using kustomise. 
Motivation for creating this was to get the following error.

```
metadata.labels: Invalid value: "outputTextoutputTextoutputTextoutputTextoutputTextoutputTextoutputText": must be no more than 63 characters
```

Set the environment variable from the metadata label and process using that environment variable.
If the number of characters in the label exceeds 63, an error occurs.
So I tried to see if I could use configmap as a workaround.

## Test

If the label char length exceeds 63, it will fail.

```shell
$ make create-cluster
$ make failed-manifests-dev-apply
kustomize build ./failed-manifests/dev/ | kubectl apply -f -
The CronJob "dev-test-cronjob" is invalid: 
* metadata.labels: Invalid value: "outputText-outputText-outputText-outputText-outputText-outputText-outputText-outputText": must be no more than 63 characters
* spec.jobTemplate.spec.template.labels: Invalid value: "outputText-outputText-outputText-outputText-outputText-outputText-outputText-outputText": must be no more than 63 characters
make: *** [failed-manifests-dev-apply] Error 1
$ make delete-cluster
```

Succeeds even if it exceeds 63 characters when use ConfigMap.

```shell
$ make create-cluster 
$ make success-manifests-dev-apply 
$ kubectl get pods
NAME                                READY   STATUS      RESTARTS   AGE
dev-test-cronjob-1617527160-wnvcr   0/1     Completed   0          2m
dev-test-cronjob-1617527220-82hpr   0/1     Completed   0          60s
$ kubectl logs dev-test-cronjob-1617527160-wnvcr
outputText
outputText
outputText
outputText
outputText
outputText
outputText
outputText
```
