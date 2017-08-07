# デザインパターン

# 本日共有する概要
見てきたor 使ってきたデザインパターン
iOSアプリ開発での使用例(GoF切り口)

## 1. 生成に関するパターン
### Builder　

![Builder](img/640px-Builder_UML_class_diagram.svg.png)

オフライン会計データ送信に於けるmodelオブジェクトからJSONオブジェクト生成

![オフライン会計データ送信](img/offlineCheckDto.png)
```swift

```
### Singleton
ファイル管理クラス UserDefault

## 2. 構造に関するパターン
### Adapter　
WrapperにしてI/Fを既存のものに合わせる。　本来は、依存関係をカプセル化 GoogleAnalytics, FabricなどのT
### Decorator
画像生成(レシート[カスタマ、オーダー]、ジャーナル)
会計情報に対して、税金情報、割引情報、店舗情報、チップ、クレジットカード情報(カードNo. 会社、サイン)
返金
(ジャーナル)
### Composite
ディレクトリ構造

### Bridge
Printer Driver

## 3. 振る舞いに関するパターン

### [Strategy](https://ja.wikipedia.org/wiki/Strategy_パターン#/media/File:StrategyPatternClassDiagram.svg)
レジアプリ　税計算、割引按分計算
相続税計算アプリ　土地路線価計算

### Command
履歴の積み上げと再実行、Printerへの印刷コマンドの抽象化、

### Facade

### State
networkオーディオfirmwareとのI/F
HTTP + XML


### その他
NSOpereation

流動的要素は、クラスにして集約で持たせる


継承だと、継承の爆発が発生する。

例


```swift
final FileManager {
  let shared = FileManager()

  private init() {}

  func create() {
    //
  }

  func delete() {
    //
  }
}

```

#
http://monopocket.jp/todo/objective-c-design-pattern/
## iOS
1. MVC
2. delegate
3. Target - Action

## 書籍
1. オブジェクト指向のこころ
2. デザインパターン

## 設計

＃ パラダイム
