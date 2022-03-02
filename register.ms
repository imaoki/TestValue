/*! © 2021 imaoki | MIT License | https://github.com/imaoki */
(
  fileIn "TestValue.ms"

  if isProperty ::startupScriptLoader "RegisterScript" do (
    ::startupScriptLoader.RegisterScript (getSourceFileName())
  )
  ok
)
