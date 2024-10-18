FROM node:20-slim

# 设置工作目录
WORKDIR /app

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 复制 package.json 和 yarn.lock
COPY package.json yarn.lock ./

# 安装依赖（yarn 没有 --legacy-peer-deps，但 yarn 会自动处理依赖冲突）
RUN yarn install

# 复制源代码
COPY . .

# 构建应用
RUN yarn build

# 暴露端口
EXPOSE 3000

# 设置环境变量
ENV PORT 3000
ENV HOSTNAME "0.0.0.0"
ENV NODE_ENV production

# 启动应用
CMD ["yarn", "start"]