FROM node:14.9-stretch as builder

COPY . /src

RUN cd /src && \
  git clean -ffdX && \
  npm run dist

FROM node:14.9-stretch

COPY --from=builder /src/dist /app

RUN useradd basco

USER basco

WORKDIR /app

ENTRYPOINT ["node", "--unhandled-rejections=strict", "app.js"]
