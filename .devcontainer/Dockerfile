# Python 3.13ベース
FROM mcr.microsoft.com/devcontainers/python:3.13

# uv のインストール (公式の推奨インストールスクリプト)
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/

# 基本ツールのインストールと Node.js (LTS) のセットアップ
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    && curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# AWS CLI のインストール
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o /tmp/awscliv2.zip \
    && unzip /tmp/awscliv2.zip -d /tmp \
    && /tmp/aws/install \
    && rm -rf /tmp/awscliv2.zip /tmp/aws

# Claude Code のインストール
RUN npm install -g @anthropic-ai/claude-code

# エイリアスの永続化
RUN echo "alias ll='ls -l'" >> /home/vscode/.bashrc \
    && echo "alias la='ls -la'" >> /home/vscode/.bashrc
