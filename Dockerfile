# FROM node:7.2.0

# RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
# RUN echo "deb http://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

# RUN apt-get update
# RUN apt-get install -y apt-utils vim nano rubygems build-essential yarn


# # RUN npm i -g yarn@0.17.10
# # RUN npm cache clean
# # RUN mkdir -p /root/.cache/yarn/
# RUN yarn --version

FROM node:6.6.0
RUN apt-get update
RUN apt-get install -y vim nano rubygems build-essential
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN echo 'HOME PATH'
RUN echo $HOME
RUN ls $HOME/.yarn/bin/yarn
RUN $HOME/.yarn/bin/yarn self-update

# =====INSTAL GLOBAL YARN======
# RUN yarn global add typescript@2.0.8 tslint@3.9.0 protractor@4.0.11 webdriver-manager@10.2.8 webpack@2.1.0-beta.25 webpack-dev-server@2.1.0-beta.0 karma-cli@1.0.1 karma-chrome-launcher@2.0.0 rimraf@2.5.2 phantomjs-prebuilt@2.1.13 angular-cli@1.0.0-beta.21 --exact
RUN $HOME/.yarn/bin/yarn global add typescript@2.0.8 --exact
RUN $HOME/.yarn/bin/yarn global add tslint@3.9.0 --exact
RUN $HOME/.yarn/bin/yarn global add webpack@2.1.0-beta.25 --exact
RUN $HOME/.yarn/bin/yarn global add webpack-dev-server@2.1.0-beta.0 --exact
RUN $HOME/.yarn/bin/yarn global add karma-cli@1.0.1 --exact
RUN $HOME/.yarn/bin/yarn global add karma-chrome-launcher@2.0.0 --exact
RUN $HOME/.yarn/bin/yarn global add rimraf@2.5.2 --exact
RUN $HOME/.yarn/bin/yarn global add phantomjs-prebuilt@2.1.13 --exact
RUN $HOME/.yarn/bin/yarn global add angular-cli@1.0.0-beta.21 --exact

# =====INSTALL sass=====
RUN gem install sass scss_lint

# =====REBUILD NODE_SASS=======
RUN npm rebuild node-sass

WORKDIR /workspace

# =====ADD PACKAGE.JSON and YARN.LOCK=======
ADD package.json /workspace
ADD yarn.lock /workspace

# =====INSTALL NODE MODULES=======
RUN $HOME/.yarn/bin/yarn install

RUN echo 'Print node_modules2'
RUN ls /tmp/node_modules

# VOLUME ["/workspace/node_modules"]
