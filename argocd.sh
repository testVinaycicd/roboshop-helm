component_name=$1
env=$2
imageTag=$3

PASSWORD=$(kubectl get secrets -n argocd argocd-initial-admin-secret -o json | jq .data.password|xargs | base64 --decode)
argocd login argocd-${env}.mikeydevops1.online --grpc-web --insecure --username admin --password $PASSWORD


argocd app create ${component_name} --upsert --repo https://github.com/testVinaycicd/roboshop-helm.git --path . --dest-namespace default --dest-server https://kubernetes.default.svc --values env-${env}/${component_name}.yaml --helm-set imageTag=${imageTag}
argocd app sync ${component_name}



#argocd login a5d5d3fd81f7a460b806e2337d5aa0c6-1632824844.us-east-1.elb.amazonaws.com --username admin --password jfryO2UWtkPeY8di
