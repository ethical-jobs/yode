FROM nginx:1.17.7-alpine

LABEL maintainer="Ethical Jobs <development@ethicaljobs.com.au>"

#
#--------------------------------------------------------------------------
# Install node + other useful packages
#--------------------------------------------------------------------------
#

RUN apk add --no-cache nodejs yarn bash jq supervisor
RUN yarn global add dotenv-to-json @ethical-jobs/dynamic-env && yarn cache clean

COPY ./config/supervisord.conf /etc/supervisord.conf
COPY ./config/nginx.conf /etc/nginx/nginx.conf

# Create node log directories and stdout/stderr files
RUN mkdir -p /var/log/node \
    && touch /var/log/node/node.out.log \
    && touch /var/log/node/node.err.log

# Forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

#
#--------------------------------------------------------------------------
# Application
#--------------------------------------------------------------------------
#

RUN mkdir -p /var/www
WORKDIR /var/www
RUN node --version

#
#--------------------------------------------------------------------------
# Init
#--------------------------------------------------------------------------
#

EXPOSE 80 443

CMD /usr/bin/supervisord
