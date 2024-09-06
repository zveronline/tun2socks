FROM xjasonlyu/tun2socks

COPY --chown=0:0 --chmod=755 entrypoint.sh /entrypoint.sh
