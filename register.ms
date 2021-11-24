/*! © 2021 imaoki | MIT License | https://github.com/imaoki */
(
  fileIn "TestValue.ms"
  format "[define]::TestValueStruct\n"

  if isProperty ::startupScriptLoader "RegisterScript" do (
    ::startupScriptLoader.RegisterScript (getSourceFileName())
    ::startupScriptLoader.Save()
  )
  ok
)
