ARG src_image
FROM ${src_image}

ARG pack_version
ARG java_version
RUN apk add --update --no-cache openjdk${java_version}; \
    rm -rf /var/cache/apk/*; \
    cd /usr/local/bin; \
    wget --no-check-certificate -O - https://github.com/buildpacks/pack/releases/download/v${pack_version}/pack-v${pack_version}-linux.tgz | tar zxf -
