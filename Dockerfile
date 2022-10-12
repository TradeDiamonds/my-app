FROM node:16-alpine AS build
WORKDIR /usr/src/app

COPY package.json .
COPY package-lock.json .

RUN npm install

#Copy project files
COPY . .
RUN npm run build --prod

#Genrate new certificates
# WORKDIR /cert2
# RUN bash genCert.sh

# WORKDIR /usr/src/app

EXPOSE 4200

FROM nginx:1.20-alpine

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /usr/src/app/dist/demo/ /usr/share/nginx/html
