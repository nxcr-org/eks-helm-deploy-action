FROM public.ecr.aws/docker/library/python:3.12.0-slim-bullseye

# Install the toolset.
RUN apt -y update && apt -y install curl git \
    && sudo apt-get install curl gpg apt-transport-https --yes \
    && curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null \
    && echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list \
    && sudo apt-get update \
    && sudo apt-get install helm \
    && pip install awscli \
    && curl -LO https://storage.googleapis.com/kubernetes-release/release/v1.22.12/bin/linux/amd64/kubectl \
    && chmod +x ./kubectl && mv ./kubectl /usr/local/bin/kubectl

COPY deploy.sh /usr/local/bin/deploy

CMD deploy
