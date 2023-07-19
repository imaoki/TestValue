# TestValue

<!-- [![GitHub release (latest by date)](https://img.shields.io/github/v/release/imaoki/TestValue)](https://github.com/imaoki/TestValue/releases/latest) -->
[![GitHub](https://img.shields.io/github/license/imaoki/TestValue)](https://github.com/imaoki/TestValue/blob/main/LICENSE)

各種アサーション用の機能を提供するテスト用の構造体。
<!-- Struct for testing that provides functionality for various assertions. -->

## ライセンス
<!-- ## License -->

[MIT License](https://github.com/imaoki/TestValue/blob/main/LICENSE)

## 開発環境
<!-- ## Development Environment -->

`3ds Max 2024`

## インストール
<!-- ## Install -->

`install.ms`を実行する。
<!-- Execute `install.ms`. -->

## アンインストール
<!-- ## Uninstall -->

`uninstall.ms`を実行する。
<!-- Execute `uninstall.ms`. -->

## 単一ファイル版
<!-- ## Single File Version -->

### インストール
<!-- ### Install -->

`Distribution\TestValue.min.ms`を実行する。
<!-- Execute `Distribution\TestValue.min.ms`. -->

### アンインストール
<!-- ### Uninstall -->

```maxscript
::TestValueStruct.Uninstall()
```

## 使い方
<!-- ## Usage -->

```maxscript
(
  local actual = ::TestValueStruct (findString "abc" "b")
  local expected = ::TestValueStruct 2
  assert (actual.Equals expected == true)
)
```
