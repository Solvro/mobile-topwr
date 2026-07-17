FROM ghcr.io/solvro/flutter-web-only:3.44.6 AS build

WORKDIR /app

ENV PATH="/root/.pub-cache/bin:${PATH}"

COPY . .

RUN dart pub global activate melos \
	&& melos install \
	&& melos build_runner \
	&& flutter build web --release

FROM nginx:alpine

# Copy the web build produced in the build stage into the nginx html directory.
COPY --from=build /app/build/web /usr/share/nginx/html

# Serve files from public/ at root (e.g., /.well-known/*).
COPY public /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
