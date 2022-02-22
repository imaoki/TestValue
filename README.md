# TestValue

各種アサーション用の機能を提供するテスト用の構造体。

## 動作確認

`3ds Max 2022.3 Update`

## スクリプトの実行とスタートアップへの登録

`register.ms`を実行する。

## スタートアップから登録解除する

`unregister.ms`を実行する。

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
