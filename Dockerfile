FROM node:lts-alpine

RUN apk update

# 安装 chromium 及要用到的工具
RUN apk add -f chromium ffmpeg git wget

# 克隆koishi-bp
RUN git clone https://github.com/initialencounter/koimux_bot

# 修改端口
RUN sed -i 's/port: 5140/port: 7860/g' /koimux_bot/koishi.yml

# 避免 go-cqhttp 安装失败
RUN mkdir /.local
RUN chmod -R 777 /.local

# 安装依赖
RUN cd /koimux_bot; npm i

# 修改权限防止抱错
RUN chmod -R 777 /koimux_bot
RUN mkdir /.npm
RUN chmod -R 777 /.npm

# 设置工作目录
WORKDIR "/koimux_bot"

# 设置启动命令
CMD ["npm", "start"]
