# WSL2用のDockerfile

WSL2上でGUI環境や日本語入力に必要なパッケージをDockerfileにまとめました。

## 動作環境
- Windows 10。Windows Subsystem for Linux 2へ更新済みなこと
- [Docker Desktop](https://www.docker.com/products/docker-desktop) を導入済み
- [VcXsrv](https://sourceforge.net/projects/vcxsrv/)などのXサーバーが起動している

## 使い方

既存のWSL環境にてイメージファイルの作成

```shell
$ git clone git@github.com:s1140227/wsl2-jp-genie.git
$ cd wsl2-jp-genie
$ docker build -t workspace .
$ docker run --name workspace -it -d workspace
$ docker export --output workspace.tar workspace
$ mv workspace.tar /mnt/c/...
```

PowerShellにてWSLにインポート

```powershell
PS > wsl --import workspace ./workspace .\workspace.tar
PS > wsl --list --verbose
  NAME                   STATE           VERSION
* Ubuntu-18.04           Running         2
  docker-desktop-data    Running         2
  docker-desktop         Running         2
  workspace              Stopped         2
```

dockerコマンドを使いたいときなどは、必要に応じてデフォルト設定を変更してください。

```
PS > wsl --set-default workspace
```

## 特徴

- Ubuntu 18.04で作っています。お好きなデスクトップ環境を入れられます。
- fcitx-mozcを導入済みです。`$ fcitx-config-gtk3` にてキー設定を変更できます。
- x11-appsを導入済みです。 `$ xeyes` にてWindowsとの接続を確認できます。
- [systemd-genie](https://github.com/arkane-systems/genie) を導入済みです。`genie -s`で`systemd`が利用できるシェルになります。
- [snapd](https://github.com/snapcore/snapd) を導入済みです。上記`systemd`が利用できる環境にて[Snap Store](https://snapcraft.io/store) に掲載されているGUIアプリをインストールできます。
  - Sublime Textの例 `snap install sublime-text --classic`
