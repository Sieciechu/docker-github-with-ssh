FROM fedora:latest

RUN dnf -y install git && \
    dnf clean all
    
RUN mkdir ~/.ssh && \
    ssh-keyscan github.com >> ~/.ssh/known_hosts

ARG SSH_PRIVATE_KEY
ARG SSH_CONFIG
ARG USER
RUN echo "${SSH_PRIVATE_KEY}" > ~/.ssh/id_rsa && \
    chmod -R 400 ~/.ssh && \
    echo "${SSH_CONFIG}" > ~/.ssh/config

# RUN eval "$(ssh-agent -s)" && ssh-add ~/.ssh/id_rsa

WORKDIR /app
RUN git clone --branch=master --depth=1 --single-branch git@github.com:sebastianbergmann/phpunit.git
RUN chown -R "${USER}:${USER}" phpunit

CMD bash
