FROM node:14-alpine
# Uncomment the line above if you want to use a Dockerfile instead of templateId


RUN apk update && apk upgrade && \
    apk add --no-cache git
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY ./ /usr/src/app/
RUN npm ci
#run --production && npm cache clean --force
#COPY ./ /usr/src/app
RUN npm run build
ENV NODE_ENV=production

RUN addgroup --system --gid 1001 nodejs
RUN adduser --system --uid 1001 nextjs

USER nextjs

ENV PORT 80
EXPOSE 80

CMD [ "npm", "run", "start" ]
