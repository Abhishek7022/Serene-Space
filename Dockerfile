# Use the official Nginx image as the base
FROM nginx:alpine

# Copy the static website files into the Nginx html directory
COPY ./src /usr/share/nginx/html

# Expose port 80 to the outside world
EXPOSE 80
