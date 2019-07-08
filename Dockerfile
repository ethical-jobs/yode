FROM nginx:1.16.0-alpine

LABEL maintainer="Dean Tedesco <dean@ethicaljobs.com.au>"



#
#--------------------------------------------------------------------------
# Install node
#--------------------------------------------------------------------------
#

RUN apk add --update nodejs yarn

#
#--------------------------------------------------------------------------
# Install bash, jq
#--------------------------------------------------------------------------
#

RUN apk add --no-cache bash jq

#
#--------------------------------------------------------------------------
# Install dotenv-to-json and dynamic-env
#--------------------------------------------------------------------------
#

RUN yarn global add dotenv-to-json @ethical-jobs/dynamic-env

#
#--------------------------------------------------------------------------
# Install supervisor
#--------------------------------------------------------------------------
#

RUN apk add --no-cache supervisor

#
#--------------------------------------------------------------------------
# Configuration
#--------------------------------------------------------------------------
#

ADD ./config/supervisord.conf /etc/supervisord.conf

ADD ./config/nginx.conf /etc/nginx/nginx.conf

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
