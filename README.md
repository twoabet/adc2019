DA Symposium 2020 Algorithm Design Contest (DAS ADC 2020)
=========================================================

このレポジトリには、[DAシンポジウム](http://www.sig-sldm.org/das/)2020にて開催される、[アルゴリズムデザインコンテスト](https://dasadc.github.io/)(ADC)で使用するソフトウェアが登録されてます。

#### 関連ページ

- [Official Web Site](https://dasadc.github.io/)
- [DAS ADC 2020 rules](https://dasadc.github.io/adc2020/rule.html)


****
以下の記述は、昔の内容のままで、更新されていない場合があります。
****


問題データと回答データのチェックツール
--------------------------------------

- [adc2019.pyの使い方](server/adc2019.md)

※ 下記のADC自動運営システムには、このチェックツールと同等の機能が内蔵されています。[ウェブブラウザ上で実行できるウェブアプリ](client-app/README.md)で、チェックすることも可能です。


### このチェックツールの目的

- 参加チームは、最大3問まで、問題を自作して当日提供できます。その問題データの書式が正しいかを、確認できます。
- 回答データの書式が正しいかを、確認できます。このためには、問題データも必要です。



ADC自動運営システム
-------------------

- [自動運営システムの利用方法](conmgr.md)
- [自動運営システムをウェブブラウザから使う(ウェブアプリ client-app)](client-app/README.md)
- [自動運営システムの詳細マニュアル](client/README.md)
    - ドキュメントが古いままですが、基本的なところは、*だいたい*、あってます。近日更新予定です。

ADCを運営するためのシステムについて説明しています。

各参加チームには、事前に、ユーザーアカウント情報（ユーザー名とパスワード）が配布されます。

現在、インターネット上で、動作確認用のダミーシステムが動作していますので、ダミーシステムにログインして、システムの使い方を確認しておいてください。
システムのバグ出しの目的も兼ねています。

ダミーシステム上で、パスワードを変更することが可能ですが、本番のアルゴリズムデザインコンテストでは、初期パスワードに戻る可能性があります。その点、ご注意ください。
