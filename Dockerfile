# 使用 node 基础镜像
FROM node:20-slim

# 设置工作目录
WORKDIR /app

# 安装构建依赖
RUN apt-get update && apt-get install -y \
    python3 \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# 复制 package.json
COPY package.json ./

# 安装依赖（添加 --legacy-peer-deps 标志）
RUN npm install --legacy-peer-deps

# 复制源代码
COPY . .

# 构建应用
RUN npm run build

# 暴露端口
EXPOSE 3000

# 设置环境变量
ENV PORT 3000
ENV HOSTNAME "0.0.0.0"
ENV NODE_ENV production

# 启动应用
CMD ["npm", "start"]