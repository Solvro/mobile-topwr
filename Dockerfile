FROM ubuntu:24.04 AS builder

ARG FLUTTER_VERSION

RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    && rm -rf /var/lib/apt/lists/*

RUN test -n "${FLUTTER_VERSION}" && git clone --branch ${FLUTTER_VERSION} --depth 1 https://github.com/flutter/flutter.git /flutter
ENV PATH="/flutter/bin:${PATH}"
RUN flutter doctor

WORKDIR /app
COPY . .

RUN test -s .env
RUN dart run build_runner build -d
RUN flutter build web --release


FROM nginx:alpine AS nginx

# Copy the built Flutter web app from the builder stage to nginx html directory
COPY --from=builder /app/build/web /usr/share/nginx/html

# Serve files from public/ at root (e.g., /.well-known/*)
COPY --from=builder /app/public /usr/share/nginx/html

# Optional: Copy custom nginx configuration
# COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
