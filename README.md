# TestValue

各種アサーション用の機能を提供するテスト用の構造体。

## 動作確認

`3ds Max 2022.3 Update`

## インストール

`install.ms`を実行する。

## アンインストール

`uninstall.ms`を実行する。

## スタンドアローン版

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
  assert (actual.IsInteger() == true)
  local expected = ::TestValueStruct 2
  assert (actual.Equals expected == true)
)
```

## ライセンス

[MIT License](https://github.com/imaoki/TestValue/blob/main/LICENSE)
