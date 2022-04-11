/*! © 2022 imaoki | MIT License | https://github.com/imaoki */
(
  /* 初期化 */
  local mp = ::MxsPackStruct (getSourceFileName())
  /* 出力先ディレクトリ削除 */
  -- mp.DeleteDirectory @".\Distribution"

  /* コード切り出し */
  local TestValueCode = mp.ClipFile @".\TestValue.ms" 1 -1

  /* コード置換 */
  local code = TestValueCode

  /* インストールコード追加 */
  code = mp.AppendText code "::TestValueStruct.Install()\n::TestValueStruct\n"
  /* インストーラーオプション削除 */
  code = mp.RemoveInstallerOption code
  /* バンドルファイルを保存 */
  -- mp.WriteAllText @".\Distribution\TestValue.bundle.ms" code
  /* 最小化ファイルを保存 */
  code = mp.Minify code
  mp.WriteAllText @".\Distribution\TestValue.min.ms" code
  ok
)
