FROM public.ecr.aws/docker/library/python:3.12.0-slim-bullseye

# Install the toolset.
RUN apt -y update && apt -y install curl tar git unzip gpg apt-transport-https --yes \
    && curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 \
    && chmod +x get_helm.sh && ./get_helm.sh \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.22.12/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

COPY deploy.sh /usr/local/bin/deploy

CMD deploy
