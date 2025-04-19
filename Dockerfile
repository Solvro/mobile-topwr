FROM ubuntu:latest AS builder

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

# Install Flutter
RUN git clone https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"
RUN flutter doctor
RUN flutter channel stable
RUN flutter upgrade

# Clone project and build it
WORKDIR /app
COPY . .

# Create .env file with TOKEN from build arg
ARG API_URL
ARG ASSETS_URL
ARG IPARKING_URL
ARG WIREDASH_ID
ARG WIREDASH_SECRET
ARG SKS_URL
ARG DIGITAL_GUIDE_URL
ARG DIGITAL_GUIDE_AUTHORIZATION_TOKEN
ARG DIGITAL_GUIDE_ADDONS_URL
ARG PARKING_API_URL
ARG TRANSLATE_API_URL
ARG TRANSLATE_API_TOKEN
ARG VAPID_WEB_PUB_KEY

RUN echo "API_URL=${API_URL}" > .env && \
    echo "ASSETS_URL=${ASSETS_URL}" >> .env && \
    echo "IPARKING_URL=${IPARKING_URL}" >> .env && \
    echo "WIREDASH_ID=${WIREDASH_ID}" >> .env && \
    echo "WIREDASH_SECRET=${WIREDASH_SECRET}" >> .env && \
    echo "SKS_URL=${SKS_URL}" >> .env && \
    echo "DIGITAL_GUIDE_URL=${DIGITAL_GUIDE_URL}" >> .env && \
    echo "DIGITAL_GUIDE_AUTHORIZATION_TOKEN=${DIGITAL_GUIDE_AUTHORIZATION_TOKEN}" >> .env && \
    echo "DIGITAL_GUIDE_ADDONS_URL=${DIGITAL_GUIDE_ADDONS_URL}" >> .env && \
    echo "PARKING_API_URL=${PARKING_API_URL}" >> .env && \
    echo "TRANSLATE_API_URL=${TRANSLATE_API_URL}" >> .env && \
    echo "TRANSLATE_API_TOKEN=${TRANSLATE_API_TOKEN}" >> .env && \
    echo "VAPID_WEB_PUB_KEY=${VAPID_WEB_PUB_KEY}" >> .env

RUN dart run build_runner build -d
RUN flutter build web --release


FROM nginx:alpine AS nginx

# Copy the built Flutter web app from the builder stage to nginx html directory
COPY --from=builder /app/build/web /usr/share/nginx/html

# Optional: Copy custom nginx configuration
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]