CLUSTER_NAME=example-cluster

create-cluster:
	kind create cluster --config=kind-example-config.yaml --name=${CLUSTER_NAME}

delete-cluster:
	kind delete cluster --name=${CLUSTER_NAME}

get-contexts:
	kubectl config get-contexts

use-context:
	kubectl config use-context kind-example-cluster

failed-manifests-dev-apply: use-context
	kustomize build ./failed-manifests/dev/ | kubectl apply -f -

success-manifests-dev-apply: use-context
	kustomize build ./success-manifests/dev/ | kubectl apply -f -
