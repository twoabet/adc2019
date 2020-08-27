Docker image
=================


事前の準備作業
--------------

### opt_miniconda3.tar.gzを作成する

`/opt/miniconda3/`に、Miniconda3がインストールされているとする。

``` bash
conda clean --all
tar -zcf opt_miniconda3.tar.gz --owner=1000 --group=1000 -C / opt/miniconda3
```

### ユーザーadcの初期パスワードについて

Dockerfileで指定している初期パスワードのハッシュ値は、以下のようにして求めた。

```
$ perl -e 'print crypt("adc-User", "\$6\$ipsjdasadc"), "\n";'
$6$ipsjdasadc$j3jCv7RIO3CDs4dBWBsRHvLAjQe3tln.TdQdRVcBTM6fa3FL7.jz7hkCRxtoQxq4eX64twQRwqdvtqHBaQDmR/
```

docker build
------------

``` bash
sudo docker build --tag ipsjdasadc/adc:20200827 .
sudo docker tag         ipsjdasadc/adc:20200827 ipsjdasadc/adc:latest
```

### docker push to Docker Hub

```
sudo docker login  # when required
sudo docker push ipsjdasadc/adc:20200827
sudo docker push ipsjdasadc/adc:latest
```

Docker Hub  
https://hub.docker.com/repository/docker/ipsjdasadc/adc


docker run
----------

以下のようなコマンドを実行すればよい。シェルスクリプト`docker-run.sh`を用意してある。ただし、後述のように、必ず環境変数を設定してから実行すべきである。

``` bash
docker run \
       --name adc2020 \
       -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
       -v /tmp/adc2020:/run \
       -p 20022:22 \
       -p 20080:8888 \
       ipsjdasadc/adc:latest
```

- ホストがUbuntuの場合、`/run`のvolume mountが必要だと[書かれていた](https://hub.docker.com/_/centos)。snapでインストールしたdockerのせいか、実際には`/tmp/snap.docker/tmp/adc2020/`が使われていた。


### 環境変数を用いたカスタマイズ（必須）

dockerに関係なく一般に、serverを起動する前には、ファイル`adc2019/server/adcconfig.py`、`adc2019/server/adcusers.py`を生成しておく必要がある。

dockerコンテナが起動する場合、`adc2019/scripts/04_server.sh`の初回実行時に、環境変数の値に基づいて、ファイル`adc2019/server/adcconfig.py`、`adc2019/server/adcusers.py`が生成される。

設定すべき環境変数は以下の通り。

- `ADC_YEAR`の値が、`adcconfig.py`の`YEAR`に設定される(default: `2020`)
- `ADC_SECRET_KEY`の値が、`adcconfig.py`の`SECRET_KEY`に設定される(default: `Change_this_secret_key!!`)
- `ADC_SALT`の値が、`adcconfig.py`の`SALT`に設定される(default: `Change_this_salt!!!`)
- `ADC_PASS_ADMIN`の値が、ユーザーadministratorのパスワードになる（ファイル`adcusers.py`に反映される。default: `Change_admin_password!!`）
- `ADC_USER_ADMIN`の値が、ファイル`adcusers.yaml`に反映される(default: `Change_user_password!!!`)。このファイルはserver起動には、何も影響しない。ユーザー登録作業のためのskeltonファイルのようなものである。(注意) 初回起動時に、administrator以外の全ユーザーが、自動登録されるようなことはない。[adc2019/client-app/README.md](../client-app/README.md)にて説明している方法で、ユーザー登録をする必要がある

以上の理由から、`docker-run.sh`は、たとえば以下のように実行する。

``` bash
env ADC_YEAR="2020" ADC_SECRET_KEY="__change_here__" ADC_SALT="__change_here__" ADC_PASS_ADMIN="__change_here__" sudo -E ./docker-run.sh
```

### serverの動作確認

``` bash
curl http://localhost:20080/api/version
```

```
$ curl http://localhost:20080/api/version
{"version": 2020}
```


### コンテナにSSHログインする

SSHは必須ではないが、Emacsのtrampのように、SSH経由でファイルを編集できるエディタがあるので、あればあったで便利である。

``` bash
ssh -v -p 20022 adc@localhost
```

初期パスワードは、上の方に、わかりにくくして書いてある。

#### `$HOME/.ssh/config`の記述例

```
host adc2020
     HostName localhost
     port 20022
     User adc
```

Emacs trampでは、`/ssh:adc@adc2020:`でアクセス。
