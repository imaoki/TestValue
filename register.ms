/*! © 2021 imaoki | MIT License | https://github.com/imaoki */
(
  fileIn "TestValue.ms"

  if isProperty ::startupLoader "RegisterScript" do (
    ::startupLoader.RegisterScript (getSourceFileName())
  )
  ok
)
