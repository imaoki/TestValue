# TestValue

<!-- [![GitHub release (latest by date)](https://img.shields.io/github/v/release/imaoki/TestValue)](https://github.com/imaoki/TestValue/releases/latest) -->
[![GitHub](https://img.shields.io/github/license/imaoki/TestValue)](https://github.com/imaoki/TestValue/blob/main/LICENSE)

Struct for testing that provides functionality for various assertions.
<!-- 各種アサーション用の機能を提供するテスト用の構造体。 -->

## Development Environment
<!-- 開発環境 -->

`3ds Max 2024`

## Install
<!-- インストールする -->

Execute `install.ms`.
<!-- `install.ms`を実行する。 -->

## Uninstall
<!-- アンインストールする -->

Execute `uninstall.ms`.
<!-- `uninstall.ms`を実行する。 -->

## Standalone version
<!-- スタンドアローン版 -->

### Install
<!-- インストールする -->

Execute `Distribution\TestValue.min.ms`.
<!-- `Distribution\TestValue.min.ms`を実行する。 -->

### Uninstall
<!-- アンインストールする -->

```maxscript
::TestValueStruct.Uninstall()
```

## Usage
<!-- 使い方 -->

```maxscript
(
  local actual = ::TestValueStruct (findString "abc" "b")
  local expected = ::TestValueStruct 2
  assert (actual.Equals expected == true)
)
```

## License
<!-- ライセンス -->

[MIT License](https://github.com/imaoki/TestValue/blob/main/LICENSE)
