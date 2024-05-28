FROM node:20 AS build-vite

COPY package.json package-lock.json /app/

WORKDIR /app

RUN npm ci

COPY src/ /app/src/
COPY public/ /app/public/
COPY index.html vite.config.js tsconfig.json /app/

RUN npm run build

FROM node:20 AS build-server

COPY --from=build-vite /app/package.json /app/
COPY --from=build-vite /app/package-lock.json /app/

WORKDIR /app

RUN npm ci --omit=dev

FROM gcr.io/distroless/nodejs20-debian11

WORKDIR /app

COPY --from=build-vite /app/dist /app/dist
COPY --from=build-vite /app/src/server.js /app/
COPY --from=build-vite /app/package.json /app/
COPY --from=build-server /app/node_modules /app/node_modules

CMD ["server.js"]