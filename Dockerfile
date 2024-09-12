FROM archlinux:base-devel

RUN pacman -Syu --noconfirm namcap

RUN useradd -m builder

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
