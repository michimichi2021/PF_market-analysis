# 分析特化型フリマアプリ「market&analysisマケアナ」

## サイト概要
売り手側、買い手側の双方にとって売買履歴を閲覧できるフリマアプリを作りたいと考えました。
売り手側に関しては、売り切れ商品のジャンルの割合や売り切れた時間帯を視覚的に把握できるグラフなどの分析結果を表示しています。
このような分析結果によって、売り手側が商品出品時にSEO対策しやすいようなシステムを構築しています。
また、買い手側に関しては気になる商品を探しやすいように、ジャンル検索、商品検索の機能を盛り込みました。
さらに、今まで購入した商品の履歴表や収支計算を視覚的に把握できるグラフも表示しています。


### サイトテーマ
売り手買い手双方が売買履歴を視覚的に分析できるフリマアプリ

### テーマを選んだ理由
近年、コロナの影響下によって家からの外出がしづらい状況により、ECサイトやフリマアプリのような家でも買い物できるシステムの需要が高くなっています。そのため、より出品者や購入者が利用しやすいフリマアプリを制作し、売買しやすい環境を作りたいと考えました。

現在、存在するフリマアプリを使用している中で課題として感じているのは、売買履歴が視覚的に分かりやすく表されていないという点です。現状、売り手側がどの時間帯にどんなジャンルの商品が売れたかなどを視覚的に表すような分析結果がなく、商品出品時のSEO対策がしづらい状況にあります。また、商品を売買した際の収支計算が視覚的に表示されたグラフ等があれば、金額の計算に不安のない状態で買い手側が残高を確認し、商品が購入しやすくなると考えました。このように売り手側、買い手側の双方から需要の高いフリマアプリがあれば、より売買取引が活発になりやすい環境を作ることができると考えました。



### ターゲットユーザ
フリマサイト利用者

### 主な利用シーン
売り手側がどんな時間帯にどんなジャンルの商品が売れたかを把握したい時。
<br>買い手側が買いたい商品を検索し、購入する時。
<br>売り手側と買い手側双方が売買履歴を確認したい時。




## 設計書
ER図は<a href="https://drive.google.com/file/d/1VGwONfvTX67OHMCXwzgn7P04MffKQSsT/view?usp=sharing">こちら</a>から。
<br>UIFlows(会員側)は<a href="https://drive.google.com/file/d/1bKuY4FmWkTtqOrCAEthZF6OYC0LZeU8q/view?usp=sharing">こちら</a>から。
<br>UIFlows(管理者側)は<a href="https://drive.google.com/file/d/1cbsSwcPxbFwGDljfPyJHfa_d0nFv1sWE/view?usp=sharing">こちら</a>から。
<br>テーブル定義書は<a href="https://docs.google.com/spreadsheets/d/1jvXXFXfxdVHmPeCUnZYfvtepeUsEaLROKlTa93asea8/edit?usp=sharing">こちら</a>から。
<br>アプリケーション詳細設計は<a href="https://docs.google.com/spreadsheets/d/1p6xaJb8_doVWKGGm5xIXUgqCqywbm2Gb4lAcT_yEqpc/edit?usp=sharing">こちら</a>から。

## チャレンジ要素一覧 
チャレンジ要素一覧は<a href="https://docs.google.com/spreadsheets/d/110fEyaEPXngDYNROUz8QJfpwK9CyLewzbO5j75crsLA/edit#gid=0">こちら</a>から。


## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9


