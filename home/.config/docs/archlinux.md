## 删除 `/boot/initramfs-linux-fallback.img` 节省 `/boot` 空间

- https://wusiyu.me/archlinux-remove-initramfs-linux-fallback-img/
- `sudo -E nvim /etc/mkinitcpio.d/linux.preset` 注释最后两行，防止下次更新时生成

## baloo file extractor 占用过高 CPU

设置 > 搜索 “文件搜索” > 关掉然后点击 “应用”
