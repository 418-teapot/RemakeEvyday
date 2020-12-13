# RemakeEvyday

仅供本人使用的配置同步仓库（重装系统太麻烦了，有空整理一下每一步的操作，咕咕咕🕊

## 删除双系统的 EFI 引导

以下均在 Windows 系统下进行

- 用管理员权限打开 powershell

- 首先将 EFI 分区挂载

```powershell
diskpart
list disk
select disk 0 # 这里通常要选择 C 盘对应的磁盘
list partition
select partition 1 # 这里要选择系统分区
assign letter=P: # 挂载到 P 盘上
exit
```

- 然后使用管理员权限进入 EFI 分区

```powershell
cd P:/EFI/
ls # 可以看到所有 EFI 引导
rm ...
```

- 删除完成后移除盘符

```powershell
diskpart
select disk 0
select partition 1
remove letter=P:
exit
```

## manjaro 配置

### 基础开发包和 yay

```bash
sudo pacman -S base-devel yay
```

### fcitx5 输入法

- 安装主题和必要包

```bash
sudo pacman -S fcitx5 fcitx5-chinese-addons fcitx5-qt fcitx5-gtk kcm-fcitx5
```

`fcitx5` 为主体，`fcitx5-chinese-addons` 中文输入方式支持

`fcitx5-qt`: 对 `Qt5` 程序的支持

`fcitx5-gtk`: 对 `GTK` 程序的支持

`kcm-fcitx5`: `KDE` 下的配置工具

- 配置环境变量

```bash
sudo vim ~/.pam_environment

INPUT_METHOD  DEFAULT=fcitx5
GTK_IM_MODULE DEFAULT=fcitx5
QT_IM_MODULE  DEFAULT=fcitx5
XMODIFIERS    DEFAULT=\@im=fcitx5
```

其他配置参阅 [ArchWiKi](https://wiki.archlinux.org/index.php/Fcitx5_(%E7%AE%80%E4%BD%93%E4%B8%AD%E6%96%87))

- 安装中文字体(可选)

`manjaro` 自带的有中文字体，这一步选配

```bash
sudo pacman -S adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
```

- 安装主题

```bash
sudo pacman -S fcitx5-material-color
```

[项目地址](https://github.com/hosxy/Fcitx5-Material-Color)

修改配置文件 `~/.config/fcitx5/conf/classicui.conf`

```bash
# 垂直候选列表
Vertical Candidate List=False

# 按屏幕 DPI 使用
PerScreenDPI=True

# Font (设置成你喜欢的字体)
Font="思源黑体 CN Medium 13"

# 主题
Theme=Material-Color-Pink
```
