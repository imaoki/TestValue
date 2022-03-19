/*! © 2022 imaoki | MIT License | https://github.com/imaoki */
(
  -- clearListener()

  local nowTime = (DotNetClass "System.DateTime").Now.ToString "HH:mm:ss"
  local sw = DotNetObject "System.Diagnostics.Stopwatch"

  local pathClass = DotNetClass "System.IO.Path"
  local currentFile = pathClass.GetFullPath (getSourceFileName())
  local currentDir = pathClass.GetDirectoryName currentFile
  (DotNetClass "System.Environment").CurrentDirectory = currentDir

  local actual
  local expected
  local testDef
  local testObj

  format "[run %]@\"%\"\n" nowTime currentFile
  /* Setup Start ------------------------------------------------------------ */
  local n
  local v1
  local v2

  testDef = fileIn (pathClass.GetFullPath @"..\TestValue.ms")
  /* Setup End -------------------------------------------------------------- */
  sw.Start()
  /* Test Start ------------------------------------------------------------- */
  /* 数が等しいかどうか */
  -- Array
  testObj = testDef #(1, 2)
  actual = testObj.CountEquals 2
  expected = true
  assert (actual == expected)
  -- BitArray
  testObj = testDef #{1, 2}
  actual = testObj.CountEquals 2
  expected = true
  assert (actual == expected)
  -- Dictionary
  testObj = testDef (Dictionary #("Foo", 1) #("Bar", 2))
  actual = testObj.CountEquals 2
  expected = true
  assert (actual == expected)

  /* 数が以上かどうか */
  -- Array
  testObj = testDef #(1, 2)
  actual = testObj.CountGreaterOrEquals 2
  expected = true
  assert (actual == expected)
  -- BitArray
  testObj = testDef #{1, 2}
  actual = testObj.CountGreaterOrEquals 2
  expected = true
  assert (actual == expected)
  -- Dictionary
  testObj = testDef (Dictionary #("Foo", 1) #("Bar", 2))
  actual = testObj.CountGreaterOrEquals 2
  expected = true
  assert (actual == expected)

  /* 数が超えるかどうか */
  -- Array失敗
  testObj = testDef #(1, 2)
  actual = testObj.CountGreaterThan 2
  expected = false
  assert (actual == expected)
  -- Array成功
  testObj = testDef #(1, 2)
  actual = testObj.CountGreaterThan 1
  expected = true
  assert (actual == expected)
  -- BitArray失敗
  testObj = testDef #{1, 2}
  actual = testObj.CountGreaterThan 2
  expected = false
  assert (actual == expected)
  -- BitArray成功
  testObj = testDef #{1, 2}
  actual = testObj.CountGreaterThan 1
  expected = true
  assert (actual == expected)
  -- Dictionary失敗
  testObj = testDef (Dictionary #("Foo", 1) #("Bar", 2))
  actual = testObj.CountGreaterThan 2
  expected = false
  assert (actual == expected)
  -- Dictionary成功
  testObj = testDef (Dictionary #("Foo", 1) #("Bar", 2))
  actual = testObj.CountGreaterThan 1
  expected = true
  assert (actual == expected)

  /* 数が以下かどうか */
  -- Array
  testObj = testDef #(1, 2)
  actual = testObj.CountLessOrEquals 2
  expected = true
  assert (actual == expected)
  -- BitArray
  testObj = testDef #{1, 2}
  actual = testObj.CountLessOrEquals 2
  expected = true
  assert (actual == expected)
  -- Dictionary
  testObj = testDef (Dictionary #("Foo", 1) #("Bar", 2))
  actual = testObj.CountLessOrEquals 2
  expected = true
  assert (actual == expected)

  /* 数が未満かどうか */
  -- Array失敗
  testObj = testDef #(1, 2)
  actual = testObj.CountLessThan 2
  expected = false
  assert (actual == expected)
  -- Array成功
  testObj = testDef #(1, 2)
  actual = testObj.CountLessThan 3
  expected = true
  assert (actual == expected)
  -- BitArray失敗
  testObj = testDef #{1, 2}
  actual = testObj.CountLessThan 2
  expected = false
  assert (actual == expected)
  -- BitArray成功
  testObj = testDef #{1, 2}
  actual = testObj.CountLessThan 3
  expected = true
  assert (actual == expected)
  -- Dictionary失敗
  testObj = testDef (Dictionary #("Foo", 1) #("Bar", 2))
  actual = testObj.CountLessThan 2
  expected = false
  assert (actual == expected)
  -- Dictionary成功
  testObj = testDef (Dictionary #("Foo", 1) #("Bar", 2))
  actual = testObj.CountLessThan 3
  expected = true
  assert (actual == expected)

  /* 大文字と小文字を区別する */
  testObj = testDef "a"
  actual = testObj.Equals (testDef "A")
  expected = false
  assert (actual == expected)

  /* 大文字と小文字を区別しない */
  testObj = testDef "a" IgnoreCase:true
  actual = testObj.Equals (testDef "A")
  expected = true
  assert (actual == expected)

  /* 異なるクラスの比較 */
  actual = testObj.Equals (testDef #a)
  expected = false
  assert (actual == expected)

  /* TestValueStruct以外のオブジェクトと比較 */
  actual = testObj.Equals "a"
  expected = false
  assert (actual == expected)

  /* `Equals`メソッドを持っていない */
  testObj = testDef "a"
  actual = testObj.HasEquals()
  expected = false
  assert (actual == expected)

  /* `Equals`メソッドを持っている */
  testObj = testDef (DotNetObject "System.String" "a")
  actual = testObj.HasEquals()
  expected = true
  assert (actual == expected)

  /* 名前値でプロパティを調査 */
  testObj = testDef (DataPair Zero:0 One:1)
  actual = testObj.HasProp #Zero
  expected = true
  assert (actual == expected)

  /* 文字列でプロパティを調査 */
  actual = testObj.HasProp "One"
  assert (actual == expected)

  /* AngleAxis */
  -- 型判定
  testObj  = testDef (AngleAxis 0 [1, 2, 3])
  actual = testObj.IsAngleAxis()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (AngleAxis 0 [1, 2, 3]))
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (
    testDef (AngleAxis 0.0000001 [1.0000001, 2.0000001, 3.0000001])
  )
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (
    testDef (AngleAxis 0.00001 [1.00001, 2.00001, 3.00001])
  )
  expected = false
  assert (actual == expected)

  /* Array */
  -- 型判定
  testObj  = testDef #(0, 1)
  actual = testObj.IsArray()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef #(0, 1))
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (testDef #(0.0000001, 1.0000001))
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef #(0.00001, 1.00001))
  expected = false
  assert (actual == expected)

  /* ArrayParameter */
  n = Point()
  n[3].Controller = PRS()
  n[3][1].Controller = Position_List()
  n[3][1].Controller.Available.Controller = Position_XYZ()
  n[3][1].Controller.Weight[1] = 0.0
  n[3][1].Controller.Weight[2] = 1.0
  -- 型判定
  testObj  = testDef n[3][1].Controller.Weight
  actual = testObj.IsArrayParameter()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef #(0.0, 1.0))
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (testDef #(0.0000001, 1.0000001))
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef #(0.00001, 1.00001))
  expected = false
  assert (actual == expected)
  -- ノード削除
  delete n

  /* AttributeDef */
  v1 = attributes TestAttr (
  )
  -- 型判定
  testObj = testDef v1
  actual = testObj.IsAttributeDef()
  expected = true
  assert (actual == expected)

  /* BigMatrix */
  v1 = BigMatrix 2 2
  v1[1][1] = 0
  v1[1][2] = 1
  v1[2][1] = 2
  v1[2][2] = 3
  -- 型判定
  testObj = testDef v1
  actual = testObj.IsBigMatrix()
  expected = true
  assert (actual == expected)
  -- 同値
  v2 = BigMatrix 2 2
  v2[1][1] = 0
  v2[1][2] = 1
  v2[2][1] = 2
  v2[2][2] = 3
  actual = testObj.Equals (testDef v2)
  expected = true
  assert (actual == expected)
  -- 近似値
  v2 = BigMatrix 2 2
  v2[1][1] = 0.0000001
  v2[1][2] = 1.0000001
  v2[2][1] = 2.0000001
  v2[2][2] = 3.0000001
  actual = testObj.Equals (testDef v2)
  expected = true
  assert (actual == expected)
  -- 異なる値
  v2 = BigMatrix 2 2
  v2[1][1] = 0.00001
  v2[1][2] = 1.00001
  v2[2][1] = 2.00001
  v2[2][2] = 3.00001
  actual = testObj.Equals (testDef v2)
  expected = false
  assert (actual == expected)

  /* BinStream */

  /* BitArray */
  -- 型判定
  testObj = testDef #{}
  actual = testObj.IsBitArray()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef #{})
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef #{1})
  expected = false
  assert (actual == expected)

  /* Bitmap */
  -- 型判定
  testObj = testDef (Bitmap 1 1)
  actual = testObj.IsBitmap()
  expected = true
  assert (actual == expected)

  /* BooleanClass */
  -- 型判定
  testObj = testDef true
  actual = testObj.IsBoolean()
  expected = true
  assert (actual == expected)

  /* Box2 */
  -- 型判定
  testObj = testDef (Box2 0 1 2 3)
  actual = testObj.IsBox2()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (Box2 0 1 2 3))
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef (Box2 1 2 3 4))
  expected = false
  assert (actual == expected)

  /* Box3 */
  -- 型判定
  testObj = testDef (Box3 [0, 1, 2] [3, 4, 5])
  actual = testObj.IsBox3()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (Box3 [0, 1, 2] [3, 4, 5]))
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (
    testDef (
      Box3 [0.0000001, 1.0000001, 2.0000001] [3.0000001, 4.0000001, 5.0000001]
    )
  )
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (
    testDef (
      Box3 [0.00001, 1.00001, 2.00001] [3.00001, 4.00001, 5.00001]
    )
  )
  expected = false
  assert (actual == expected)

  /* Color */
  -- 型判定
  testObj = testDef (Color 0 1 2 0.5)
  actual = testObj.IsColor()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (Color 0 1 2 0.5))
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef (Color 1 2 3 1.0))
  expected = false
  assert (actual == expected)

  /* DataPair */
  -- 型判定
  testObj = testDef (DataPair A:0 B:#(1, [2, 3]))
  actual = testObj.IsDataPair()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (DataPair A:0 B:#(1, [2, 3])))
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (
    testDef (DataPair A:0.0000001 B:#(1.0000001, [2.0000001, 3.0000001]))
  )
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (
    testDef (DataPair A:0.00001 B:#(1.00001, [2.00001, 3.00001]))
  )
  expected = false
  assert (actual == expected)

  /* Dictionary */
  -- 型判定
  testObj = testDef (Dictionary #("Foo", 1) #("Bar", 2))
  actual = testObj.IsDictionary()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (Dictionary #("Foo", 1) #("Bar", 2)))
  expected = true
  assert (actual == expected)
  -- 異なる値（キーのタイプ）
  actual = testObj.Equals (testDef (Dictionary #(#Foo, 1) #(#Bar, 1)))
  expected = false
  assert (actual == expected)
  -- 異なる値（値）
  actual = testObj.Equals (testDef (Dictionary #("Foo", 2) #("Bar", 3)))
  expected = false
  assert (actual == expected)

  /* DotNetClass */
  -- 型判定
  testObj = testDef (DotNetClass "System.String")
  actual = testObj.IsDotNetClass()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (DotNetClass "System.String"))
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef (DotNetClass "System.IO.Path"))
  expected = false
  assert (actual == expected)

  /* DotNetMethod */

  /* DotNetObject */
  -- 型判定
  testObj = testDef (DotNetObject "System.String" "a")
  actual = testObj.IsDotNetObject()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (DotNetObject "System.String" "a"))
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef (DotNetObject "System.String" "b"))
  expected = false
  assert (actual == expected)

  /* EulerAngles */
  -- 型判定
  testObj = testDef (EulerAngles 0 1 2)
  actual = testObj.IsEulerAngles()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (EulerAngles 0 1 2))
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (testDef (EulerAngles 0.0000001 1.0000001 2.0000001))
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef (EulerAngles 0.00001 1.00001 2.00001))
  expected = false
  assert (actual == expected)

  /* FileStream */

  /* Float */
  -- 型判定
  testObj = testDef 0.0
  actual = testObj.IsFloat()
  expected = true
  assert (actual == expected)

  /* Integer */
  -- 型判定
  testObj = testDef 0
  actual = testObj.IsInteger()
  expected = true
  assert (actual == expected)

  /* Interval */
  -- 型判定
  testObj = testDef (Interval 0 1)
  actual = testObj.IsInterval()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (Interval 0 1))
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef (Interval 1 2))
  expected = false
  assert (actual == expected)

  /* Matrix3 */
  -- 型判定
  testObj = testDef (Matrix3 [1, 0, 0] [0, 1, 0] [0, 0, 1] [2, 3, 4])
  actual = testObj.IsMatrix3()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (
    testDef (Matrix3 [1, 0, 0] [0, 1, 0] [0, 0, 1] [2, 3, 4])
  )
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (
    testDef (
      Matrix3 \
          [1.0000001, 0.0000001, 0.0000001] \
          [0.0000001, 1.0000001, 0.0000001] \
          [0.0000001, 0.0000001, 1.0000001] \
          [2.0000001, 3.0000001, 4.0000001]
    )
  )
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (
    testDef (
      Matrix3 \
          [1.00001, 0.00001, 0.00001] \
          [0.00001, 1.00001, 0.00001] \
          [0.00001, 0.00001, 1.00001] \
          [2.00001, 3.00001, 4.00001]
    )
  )
  expected = false
  assert (actual == expected)

  /* MAXKey */

  /* MAXScriptFunction */
  v1 = fn a = 0
  -- 型判定
  testObj = testDef v1
  actual = testObj.IsMAXScriptFunction()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef v1)
  expected = true
  assert (actual == expected)
  -- 異なる値
  v2 = fn b = 0
  actual = testObj.Equals (testDef v2)
  expected = false
  assert (actual == expected)

  /* Name */
  -- 型判定
  testObj = testDef #A
  actual = testObj.IsName()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef #A)
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef #B)
  expected = false
  assert (actual == expected)

  /* Number */
  -- 型判定
  testObj = testDef 0
  actual = testObj.IsNumber()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef 0)
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (testDef 0.0000001)
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef 0.00001)
  expected = false
  assert (actual == expected)

  /* OkClass */
  -- 型判定
  testObj = testDef ok
  actual = testObj.IsOk()
  expected = true
  assert (actual == expected)

  /* Point2 */
  -- 型判定
  testObj = testDef [0, 1]
  actual = testObj.IsPoint2()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef [0, 1])
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (testDef [0.0000001, 1.0000001])
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef [0.00001, 1.00001])
  expected = false
  assert (actual == expected)

  /* Point3 */
  -- 型判定
  testObj = testDef [0, 1, 2]
  actual = testObj.IsPoint3()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef [0, 1, 2])
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (testDef [0.0000001, 1.0000001, 2.0000001])
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef [0.00001, 1.00001, 2.00001])
  expected = false
  assert (actual == expected)

  /* Point4 */
  -- 型判定
  testObj = testDef [0, 1, 2, 3]
  actual = testObj.IsPoint4()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef [0, 1, 2, 3])
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (testDef [0.0000001, 1.0000001, 2.0000001, 3.0000001])
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef [0.00001, 1.00001, 2.00001, 3.00001])
  expected = false
  assert (actual == expected)

  /* Quat */
  -- 型判定
  testObj = testDef (Quat 0 1 2 3)
  actual = testObj.IsQuat()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (Quat 0 1 2 3))
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (
    testDef (Quat 0.0000001 1.0000001 2.0000001 3.0000001)
  )
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef (Quat 0.00001 1.00001 2.00001 3.00001))
  expected = false
  assert (actual == expected)

  /* Ray */
  -- 型判定
  testObj = testDef (Ray [0, 1, 2] [0, 0, 1])
  actual = testObj.IsRay()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (Ray [0, 1, 2] [0, 0, 1]))
  expected = true
  assert (actual == expected)
  -- 近似値
  actual = testObj.Equals (
    testDef (Ray [0.0000001, 1.0000001, 2.0000001] [0, 0, 1])
  )
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef (Ray [0.00001, 1.00001, 2.00001] [0, 0, 1]))
  expected = false
  assert (actual == expected)

  /* RegexObject */
  -- 型判定
  testObj = testDef (DotNetObject "System.Text.RegularExpressions.Regex" "a")
  actual = testObj.IsRegexObject()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (
    testDef (DotNetObject "System.Text.RegularExpressions.Regex" "a")
  )
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (
    testDef (DotNetObject "System.Text.RegularExpressions.Regex" "b")
  )
  expected = false
  assert (actual == expected)

  /* RolloutClass */
  v1 = rollout TestRollout "" (
  )
  -- 型判定
  testObj = testDef v1
  actual = testObj.IsRollout()
  expected = true
  assert (actual == expected)

  /* String */
  -- 型判定
  testObj = testDef "a"
  actual = testObj.IsString()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef "a")
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef "b")
  expected = false
  assert (actual == expected)

  /* StringStream */
  -- 型判定
  testObj = testDef (StringStream "a")
  actual = testObj.IsStringStream()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef (StringStream "a"))
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef (StringStream "b"))
  expected = false
  assert (actual == expected)

  /* StructDefinition */
  -- 型判定
  testObj = testDef testDef
  actual = testObj.IsStructDefinition()
  expected = true
  assert (actual == expected)

  /* StructInstance */
  -- 型判定
  testObj = testDef (testDef 0)
  actual = testObj.IsStructInstance()
  expected = true
  assert (actual == expected)

  /* Time */
  -- 型判定
  testObj = testDef 0f
  actual = testObj.IsTime()
  expected = true
  assert (actual == expected)
  -- 同値
  actual = testObj.Equals (testDef 0f)
  expected = true
  assert (actual == expected)
  -- 異なる値
  actual = testObj.Equals (testDef 1f)
  expected = false
  assert (actual == expected)

  /* UndefinedClass */
  -- 型判定
  testObj = testDef undefined
  actual = testObj.IsUndefined()
  expected = true
  assert (actual == expected)

  /* UnsuppliedClass */
  -- 型判定
  testObj = testDef unsupplied
  actual = testObj.IsUnsupplied()
  expected = true
  assert (actual == expected)

  /* WindowStream */
  -- 型判定
  testObj = testDef listener
  actual = testObj.IsWindowStream()
  expected = true
  assert (actual == expected)
  /* Test End --------------------------------------------------------------- */
  sw.Stop()
  /* Teardown Start --------------------------------------------------------- */
  /* Teardown End ----------------------------------------------------------- */
  format "[end %]%ms\n" nowTime (sw.ElapsedMilliseconds as Integer)
  ok
)
