FROM tiryoh/ros-desktop-vnc:melodic

ENV DEBIAN_FRONTEND=noninteractive

# NVIDIAのドライバをインストールする例 ２) バージョンを指定してインストール
# 参考：https://gitlab.com/nvidia/container-images/driver/-/blob/master/ubuntu18.04/Dockerfile
ARG BASE_URL=https://us.download.nvidia.com/tesla
ARG DRIVER_VERSION=450.80.02
ENV DRIVER_VERSION=$DRIVER_VERSION

RUN apt-get update -q && apt-get install -y --no-install-recommends \
    xorg \
    && rm -rf /var/lib/apt/lists/*

RUN cd /tmp && \
    curl -fSsl -O $BASE_URL/$DRIVER_VERSION/NVIDIA-Linux-x86_64-$DRIVER_VERSION.run && \
    sh NVIDIA-Linux-x86_64-$DRIVER_VERSION.run -x && \
    cd NVIDIA-Linux-x86_64-$DRIVER_VERSION* && \
    ./nvidia-installer --silent \
                       --no-kernel-module \
                       --install-compat32-libs \
                       --no-nouveau-check \
                       --no-nvidia-modprobe \
                       --no-rpms \
                       --no-backup \
                       --no-check-for-alternate-installs \
                       --no-libglx-indirect \
                       --no-install-libglvnd && \
    rm -rf /tmp/*

# VSCodium
RUN wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg && \
    echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://paulcarroty.gitlab.io/vscodium-deb-rpm-repo/debs vscodium main' \
    | tee /etc/apt/sources.list.d/vscodium.list

RUN apt-get update -q && apt-get install -y --no-install-recommends \
    codium \
    && rm -rf /var/lib/apt/lists/*

RUN gosu ubuntu echo 'export DONT_PROMPT_WSL_INSTALL=1' >> /home/ubuntu/.bashrc && \
    gosu ubuntu bash -c "DONT_PROMPT_WSL_INSTALL=1 codium --install-extension ms-ceintl.vscode-language-pack-ja" && \
    gosu ubuntu bash -c "DONT_PROMPT_WSL_INSTALL=1 codium --install-extension ms-python.python"

# 必要なファイルのコピー
COPY rootfs /

# 解像度の反映コマンド
RUN echo "sh /usr/local/bin/xrandr_exec.sh" >> /home/ubuntu/.bashrc

ENTRYPOINT ["/startup_nvidia.sh" ]

ENV DEBIAN_FRONTEND=newt
