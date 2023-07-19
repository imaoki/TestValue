# TestValue

<!-- [![GitHub release (latest by date)](https://img.shields.io/github/v/release/imaoki/TestValue)](https://github.com/imaoki/TestValue/releases/latest) -->
[![GitHub](https://img.shields.io/github/license/imaoki/TestValue)](https://github.com/imaoki/TestValue/blob/main/LICENSE)

各種アサーション用の機能を提供するテスト用の構造体。

## ライセンス

[MIT License](https://github.com/imaoki/TestValue/blob/main/LICENSE)

## 要件

* （任意）[imaoki/StartupLoader](https://github.com/imaoki/StartupLoader)
  導入済みの場合はインストール/アンインストールでスタートアップスクリプトの登録/解除が行われる。
  未使用の場合はスクリプトの評価のみ行われる。

## 開発環境

`3ds Max 2024`

## インストール

`install.ms`を実行する。

## アンインストール

`uninstall.ms`を実行する。

## 単一ファイル版

### インストール

`Distribution\TestValue.min.ms`を実行する。

### アンインストール

```maxscript
::TestValueStruct.Uninstall()
```

## 使い方

```maxscript
(
  local actual = ::TestValueStruct (findString "abc" "b")
  local expected = ::TestValueStruct 2
  assert (actual.Equals expected == true)
)
```
