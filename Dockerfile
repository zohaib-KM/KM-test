FROM node:16-alpine AS builder
WORKDIR /app
COPY package.json .
COPY package-lock.json .
RUN npm install
COPY . .
RUN npm run build
FROM node:16-alpine
WORKDIR /frontend
RUN yarn global add serve
COPY --from=builder /app/build ./build
EXPOSE 3000
CMD [ "serve","-l","3000","-n","-s","build" ]
