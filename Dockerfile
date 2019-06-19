# multi-step build process

FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build


FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html

# NOTE: we're dumping everything from the 'builder' step besides /app/build dir. EVERYTHING
