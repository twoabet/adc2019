ADC2019 Web application
=======================


初期設定
--------

Ubuntu 18.04では、aptでインストールされるnode.jsが古い。anacondaのnpmを使う。

一番最初のとき

```
npm init
npm install @angular/cli
npm install typescript
npm install http-server
npm install ngx-file-drop --save
```

2回目以降

```
npm install
```

実行する
---------

### (frontend) Angular, development server

```
$(npm bin)/ng serve --proxy-config proxy.conf.json --live-reload --watch --poll 9999
または
npm run test-run
```

http://localhost:4200/


## deploy前のテスト実行方法

ビルドする。

```
cd client-app/
$(npm bin)/ng build --prod --base-href=/static/app/index.html --output-path=../server/static/app/
または
npm run build
```

実行する。

```
cd server/
gunicorn main:app
ポート番号8000がすでに使われていて変更したいとき
gunicorn -b :28000 --access-logfile '-' main:app
```

- http://127.0.0.1:8000/static/app/index.html
- http://127.0.0.1:28000/static/app/index.html

もしも、開発中のAPI serverのdevelopment serverが動き続けているなら、それも使える。

- http://127.0.0.1:4280/static/app/index.html