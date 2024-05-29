FROM node:20 AS build

COPY package.json package-lock.json /app/

WORKDIR /app

RUN npm ci --omit=dev

FROM gcr.io/distroless/nodejs20-debian11

COPY public/ /app/public/
COPY --from=build /app/node_modules /app/node_modules

WORKDIR /app

CMD ["node_modules/.bin/http-server", "public", "-p", "3000"]