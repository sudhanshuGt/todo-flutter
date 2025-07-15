###############################################################################
# 1.  BUILD STAGE – uses the official Flutter image (Linux)                  #
###############################################################################
FROM cirrusci/flutter:3.22 as build
WORKDIR /app

# copy source and download dependencies once
COPY pubspec.* ./
RUN flutter pub get

# copy the rest of the project
COPY . .

# build the web release bundle
RUN flutter build web --release

###############################################################################
# 2.  RUNTIME STAGE – serve with Nginx (tiny image)                           #
###############################################################################
FROM nginx:stable-alpine
# Remove default html
RUN rm -rf /usr/share/nginx/html/*

# Copy Flutter build output to Nginx web root
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose web port
EXPOSE 80

# Start Nginx (Render detects the CMD automatically)
CMD ["nginx", "-g", "daemon off;"]
