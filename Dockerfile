FROM node:18-alpine

ENV NODE_ENV=production
ARG NPM_BUILD="npm install --omit=dev"
EXPOSE 8080/tcp

LABEL maintainer="TitaniumNetwork Ultraviolet Team"
LABEL summary="Ultraviolet Proxy Image"
LABEL description="Example application of Ultraviolet which can be deployed in production."

WORKDIR /app

COPY ["package.json", "package-lock.json", "./"]

# Disable corepack and uninstall it entirely
RUN corepack disable && apk del corepack

# Install pnpm manually via npm
RUN npm install -g pnpm@8.4.0

# Install dependencies with pnpm
RUN pnpm install
RUN $NPM_BUILD

COPY . .

ENTRYPOINT [ "node" ]
CMD ["src/index.js"]
