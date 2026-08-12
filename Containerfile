FROM node:16.14.2-bullseye AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .

ENV BASE_PATH=/core
ENV NEXT_PUBLIC_BASE_PATH=/core

RUN npm run build

FROM node:16.14.2-bullseye-slim

WORKDIR /app

ENV NODE_ENV=production
ENV PORT=3000
ENV BASE_PATH=/core
ENV NEXT_PUBLIC_BASE_PATH=/core

COPY package*.json ./
RUN npm ci --omit=dev

COPY --from=build /app/.next ./.next
COPY --from=build /app/public ./public
COPY --from=build /app/next.config.js ./next.config.js

EXPOSE 3000

CMD ["npm", "start", "--", "-p", "3000"]
