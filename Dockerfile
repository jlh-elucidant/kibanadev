FROM openjdk:8

ENV KIBANA_VERSION 5.2.2
ENV NODE_VERSION 6.9.5

RUN apt-get update
RUN apt-get install -y curl xz-utils git
RUN curl https://nodejs.org/download/release/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz | unxz | tar xvf - -C /opt
RUN ln -s /opt/node-v${NODE_VERSION}-linux-x64 /opt/node && \
	ln -s /opt/node/bin/node /usr/local/bin/node && \
	ln -s /opt/node/bin/npm /usr/local/bin/npm 

RUN cd /opt && git clone https://github.com/elastic/kibana.git

# npm install husky needs the git hooks
RUN cd /opt/kibana/.git/hooks && touch pre-commit pre-push post-merge post-rewrite pre-rebase && \ 
	cd /opt/kibana && git checkout -b kibanadev v5.2.2 && npm install

CMD [ "bash" ]

