###############################################################################
# 1 ─ BUILD STAGE                                                             #
###############################################################################
# Use the official Flutter image with the latest stable SDK (3.22 at July 2025)
FROM cirrusci/flutter:3.22 AS build

# Set working directory inside the container
WORKDIR /app

# --- Caching trick: copy pubspec first, fetch deps, then rest of the code ----
COPY pubspec.* ./
RUN flutter pub get

# Copy the rest of the sources and build the web release bundle
COPY . .
RUN flutter build web --release              # output → build/web

###############################################################################
# 2 ─ RUNTIME STAGE (static site)                                             #
###############################################################################
FROM nginx:stable-alpine

# Remove default Nginx html & copy Flutter build
RUN rm -rf /usr/share/nginx/html/*
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose web port
EXPOSE 80

# Start Nginx in the foreground (Render auto-detects this)
CMD ["nginx", "-g", "daemon off;"]
