FROM nginx

# Installation
RUN apt-get update 
RUN apt-get install -y curl git wget unzip
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter path
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Run flutter doctor
RUN flutter doctor -v

# Set workdir
COPY . /ssoda
WORKDIR /ssoda

# Get dependencies
RUN flutter pub get

# Build flutter web
RUN flutter build web

# Replace meta data
COPY ./meta_data/ /ssoda/build/web
RUN rm /ssoda/build/web/favicon.png

# Nginx setting
RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx.conf /etc/nginx/conf.d

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]