# Build stage
FROM klakegg/hugo:ext-ubuntu as builder

# Build site
WORKDIR /src
COPY . /src
ARG HUGO_BASEURL=https://andy.costanzamainas.be
ENV HUGO_BASEURL=${HUGO_BASEURL}
RUN hugo --gc --minify -b ${HUGO_BASEURL}
# Final stage
FROM nginx
COPY --from=builder /src/public /app
COPY ./docker/nginx/nginx.conf /etc/nginx/conf.d/default.conf