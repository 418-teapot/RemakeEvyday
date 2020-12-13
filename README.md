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

### 换源

- 换源

```bash
sudo pacman-mirrors -i -c China -m rank
sudo pacman-mirrors -g
sudo pacman -Syyu
```

- 添加 archlinuxcn(可选)

```bash
sudo vim /etc/pacman.conf
#复制以下配置到文件末尾
[archlinuxcn]
SigLevel = Optional TrustAll
Server = https://mirrors.tuna.tsinghua.edu.cn/archlinuxcn/$arch
Server = https://mirrors.ustc.edu.cn/archlinuxcn/$arch

sudo pacman -Syyu
sudo pacman -S archlinuxcn-keyring
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

- 安装词库

可以从 kcm-fcitx5 的配置里面添加搜狗词库

也可以下载[肥猫百万词库](https://github.com/felixonmars/fcitx5-pinyin-zhwiki)

```bash
yay -S fcitx5-pinyin-zhwiki
```

- 安装中文字体(可选)

`manjaro` 自带的有中文字体，这一步选配

```bash
sudo pacman -S adobe-source-han-sans-cn-fonts adobe-source-han-serif-cn-fonts
```

- 安装主题

```bash
sudo pacman -S fcitx5-material-color
```

[fcitx5-material-color 项目地址](https://github.com/hosxy/Fcitx5-Material-Color)

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

### dock 栏

```bash
sudo pacman -S latte-dock
```

### 全局菜单

- 全局菜单部件在 KDE 小部件中

- 最大化消除顶栏

```bash
sudo pacman -S plasma5-applets-active-window-control
```

拖到顶部面板后进行相关设置

`最大化窗口隐藏标题栏`: `ON`

`仅显示当前屏幕的活动窗口`: `ON`

`鼠标离开时依然显示`: `ON`

`在图标和文字旁显示`: `ON`

### vscode

```bash
yay -S visual-stduio-code-bin
```

配置使用 `vscode` 自带的同步功能进行同步

有时登陆帐号后会出现`将登陆信息写入密钥链失败`的错误，按照以下命令

```bash
sudo pacman -S gnome-keyring
```

### LaTex

```bash
sudo pacman -S texlive-most texlive-lang
```

使用 `vscode` 进行编写，`xelatex` 编译，`vscode` 中的设置已同步

### C/C++ 环境

```bash
sudo pacman -S cmake
```

`vscode` 中的 `cmake-tools` 有时会扫描不到 `kit`，这时要按下 `ctrl+shift+p` 输入 `Edit Usr-Local CMake Kits`,按照以下形式

```json
[
  {
    "name": "GCC",
    "compilers": {
      "C": "/bin/gcc",
      "CXX": "/bin/g++"
    }
  }
]
```
