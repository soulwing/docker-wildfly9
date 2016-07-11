FROM frolvlad/alpine-oraclejdk8:cleaned

ENV WILDFLY_VERSION=9.0.2.Final

ADD https://github.com/just-containers/s6-overlay/releases/download/v1.11.0.1/s6-overlay-amd64.tar.gz /tmp/
ADD http://search.maven.org/remotecontent?filepath=org/wildfly/wildfly-dist/${WILDFLY_VERSION}/wildfly-dist-${WILDFLY_VERSION}.zip /tmp/wildfly.zip
    
RUN APPS_BASE=/apps && \
  tar -zxf /tmp/s6-overlay-amd64.tar.gz -C / && \
  mkdir $APPS_BASE && \
  unzip -qd /apps /tmp/wildfly.zip && \
  ln -s $APPS_BASE/wildfly-${WILDFLY_VERSION} $APPS_BASE/wildfly && \
  rm /tmp/wildfly.zip
  
EXPOSE 8080 9990
ENTRYPOINT ["/init"]
CMD ["/apps/wildfly/bin/standalone.sh"]
