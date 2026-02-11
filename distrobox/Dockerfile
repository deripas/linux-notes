FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

RUN apt update && apt install -y \
    ca-certificates \
    sudo \
    mc \
    zsh \
    docker-cli \
    git \
    locales \
    dbus \
    dbus-x11 \
    \
    # Chromium / CEF
    libnss3 \
    libnspr4 \
    libatk1.0-0 \
    libatk-bridge2.0-0 \
    libcups2 \
    libxkbcommon0 \
    libxcomposite1 \
    libxrandr2 \
    libxdamage1 \
    libxfixes3 \
    libgbm1 \
    libdrm2 \
    libpangocairo-1.0-0 \
    libgtk-3-0 \
    \
    # ALSA (critical for JCEF)
    libasound2t64 \
    libasound2-data \
    alsa-utils \
    \
    # X11 / Wayland
    libx11-6 \
    libx11-xcb1 \
    libxcb1 \
    libxcb-dri3-0 \
    libxcb-shm0 \
    libxcb-xfixes0 \
    libxrender1 \
    libxtst6 \
    libxi6 \
    \
    && locale-gen en_US.UTF-8 \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*
