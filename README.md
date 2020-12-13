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
