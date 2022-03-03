/*! © 2021 imaoki | MIT License | https://github.com/imaoki */
/*-
各種アサーション用の機能を提供するテスト用の構造体。
*/
struct TestValueStruct (
  /*-
  @prop <Any> 作成パラメータ1。初期化用の値。既定値は`undefined`。
  */
  public _CP1_,

  /*- @prop <BooleanClass> 文字列の比較の際に大文字と小文字を区別しない場合は`true`、区別する場合は`false`。既定値は`false`。 */
  public IgnoreCase = false,

  /*- @prop <Any> */
  private v,

  /*- @prop <DotNetClass:System.Text.RegularExpressions.Regex> */
  private regexClass = DotNetClass "System.Text.RegularExpressions.Regex",
  /*- @prop <DotNetObject:System.Type> */
  private regexType,

  /*
  public fn CountEquals count = (),
  public fn CountGreaterOrEquals count = (),
  public fn CountGreaterThan count = (),
  public fn CountLessOrEquals count = (),
  public fn CountLessThan count = (),
  public fn GetValue = (),
  public fn HasEquals = (),
  public fn HasProp propName = (),
  public fn Uninstall = (),

  public fn IsAngleAxis = (),
  public fn IsArray = (),
  public fn IsArrayOrArrayParameter = (),
  public fn IsArrayParameter = (),
  public fn IsAttributeDef = (),
  public fn IsBigMatrix = (),
  public fn IsBinStream = (),
  public fn IsBitArray = (),
  public fn IsBitmap = (),
  public fn IsBoolean = (),
  public fn IsBox2 = (),
  public fn IsBox3 = (),
  public fn IsColor = (),
  public fn IsDataPair = (),
  public fn IsDictionary = (),
  public fn IsDotNetClass = (),
  public fn IsDotNetMethod = (),
  public fn IsDotNetObject = (),
  public fn IsEulerAngles = (),
  public fn IsFileStream = (),
  public fn IsFloat = (),
  public fn IsInteger = (),
  public fn IsInterval = (),
  public fn IsMatrix3 = (),
  public fn IsMAXKey = (),
  public fn IsMAXScriptFunction = (),
  public fn IsName = (),
  public fn IsNumber = (),
  public fn IsOk = (),
  public fn IsPoint2 = (),
  public fn IsPoint3 = (),
  public fn IsPoint4 = (),
  public fn IsQuat = (),
  public fn IsRay = (),
  public fn IsRegexObject = (),
  public fn IsRollout = (),
  public fn IsString = (),
  public fn IsStringStream = (),
  public fn IsStructDefinition = (),
  public fn IsStructInstance = (),
  public fn IsTestValue obj = (),
  public fn IsTime = (),
  public fn IsUndefined = (),
  public fn IsUnsupplied = (),
  public fn IsWindowStream = (),

  private fn escapeBackslash input = (),
  private fn valueToString input = (),
  */

  /*-
  コレクションの要素数が指定の数と等しいかどうかを判定する。
  @param count <Integer>
  @returns <BooleanClass>
  */
  public fn CountEquals count = (
    local result = false
    case of (
      (this.IsArrayOrArrayParameter()): result = this.v.Count == count
      (this.IsBitArray()): result = this.v.NumberSet == count
      (this.IsDictionary()): result = this.v.Count == count
      default: ()
    )
    result
  ),

  /*-
  コレクションの要素数が指定の数以上かどうかを判定する。
  @param count <Integer>
  @returns <BooleanClass>
  */
  public fn CountGreaterOrEquals count = (
    local result = false
    case of (
      (this.IsArrayOrArrayParameter()): result = this.v.Count >= count
      (this.IsBitArray()): result = this.v.NumberSet >= count
      (this.IsDictionary()): result = this.v.Count >= count
      default: ()
    )
    result
  ),

  /*-
  コレクションの要素数が指定の数を超えるかどうかを判定する。
  @param count <Integer>
  @returns <BooleanClass>
  */
  public fn CountGreaterThan count = (
    local result = false
    case of (
      (this.IsArrayOrArrayParameter()): result = this.v.Count > count
      (this.IsBitArray()): result = this.v.NumberSet > count
      (this.IsDictionary()): result = this.v.Count > count
      default: ()
    )
    result
  ),

  /*-
  コレクションの要素数が指定の数以下かどうかを判定する。
  @param count <Integer>
  @returns <BooleanClass>
  */
  public fn CountLessOrEquals count = (
    local result = false
    case of (
      (this.IsArrayOrArrayParameter()): result = this.v.Count <= count
      (this.IsBitArray()): result = this.v.NumberSet <= count
      (this.IsDictionary()): result = this.v.Count <= count
      default: ()
    )
    result
  ),

  /*-
  コレクションの要素数が指定の数未満かどうかを判定する。
  @param count <Integer>
  @returns <BooleanClass>
  */
  public fn CountLessThan count = (
    local result = false
    case of (
      (this.IsArrayOrArrayParameter()): result = this.v.Count < count
      (this.IsBitArray()): result = this.v.NumberSet < count
      (this.IsDictionary()): result = this.v.Count < count
      default: ()
    )
    result
  ),

  /*-
  @returns <Any>
  */
  public fn GetValue = (
    this.v
  ),

  /*-
  `Equals`メソッドを持っているかどうかを判定する。
  @returns <BooleanClass>
  */
  public fn HasEquals = (
    this.HasProp #Equals and (
      classOf this.v.Equals == MaxScriptFunction \
          or classOf this.v.Equals == DotNetMethod
    )
  ),

  /*-
  現在のオブジェクトの値が指定したプロパティを持っているかどうかを判定する。
  @param propName <String|Name>
  @returns <BooleanClass>
  */
  public fn HasProp propName = (
    isProperty this.v propName
  ),

  /*- @returns <BooleanClass> */
  public fn IsAngleAxis = classOf this.v == AngleAxis,
  /*- @returns <BooleanClass> */
  public fn IsArray = classOf this.v == Array,
  /*- @returns <BooleanClass> */
  public fn IsArrayOrArrayParameter = this.IsArray() or this.IsArrayParameter(),
  /*- @returns <BooleanClass> */
  public fn IsArrayParameter = classOf this.v == ArrayParameter,
  /*- @returns <BooleanClass> */
  public fn IsAttributeDef = classOf this.v == AttributeDef,
  /*- @returns <BooleanClass> */
  public fn IsBigMatrix = classOf this.v == BigMatrix,
  /*- @returns <BooleanClass> */
  public fn IsBinStream = classOf this.v == BinStream,
  /*- @returns <BooleanClass> */
  public fn IsBitArray = classOf this.v == BitArray,
  /*- @returns <BooleanClass> */
  public fn IsBitmap = classOf this.v == Bitmap,
  /*- @returns <BooleanClass> */
  public fn IsBoolean = classOf this.v == BooleanClass,
  /*- @returns <BooleanClass> */
  public fn IsBox2 = classOf this.v == Box2,
  /*- @returns <BooleanClass> */
  public fn IsBox3 = classOf this.v == Box3,
  /*- @returns <BooleanClass> */
  public fn IsColor = classOf this.v == Color,
  /*- @returns <BooleanClass> */
  public fn IsDataPair = classOf this.v == DataPair,
  /*- @returns <BooleanClass> */
  public fn IsDictionary = classOf this.v == Dictionary,
  /*- @returns <BooleanClass> */
  public fn IsDotNetClass = classOf this.v == DotNetClass,
  /*- @returns <BooleanClass> */
  public fn IsDotNetMethod = classOf this.v == DotNetMethod,
  /*- @returns <BooleanClass> */
  public fn IsDotNetObject = classOf this.v == DotNetObject,
  /*- @returns <BooleanClass> */
  public fn IsEulerAngles = classOf this.v == EulerAngles,
  /*- @returns <BooleanClass> */
  public fn IsFileStream = classOf this.v == FileStream,
  /*- @returns <BooleanClass> */
  public fn IsFloat = classOf this.v == Float,
  /*- @returns <BooleanClass> */
  public fn IsInteger = classOf this.v == Integer,
  /*- @returns <BooleanClass> */
  public fn IsInterval = classOf this.v == Interval,
  /*- @returns <BooleanClass> */
  public fn IsMatrix3 = classOf this.v == Matrix3,
  /*- @returns <BooleanClass> */
  public fn IsMAXKey = classOf this.v == MAXKey,
  /*- @returns <BooleanClass> */
  public fn IsMAXScriptFunction = classOf this.v == MAXScriptFunction,
  /*- @returns <BooleanClass> */
  public fn IsName = classOf this.v == Name,
  /*- @returns <BooleanClass> */
  public fn IsNumber = superClassOf this.v == Number,
  /*- @returns <BooleanClass> */
  public fn IsOk = classOf this.v == OkClass,
  /*- @returns <BooleanClass> */
  public fn IsPoint2 = classOf this.v == Point2,
  /*- @returns <BooleanClass> */
  public fn IsPoint3 = classOf this.v == Point3,
  /*- @returns <BooleanClass> */
  public fn IsPoint4 = classOf this.v == Point4,
  /*- @returns <BooleanClass> */
  public fn IsQuat = classOf this.v == Quat,
  /*- @returns <BooleanClass> */
  public fn IsRay = classOf this.v == Ray,
  /*- @returns <BooleanClass> */
  public fn IsRegexObject = classOf this.v == DotNetObject and this.regexType.IsInstanceOfType this.v,
  /*- @returns <BooleanClass> */
  public fn IsRollout = classOf this.v == RolloutClass,
  /*- @returns <BooleanClass> */
  public fn IsString = classOf this.v == String,
  /*- @returns <BooleanClass> */
  public fn IsStringStream = classOf this.v == StringStream,
  /*- @returns <BooleanClass> */
  public fn IsStructDefinition = isStructDef this.v,
  /*- @returns <BooleanClass> */
  public fn IsStructInstance = isStruct this.v,
  /*- @returns <BooleanClass> */
  public fn IsTestValue obj = classOf obj == classOf this,
  /*- @returns <BooleanClass> */
  public fn IsTime = classOf this.v == Time,
  /*- @returns <BooleanClass> */
  public fn IsUndefined = classOf this.v == UndefinedClass,
  /*- @returns <BooleanClass> */
  public fn IsUnsupplied = classOf this.v == UnsuppliedClass,
  /*- @returns <BooleanClass> */
  public fn IsWindowStream = classOf this.v == WindowStream,

  /*-
  エスケープシーケンスの`\`をエスケープする。
  @param input <String|StringStream>
  @returns <String>
  */
  private fn escapeBackslash input = (
    local result = input as String
    result = substituteString result "\\" "\\\\"
    result = substituteString result "\"" "\\\""
    result = substituteString result "\n" "\\n"
    result = substituteString result "\r" "\\r"
    result = substituteString result "\t" "\\t"
    result
  ),

  /*-
  値を文字列に変換してエスケープシーケンスをエスケープする。
  @param input <Any>
  @returns <String>
  */
  private fn valueToString input = (
    local result = ""
    case classOf input of (
      (Array): (
        result = "#("
        for i = 1 to input.Count do (
          if i > 1 do (
            result += ", "
          )
          local elementValue = this.valueToString input[i]
          if classOf input[i] == String do (
            elementValue = "\"" + elementValue + "\""
          )
          result += elementValue
        )
        result += ")"
      )
      (DataPair): (
        local propNames = getPropNames input
        local isExplicitPropNames = propNames.Count == 4
        local v1Value = this.valueToString input.V1
        local v2Value = this.valueToString input.V2
        if classOf input.V1 == String do (
          v1Value = "\"" + v1Value + "\""
        )
        if classOf input.V2 == String do (
          v2Value = "\"" + v2Value + "\""
        )
        if isExplicitPropNames do (
          local v1Name = propNames[3] as String
          local v2Name = propNames[4] as String
          v1Name = (DotNetObject "System.String" v1Name).TrimStart "#"
          v2Name = (DotNetObject "System.String" v2Name).TrimStart "#"
          v1Value = v1Name + ":" + v1Value
          v2Value = v2Name + ":" + v2Value
        )
        result = "DataPair " + v1Value + " " + v2Value
      )
      (Dictionary): (
        result += "Dictionary " + (this.valueToString input.Type)
        for key in input.Keys do (
          local keyText = this.valueToString key
          local valueText = this.valueToString (input[key])
          if classOf key == String do (
            keyText = "\"" + keyText + "\""
          )
          if classOf input[key] == String do (
            valueText = "\"" + valueText + "\""
          )
          result += " #(" + keyText + ", " + valueText + ")"
        )
      )
      (Float): (
        result += formattedPrint input format:"f"
      )
      (StringStream): (
        result += "StringStream "
        result += "\"" + (this.valueToString (input as String)) + "\""
      )
      default : (
        result = input as String
        case classOf input of (
          (Name): result = "#" + result
          (String): result = this.escapeBackslash result
          default: ()
        )
      )
    )
    result
  ),

  /*- @returns <Name> */
  public fn StructName = #TestValueStruct,

  /*-
  @param indent: <String>
  @param out: <FileStream|StringStream|WindowStream> 出力先。既定値は`listener`。
  @returns <OkClass>
  */
  public fn Dump indent:"" out:listener = (
    format "%TestValueStruct\n" indent to:out
    format "%  IgnoreCase:%\n" indent this.IgnoreCase to:out
    if this.HasProp #Dump \
        and classOf this.v.Dump == MAXScriptFunction then (
      format "%  v:\n" indent to:out
      this.v.Dump indent:(indent + "    ") out:out
    )
    else (
      if classOf this.v == String then (
        format "%  v:\"%\"\n" indent (this.valueToString this.v) to:out
      )
      else (
        format "%  v:%\n" indent (this.valueToString this.v) to:out
      )
    )
    ok
  ),

  /*-
  指定したオブジェクトが現在のオブジェクトと等しいかどうかを判定する。
  @param obj <Struct:TestValueStruct>
  @returns <BooleanClass>
  @remarks 比較は型によって異なる方法で行われる。

  * 配列や`DataPair`等の複合型は再帰的に比較する。

  * 数値で構成される複合型は各要素の数値を`==`演算子ではなく`close_enough`関数を用いて比較する。

  * `Equals`メソッドを持っているオブジェクトは`Equals`メソッドを使用して比較する。

  * 正規表現オブジェクトは`ToString`メソッドによるパターン文字列と`Options`プロパティをそれぞれ比較する。

  * プロパティアクセスによる`MAXScriptFunction`値の比較は失敗する。
    そのため関数値を比較する場合は一旦変数に格納し、その変数を用いてインスタンスを生成する。

    アサーション失敗
    :   ```maxscript
        actual = ::TestValueStruct foo.Bar
        expected = ::TestValueStruct foo.Bar
        assert (actual.Equals expected == true)
        ```

    アサーション成功
    :   ```maxscript
        local f = foo.Bar
        actual = ::TestValueStruct f
        expected = ::TestValueStruct f
        assert (actual.Equals expected == true)
        ```

  * `DotNetMethod`の比較は常に`false`になる。
  */
  public fn Equals obj = (
    local isEqualStructName = isStruct obj \
        and isProperty obj #StructName \
        and classOf obj.StructName == MAXScriptFunction \
        and obj.StructName() == this.StructName()

    local isEqualProperties = isProperty obj #GetValue \
        and classOf obj.GetValue == MAXScriptFunction

    if isEqualProperties do (
      local ov = obj.GetValue()
      local tv = this.GetValue()
      local testValueDef = classOf this
      isEqualProperties = case of (
        (this.IsAngleAxis() and obj.IsAngleAxis()): (
          local t1 = testValueDef tv.Angle
          local t2 = testValueDef tv.Axis
          local t3 = testValueDef tv.NumRevs
          local o1 = testValueDef ov.Angle
          local o2 = testValueDef ov.Axis
          local o3 = testValueDef ov.NumRevs
          t1.Equals o1 and t2.Equals o2 and t3.Equals o3
        )
        (this.IsArrayOrArrayParameter() and obj.IsArrayOrArrayParameter()): (
          local result = ov.Count == tv.Count
          for i = 1 to tv.Count while result do (
            local t1 = testValueDef tv[i]
            local o1 = testValueDef ov[i]
            result = t1.Equals o1
          )
          result
        )
        (this.IsBigMatrix() and obj.IsBigMatrix()): (
          local result = ov.Rows == tv.Rows and ov.Columns == tv.Columns
          for i = 1 to tv.Rows while result do (
            for j = 1 to tv.Columns while result do (
              local t1 = testValueDef tv[i][j]
              local o1 = testValueDef ov[i][j]
              result = t1.Equals o1
            )
          )
          result
        )
        (this.IsBitArray() and obj.IsBitArray()): (
          tv.NumberSet == ov.NumberSet and (tv * ov).NumberSet == tv.NumberSet
        )
        (this.IsBox2() and obj.IsBox2()): (
          local t1 = testValueDef tv.X
          local t2 = testValueDef tv.Y
          local t3 = testValueDef tv.W
          local t4 = testValueDef tv.H
          local o1 = testValueDef ov.X
          local o2 = testValueDef ov.Y
          local o3 = testValueDef ov.W
          local o4 = testValueDef ov.H
          t1.Equals o1 and t2.Equals o2 and t3.Equals o3 and t4.Equals o4
        )
        (this.IsBox3() and obj.IsBox3()): (
          local t1 = testValueDef tv.Min
          local t2 = testValueDef tv.Max
          local o1 = testValueDef ov.Min
          local o2 = testValueDef ov.Max
          t1.Equals o1 and t2.Equals o2
        )
        (this.IsDataPair() and obj.IsDataPair()): (
          local t1 = testValueDef tv.V1
          local t2 = testValueDef tv.V2
          local t3 = testValueDef (getPropNames tv)
          local o1 = testValueDef ov.V1
          local o2 = testValueDef ov.V2
          local o3 = testValueDef (getPropNames ov)
          t1.Equals o1 and t2.Equals o2 and t3.Equals o3
        )
        (this.IsDictionary() and obj.IsDictionary()): (
          local result = ov.Type == tv.Type and ov.Count == tv.Count
          for key in tv.Keys while result do (
            local t1 = testValueDef (hasDictValue tv key)
            local t2 = testValueDef tv[key]
            local o1 = testValueDef (hasDictValue ov key)
            local o2 = testValueDef ov[key]
            result = t1.Equals o1 and t2.Equals o2
          )
          result
        )
        (this.IsEulerAngles() and obj.IsEulerAngles()): (
          local t1 = testValueDef tv.X
          local t2 = testValueDef tv.Y
          local t3 = testValueDef tv.Z
          local o1 = testValueDef ov.X
          local o2 = testValueDef ov.Y
          local o3 = testValueDef ov.Z
          t1.Equals o1 and t2.Equals o2 and t3.Equals o3
        )
        (this.IsInterval() and obj.IsInterval()): (
          local t1 = testValueDef tv.Start
          local t2 = testValueDef tv.End
          local o1 = testValueDef ov.Start
          local o2 = testValueDef ov.End
          t1.Equals o1 and t2.Equals o2
        )
        (this.IsMatrix3() and obj.IsMatrix3()): (
          local t1 = testValueDef tv[1]
          local t2 = testValueDef tv[2]
          local t3 = testValueDef tv[3]
          local t4 = testValueDef tv[4]
          local o1 = testValueDef ov[1]
          local o2 = testValueDef ov[2]
          local o3 = testValueDef ov[3]
          local o4 = testValueDef ov[4]
          t1.Equals o1 and t2.Equals o2 and t3.Equals o3 and t4.Equals o4
        )
        (this.IsNumber() and obj.IsNumber()): (
          -- 0.0との比較はfalseを返すため1を足して比較する
          local f1 = ov as Float + 1.0
          local f2 = tv as Float + 1.0
          close_enough f1 f2 10
        )
        (this.IsPoint2() and obj.IsPoint2()): (
          local t1 = testValueDef tv.X
          local t2 = testValueDef tv.Y
          local o1 = testValueDef ov.X
          local o2 = testValueDef ov.Y
          t1.Equals o1 and t2.Equals o2
        )
        (this.IsPoint3() and obj.IsPoint3()): (
          local t1 = testValueDef tv.X
          local t2 = testValueDef tv.Y
          local t3 = testValueDef tv.Z
          local o1 = testValueDef ov.X
          local o2 = testValueDef ov.Y
          local o3 = testValueDef ov.Z
          t1.Equals o1 and t2.Equals o2 and t3.Equals o3
        )
        (this.IsPoint4() and obj.IsPoint4()): (
          local t1 = testValueDef tv.X
          local t2 = testValueDef tv.Y
          local t3 = testValueDef tv.Z
          local t4 = testValueDef tv.W
          local o1 = testValueDef ov.X
          local o2 = testValueDef ov.Y
          local o3 = testValueDef ov.Z
          local o4 = testValueDef ov.W
          t1.Equals o1 and t2.Equals o2 and t3.Equals o3 and t4.Equals o4
        )
        (this.IsQuat() and obj.IsQuat()): (
          local t1 = testValueDef tv.Angle
          local t2 = testValueDef tv.Axis
          local o1 = testValueDef ov.Angle
          local o2 = testValueDef ov.Axis
          t1.Equals o1 and t2.Equals o2
        )
        (this.IsRay() and obj.IsRay()): (
          local t1 = testValueDef tv.Pos
          local t2 = testValueDef tv.Dir
          local o1 = testValueDef ov.Pos
          local o2 = testValueDef ov.Dir
          t1.Equals o1 and t2.Equals o2
        )
        (this.IsRegexObject() and obj.IsRegexObject()): (
          local t1 = testValueDef (tv.ToString())
          local t2 = testValueDef tv.Options
          local o1 = testValueDef (ov.ToString())
          local o2 = testValueDef ov.Options
          t1.Equals o1 and t2.Equals o2
        )
        (this.IsString() and obj.IsString()): (
          if this.IgnoreCase then (
            stricmp ov tv == 0
          )
          else (
            ov == tv
          )
        )
        default: (
          if this.HasEquals() and not this.IsDotNetClass() then (
            tv.Equals ov
          )
          else (
            ov == tv
          )
        )
      )
    )

    isEqualStructName and isEqualProperties
  ),

  on Create do (
    this.regexType = (DotNetObject this.regexClass "").GetType()
    this.v = this._CP1_
  )
)
format "[define]::TestValueStruct\n"
::TestValueStruct
