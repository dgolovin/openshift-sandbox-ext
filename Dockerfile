FROM node:16.14.2 AS client-builder
WORKDIR /ui
# cache packages in layer
COPY ui/package.json /ui/package.json
COPY ui/package-lock.json /ui/package-lock.json
RUN --mount=type=cache,target=/usr/src/app/.npm \
    npm set cache /usr/src/app/.npm && \
    npm ci
# install
COPY ui /ui
RUN npm run build

FROM alpine
LABEL org.opencontainers.image.title="openshift-sandbox-ext" \
    org.opencontainers.image.description="OpenShift Sandbox signup" \
    org.opencontainers.image.vendor="RedHat, Inc." \
    com.docker.desktop.extension.api.version=">= 0.2.0"
COPY metadata.json .
COPY docker.svg .
COPY --from=client-builder /ui/build ui
