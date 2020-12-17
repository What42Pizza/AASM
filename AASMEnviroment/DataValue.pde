public class DV implements Cloneable {
  
  
  
  
  
  // Vars
  
  int IntValue = 0;
  float FloatValue = 0.0;
  boolean BoolValue = false;
  String StringValue = null;
  ArrayList <DV> TableValue = null;
  int LabelFunctionValue = -1;
  ArrayList <Integer> IntArray = null;
  ArrayList <Float> FloatArray = null;
  ArrayList <String> StringArray = null;
  
  int ValueType;
  
  DV THIS; // Used for the THIS constant in functions
  String CustomType = null;
  
  
  
  
  
  
  
  
  
  
  // Constructors
  
  public DV() {
    ValueType = ValueTypes.T_Null;
  }
  
  public DV (int IntValue) {
    ValueType = ValueTypes.T_Int;
    this.IntValue = IntValue;
  }
  
  public DV (float FloatValue) {
    ValueType = ValueTypes.T_Float;
    this.FloatValue = FloatValue;
  }
  
  public DV (boolean BoolValue) {
    ValueType = ValueTypes.T_Bool;
    this.BoolValue = BoolValue;
  }
  
  public DV (String StringValue) {
    ValueType = ValueTypes.T_String;
    this.StringValue = StringValue;
  }
  
  public DV (ArrayList <DV> TableValue) {
    ValueType = ValueTypes.T_Table;
    this.TableValue = TableValue;
  }
  
  public DV (int LabelFunctionValue, boolean ThisIsALabelFunctionValueButICantHaveAnotherIntConstructorSo) {
    ValueType = ValueTypes.T_LabelFunction;
    this.LabelFunctionValue = LabelFunctionValue;
  }
  
  public DV (ArrayList <Integer> IntArray, int ThisIsIntArrayButTheresAlreadyAnArrayList) {
    ValueType = ValueTypes.T_IntArray;
    this.IntArray = IntArray;
  }
  
  public DV (ArrayList <Float> FloatArray, float WhyAreYouStillReadingThese) {
    ValueType = ValueTypes.T_FloatArray;
    this.FloatArray = FloatArray;
  }
  
  public DV (ArrayList <String> StringArray, String IfThesesABetterWayToDoThisThenPleaseTellMe) {
    ValueType = ValueTypes.T_StringArray;
    this.StringArray = StringArray;
  }
  
  
  
  
  
  
  
  
  
  
  // Overridable functions
  
  
  
  public void SetTo (DV NewDV) {
    ForgetValue(); // save on some memory
    ValueType = NewDV.ValueType;
    switch (ValueType) {
      
      case (ValueTypes.T_Int):
        IntValue = NewDV.IntValue;
        return;
      
      case (ValueTypes.T_Float):
        FloatValue = NewDV.FloatValue;
        return;
      
      case (ValueTypes.T_Bool):
        BoolValue = NewDV.BoolValue;
        return;
      
      case (ValueTypes.T_String):
        StringValue = NewDV.StringValue;
        return;
      
      case (ValueTypes.T_Table):
        TableValue = NewDV.TableValue;
        return;
      
      case (ValueTypes.T_LabelFunction):
        LabelFunctionValue = NewDV.LabelFunctionValue;
        return;
      
      case (ValueTypes.T_IntArray):
        IntArray = NewDV.IntArray;
        return;
      
      case (ValueTypes.T_FloatArray):
        FloatArray = NewDV.FloatArray;
        return;
      
      case (ValueTypes.T_StringArray):
        StringArray = NewDV.StringArray;
        return;
      
    }
  }
  
  
  
  
  
  ArrayList <DV> CallAsFunction (ArrayList <DV> Args) {
    // pretend this is interacting with the interpreter
    return null;
  }
  
  
  
  
  
  DV GetIndex (DV Key) {
    
    if (Key.ValueType == ValueTypes.T_String) {
      if (Key.StringValue.equals("castTo")) return null; // this needs to be a function
      if (Key.StringValue.equals("clone")) try {return (DV) this.clone();} catch (Exception e) {println ("Internal Error: could not clone this DV: " + e); return new DV();}
    }
    
    switch (ValueType) {
      
      
      
      case (ValueTypes.T_Int):
        if (Key.ValueType != ValueTypes.T_String) {
          println ("Error: cannot index int with non-string value");
          return new DV();
        };
        switch (Key.StringValue) {
          case ("sign"):
            return new DV (IntValue >= 0 ? "+" : "-");
          case ("signInt"):
            return new DV (IntValue >= 0 ? 1 : -1);
          case ("signBool"):
            return new DV (IntValue >= 0 ? true : false);
          default:
            println ("Error: cannot index int with " + Key.StringValue);
            return new DV();
        }
      
      
      
      case (ValueTypes.T_Float):
        if (Key.ValueType != ValueTypes.T_String) {
          println ("Error: cannot index float with non-string value");
          return new DV();
        };
        switch (Key.StringValue) {
          case ("sign"):
            return new DV (FloatValue >= 0 ? "+" : "-");
          case ("signInt"):
            return new DV (FloatValue >= 0 ? 1 : -1);
          case ("signBool"):
            return new DV (FloatValue >= 0 ? true : false);
          default:
            println ("Error: cannot index float with " + Key.StringValue);
            return new DV();
        }
      
      
      
      case (ValueTypes.T_Bool):
        println ("Error: bool cannot be indexed");
        return new DV();
      
      
      
      case (ValueTypes.T_String):
        switch (Key.ValueType) {
          
          case (ValueTypes.T_String):
            switch (Key.StringValue) { // three level switch, yay or nay?
              case ("length"):
                return new DV (StringValue.length());
              case ("sub"):
                return null; // this needs to return a function
              case ("find"):
                return null; // this needs to return a function
              case ("charAt"):
                return null; // this needs to return a fucntion
              default:
                println ("Error: cannot index string with " + Key.StringValue);
                return new DV();
            }
          
          case (ValueTypes.T_Int):
            return new DV (StringValue.charAt(Key.IntValue));
          
          default:
            println ("Error: cannot index string with non-string, non-int value");
            return new DV();
          
        }
      
      
      
      case (ValueTypes.T_Table):
        switch (Key.ValueType) {
          
          case (ValueTypes.T_String):
            switch (Key.StringValue) {
              case ("length"):
                return new DV (TableValue.size());
              case ("sub"):
                return null; // this needs to be a function
              case ("find"):
                return null; // this needs to be a function
              case ("keys"):
                return GetKeysAsTable();
              case ("insert"):
                return null; // this needs to be a function
              case ("remove"):
                return null; // this needs to be a function
              case ("onOperation"):
                return null; // ???????????????
              case ("removeNativeKeys"):
                return null; // this needs to be a function
              case ("freezeKeys"):
                return null; // this needs to be a function
              default:
                return GetTableValue (Key);
            }
          
          case (ValueTypes.T_Int):
            return GetTableValue (Key);
          
          default:
            println ("Error: cannot index table with non-string, non-int value");
            return new DV();
          
        }
      
      
      
      case (ValueTypes.T_IntArray):
        switch (Key.ValueType) {
          
          case (ValueTypes.T_String):
            switch (Key.StringValue) {
              case ("length"):
                return new DV (IntArray.size());
              case ("sub"):
                return null; // this needs to be a function
              case ("find"):
                return null; // this needs to be a function
              case ("insert"):
                return null; // this needs to be a function
              case ("remove"):
                return null; // this needs to be a function
              default:
                println ("Error: cannot index intarray with " + Key.StringValue);
            }
          
          case (ValueTypes.T_Int):
            if (Key.IntValue < 1) {println ("Error: cannot index this intarray with " + Key.IntValue + "; index is too low");}
            if (Key.IntValue > IntArray.size()) {println ("Error: cannot index this intarray with " + Key.IntValue + "; length is " + IntArray.size());} // This isn't >= size() because it starts at 1 (index == size works)
            return new DV (IntArray.get(Key.IntValue));
          
          default:
            println ("Error: cannot index intarray with non-string, non-int value");
            return new DV();
          
        }
      
      
      
      case (ValueTypes.T_FloatArray):
        switch (Key.ValueType) {
          
          case (ValueTypes.T_String):
            switch (Key.StringValue) {
              case ("length"):
                return new DV (FloatArray.size());
              case ("sub"):
                return null; // this needs to be a function
              case ("find"):
                return null; // this needs to be a function
              case ("insert"):
                return null; // this needs to be a function
              case ("remove"):
                return null; // this needs to be a function
              default:
                println ("Error: cannot index floatarray with " + Key.StringValue);
            }
          
          case (ValueTypes.T_Int):
            if (Key.IntValue < 1) {println ("Error: cannot index this floatarray with " + Key.IntValue + "; index is too low");}
            if (Key.IntValue > FloatArray.size()) {println ("Error: cannot index this floatarray with " + Key.IntValue + "; length is " + FloatArray.size());}
            return new DV (FloatArray.get(Key.IntValue));
          
          default:
            println ("Error: cannot index floatarray with non-string, non-int value");
            return new DV();
          
        }
      
      
      
      case (ValueTypes.T_StringArray):
        switch (Key.ValueType) {
          
          case (ValueTypes.T_String):
            switch (Key.StringValue) {
              case ("length"):
                return new DV (StringArray.size());
              case ("sub"):
                return null; // this needs to be a function
              case ("find"):
                return null; // this needs to be a function
              case ("insert"):
                return null; // this needs to be a function
              case ("remove"):
                return null; // this needs to be a function
              default:
                println ("Error: cannot index stringarray with " + Key.StringValue);
            }
          
          case (ValueTypes.T_Int):
            if (Key.IntValue < 1) {println ("Error: cannot index this stringarray with " + Key.IntValue + "; index is too low");}
            if (Key.IntValue > StringArray.size()) {println ("Error: cannot index this stringarray with " + Key.IntValue + "; length is " + StringArray.size());}
            return new DV (StringArray.get(Key.IntValue));
          
          default:
            println ("Error: cannot index stringarray with non-string, non-int value");
            return new DV();
          
        }
      
      
      
      default:
        println ("Internal Error: Cannot determin value type " + ValueType);
        return new DV();
      
      
      
    }
  }
  
  
  
  
  
  
  
  
  
  
  // Functions
  
  
  
  DV CastTo (String NewType) {
    //if (.castTo has changed) tell interpreter to do castTo stuff
    switch (NewType) {
      
      case (ValueTypes.N_Null):
        return new DV();
      
      case (ValueTypes.N_Int):
        return CastToInt();
      
      case (ValueTypes.N_Float):
        return CastToFloat();
      
      case (ValueTypes.N_Bool):
        return CastToBool();
      
      case (ValueTypes.N_String):
        return CastToString();
      
      case (ValueTypes.N_Table):
        return CastToTable();
      
      case (ValueTypes.N_LabelFunction):
        return CastToFunction();
      
      case (ValueTypes.N_IntArray):
        return CastToIntArray();
      
      default:
        if (CustomType == null) {
          println ("Error: cannot cast " + ValueTypes.TypeNames[ValueType] + " to " + NewType);
          return new DV();
        } else {
          println ("Error: cannot cast " + CustomType + " to " + NewType);
          return new DV();
        }
      
    }
  }
  
  
  
  
  
  DV CastToInt() {
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return new DV (0);
      
      case (ValueTypes.T_Int):
        return new DV (IntValue);
      
      case (ValueTypes.T_Float):
        return new DV ((int) FloatValue);
      
      case (ValueTypes.T_Bool):
        return new DV (BoolValue ? 1 : 0);
      
      case (ValueTypes.T_String):
        try {
          return new DV (Integer.parseInt(StringValue));
        } catch (NumberFormatException e) { // If StringValue cannot be cast, return 0
          return new DV (0);
        }
      
      case (ValueTypes.T_Table):
        return new DV (TableValue.size() / 2);
      
      case (ValueTypes.T_LabelFunction):
        println ("Error: cannot cast function to int");
        return new DV (0);
      
      case (ValueTypes.T_IntArray):
        return new DV (IntArray.size() / 2);
      
      case (ValueTypes.T_FloatArray):
        return new DV (FloatArray.size() / 2);
      
      case (ValueTypes.T_StringArray):
        return new DV (StringArray.size() / 2);
      
      default:
        println ("Internal Error in CastToInt(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  DV CastToFloat() {
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return new DV (0.0);
      
      case (ValueTypes.T_Int):
        return new DV ((float) IntValue);
      
      case (ValueTypes.T_Float):
        return new DV (FloatValue);
      
      case (ValueTypes.T_Bool):
        return new DV (BoolValue ? 1.0 : 0.0);
      
      case (ValueTypes.T_String):
        try {
          return new DV (Float.parseFloat(StringValue));
        } catch (NumberFormatException e) { // If StringValue cannot be cast, return 0.0
          return new DV (0.0);
        }
      
      case (ValueTypes.T_Table):
        return new DV (TableValue.size() / 2.0);
      
      case (ValueTypes.T_LabelFunction):
        println ("Error: cannot cast function to float");
        return new DV (0.0);
      
      case (ValueTypes.T_IntArray):
        return new DV (IntArray.size() / 2.0);
      
      case (ValueTypes.T_FloatArray):
        return new DV (FloatArray.size() / 2.0);
      
      case (ValueTypes.T_StringArray):
        return new DV (StringArray.size() / 2.0);
      
      default:
        println ("Internal Error in CastToFloat(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  DV CastToBool() {
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return new DV (false);
      
      case (ValueTypes.T_Int):
        return new DV (true);
      
      case (ValueTypes.T_Float):
        return new DV (true);
      
      case (ValueTypes.T_Bool):
        return new DV (BoolValue);
      
      case (ValueTypes.T_String):
        return new DV (true);
        /*
        try {
          return new DV (Boolean.parseBoolean(StringValue));
        } catch (NumberFormatException e) { // If StringValue cannot be cast, return false
          return new DV (false);
        }
        */
      
      case (ValueTypes.T_Table):
        return new DV (true);
      
      case (ValueTypes.T_LabelFunction):
        return new DV (true);
      
      case (ValueTypes.T_IntArray):
        return new DV (true);
      
      case (ValueTypes.T_FloatArray):
        return new DV (true);
      
      case (ValueTypes.T_StringArray):
        return new DV (true);
      
      default:
        println ("Internal Error in CastToBool(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  DV CastToString() {
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return new DV ("");
      
      case (ValueTypes.T_Int):
        return new DV (Integer.toString(IntValue));
      
      case (ValueTypes.T_Float):
        return new DV (Float.toString(FloatValue));
      
      case (ValueTypes.T_Bool):
        return new DV (Boolean.toString(BoolValue));
      
      case (ValueTypes.T_String):
        return new DV (StringValue);
      
      case (ValueTypes.T_Table):
        return new DV (ConvertTableToString());
      
      case (ValueTypes.T_LabelFunction):
        return new DV ("function");
      
      case (ValueTypes.T_IntArray):
        return new DV (ConvertIntArrayToString());
      
      case (ValueTypes.T_FloatArray):
        return new DV (ConvertFloatArrayToString());
      
      case (ValueTypes.T_StringArray):
        return new DV (ConvertStringArrayToString());
      
      default:
        println ("Internal Error in CastToString(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  DV CastToTable() {
    ArrayList <DV> Output = new ArrayList <DV> ();
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return new DV (Output);
      
      case (ValueTypes.T_Int):
        for (int i = 0; i < IntValue; i ++) {Output.add (new DV(i+1)); Output.add(new DV());}
        return new DV (Output);
      
      case (ValueTypes.T_Float):
        for (int i = 0; i < floor(FloatValue); i ++) {Output.add (new DV(i+1)); Output.add(new DV());}
        return new DV (Output);
      
      case (ValueTypes.T_Bool):
        Output.add(new DV(1));
        Output.add(new DV(BoolValue));
        return new DV (Output);
      
      case (ValueTypes.T_String):
        Output.add(new DV (StringValue));
        return new DV (Output);
      
      case (ValueTypes.T_Table):
        return new DV (TableValue);
      
      case (ValueTypes.T_LabelFunction):
        Output.add(new DV("function")); // key
        Output.add(new DV(LabelFunctionValue, true));
        return new DV (Output);
      
      case (ValueTypes.T_IntArray):
        return ConvertIntArrayToTable();
      
      case (ValueTypes.T_FloatArray):
        return ConvertFloatArrayToTable();
      
      case (ValueTypes.T_StringArray):
        return ConvertStringArrayToTable();
      
      default:
        println ("Internal Error in CastToString(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  DV CastToFunction() {
    if (ValueType == ValueTypes.T_LabelFunction) return new DV (LabelFunctionValue, true);
    println ("Error: cannot cast " + ValueType + " to function");
    return new DV();
  }
  
  
  
  
  
  DV CastToIntArray() {
    ArrayList <Integer> Output = new ArrayList <Integer> ();
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return new DV (Output, 0);
      
      case (ValueTypes.T_Int):
        for (int i = 0; i < IntValue; i ++) {Output.add(0);}
        return new DV (Output, 0);
      
      case (ValueTypes.T_Float):
        for (int i = 0; i < floor(FloatValue); i ++) {Output.add(0);}
        return new DV (Output, 0);
      
      case (ValueTypes.T_Bool):
        Output.add(BoolValue ? 1 : 0);
        return new DV (Output, 0);
      
      case (ValueTypes.T_String):
        try {
          Output.add(Integer.parseInt(StringValue));
          return new DV (Output, 0);
        } catch (NumberFormatException e) {
          return new DV (Output, 0);
        }
      
      case (ValueTypes.T_Table):
        return new DV (TableValue);
      
      case (ValueTypes.T_LabelFunction):
        println ("Error: cannot cast function to intarray");
        return new DV (Output, 0);
      
      case (ValueTypes.T_IntArray):
        return new DV (IntArray, 0);
      
      case (ValueTypes.T_FloatArray):
        return ConvertFloatArrayToIntArray();
      
      case (ValueTypes.T_StringArray):
        return ConvertStringArrayToIntArray();
      
      default:
        println ("Internal Error in CastToString(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  
  
  
  
  
  boolean Equals (DV OtherDV) {
    if (ValueType != OtherDV.ValueType) return false;
    if (ValueType == ValueTypes.T_Null) return true;
    switch (ValueType) {
      
      case (ValueTypes.T_Int):
        return IntValue == OtherDV.IntValue;
      
      case (ValueTypes.T_Float):
        return FloatValue == OtherDV.FloatValue;
      
      case (ValueTypes.T_Bool):
        return BoolValue == OtherDV.BoolValue;
      
      case (ValueTypes.T_String):
        return StringValue.equals(OtherDV.StringValue);
      
      case (ValueTypes.T_Table):
        if (TableValue.size() != OtherDV.TableValue.size()) return false;
        for (int i = 0; i < TableValue.size(); i ++) {
          if (!TableValue.get(i).Equals(OtherDV.TableValue.get(i))) return false; // this can result in a recurive loop if a DV is put in its own table, so... don't do that
        }
        return true;
      
      case (ValueTypes.T_LabelFunction):
        return LabelFunctionValue == OtherDV.LabelFunctionValue;
      
      case (ValueTypes.T_IntArray):
        if (IntArray.size() != OtherDV.IntArray.size()) return false;
        for (int i = 0; i < IntArray.size(); i ++) {
          if (IntArray.get(i) != OtherDV.IntArray.get(i)) return false;
        }
        return true;
      
      case (ValueTypes.T_FloatArray):
        if (FloatArray.size() != OtherDV.FloatArray.size()) return false;
        for (int i = 0; i < FloatArray.size(); i ++) {
          if (FloatArray.get(i) != OtherDV.FloatArray.get(i)) return false;
        }
        return true;
      
      case (ValueTypes.T_StringArray):
        if (StringArray.size() != OtherDV.StringArray.size()) return false;
        for (int i = 0; i < StringArray.size(); i ++) {
          if (!StringArray.get(i).equals(OtherDV.StringArray.get(i))) return false;
        }
        return true;
      
      default:
        println ("Internal error in Equals(): Cannot determin type " + ValueType);
        return false;
      
    }
  }
  
  
  
  
  
  void ForgetValue() { // DOES NOT RESET VALUETYPE!!!!!!!!!!!!!!!!!!!
    switch (ValueType) {
      
      case (ValueTypes.T_String):
        StringValue = null;
        return;
      
      case (ValueTypes.T_Table):
        TableValue = null;
        return;
      
      case (ValueTypes.T_IntArray):
        IntArray = null;
        return;
      
      case (ValueTypes.T_FloatArray):
        FloatArray = null;
        return;
      
      case (ValueTypes.T_StringArray):
        StringArray = null;
        return;
      
    }
  }
  
  
  
  
  
  ArrayList <DV> GetKeys() {
    ArrayList <DV> Output = new ArrayList <DV> ();
    for (int i = 0; i < TableValue.size(); i += 2) {
      Output.add(TableValue.get(i));
    }
    return Output;
  }
  
  
  
  DV GetKeysAsTable() {
    ArrayList <DV> Keys = GetKeys();
    for (int i = 0; i < TableValue.size(); i += 2) {
      Keys.add(i, new DV (i/2));
    }
    return new DV (Keys);
  }
  
  
  
  DV GetTableValue (DV Key) {
    for (int i = 0; i < TableValue.size(); i += 2) {
      if (TableValue.get(i).Equals(Key)) return TableValue.get(i+1);
    }
    return new DV();
  }
  
  
  
  
  
  String ConvertTableToString() {
    if (ValueType != ValueTypes.T_Table) {println ("Internal Error in ConvertTableToString(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return "table to string errored";}
    if (TableValue.size() % 2 != 0) {println ("Internal Error in ConvertTableToString(): size of TableValue is odd"); return "table to string Errored";}
    String Output = "{";
    if (TableValue.size() > 0) Output += TableValue.get(0) + ": " + TableValue.get(1);
    for (int i = 0; i < TableValue.size(); i += 2) {
      Output += ", " + TableValue.get(i) + ": " + TableValue.get(i+1);
    }
    return Output + "}";
  }
  
  
  
  String ConvertIntArrayToString() {
    if (ValueType != ValueTypes.T_IntArray) {println ("Internal Error in ConvertIntArrayToString(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return "intarray to string errored";}
    String Output = "{intarray: ";
    if (IntArray.size() > 0) Output += IntArray.get(0);
    for (int i = 0; i < IntArray.size(); i += 1) {
      Output += ", " + IntArray.get(i);
    }
    return Output + "}";
  }
  
  
  
  String ConvertFloatArrayToString() {
    if (ValueType != ValueTypes.T_FloatArray) {println ("Internal Error in ConvertFloatArrayToString(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return "floatarray to string errored";}
    String Output = "{foatarray: ";
    if (FloatArray.size() > 0) Output += FloatArray.get(0);
    for (int i = 0; i < FloatArray.size(); i += 1) {
      Output += ", " + FloatArray.get(i);
    }
    return Output + "}";
  }
  
  
  
  String ConvertStringArrayToString() {
    if (ValueType != ValueTypes.T_StringArray) {println ("Internal Error in ConvertStringArrayToString(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return "stringarray to string errored";}
    String Output = "{stringarray: ";
    if (StringArray.size() > 0) Output += StringArray.get(0);
    for (int i = 0; i < StringArray.size(); i += 1) {
      Output += ", " + StringArray.get(i);
    }
    return Output + "}";
  }
  
  
  
  DV ConvertIntArrayToTable() {
    if (ValueType != ValueTypes.T_IntArray) {println ("Internal Error in ConvertIntArrayToTable(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <DV> ());}
    ArrayList <DV> Output = new ArrayList <DV> ();
    for (int i = 0; i < IntArray.size(); i ++) {
      Output.add(new DV (i+1));
      Output.add(new DV (IntArray.get(i)));
    }
    return new DV (Output);
  }
  
  
  
  DV ConvertFloatArrayToTable() {
    if (ValueType != ValueTypes.T_FloatArray) {println ("Internal Error in ConvertFloatArrayToTable(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <DV> ());}
    ArrayList <DV> Output = new ArrayList <DV> ();
    for (int i = 0; i < FloatArray.size(); i ++) {
      Output.add(new DV (i+1));
      Output.add(new DV (FloatArray.get(i)));
    }
    return new DV (Output);
  }
  
  
  
  DV ConvertStringArrayToTable() {
    if (ValueType != ValueTypes.T_StringArray) {println ("Internal Error in ConvertStringArrayToTable(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <DV> ());}
    ArrayList <DV> Output = new ArrayList <DV> ();
    for (int i = 0; i < StringArray.size(); i ++) {
      Output.add(new DV (i+1));
      Output.add(new DV (StringArray.get(i)));
    }
    return new DV (Output);
  }
  
  
  
  DV ConvertFloatArrayToIntArray() {
    if (ValueType != ValueTypes.T_FloatArray) {println ("Internal Error in ConvertFloatArrayToIntArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <Integer> (), 0);}
    ArrayList <Integer> Output = new ArrayList <Integer> ();
    for (float F : FloatArray) {
      Output.add((int)F);
    }
    return new DV (Output,  0);
  }
  
  
  
  DV ConvertStringArrayToIntArray() {
    if (ValueType != ValueTypes.T_StringArray) {println ("Internal Error in ConvertStringArrayToIntArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <Integer> (), 0);}
    ArrayList <Integer> Output = new ArrayList <Integer> ();
    for (String S : StringArray) {
      try {
        Output.add(Integer.parseInt(S));
      } catch (NumberFormatException e) {}
    }
    return new DV (Output,  0);
  }
  
  
  
  
  
  
  
  
  
  
  @Override
  public Object clone() throws CloneNotSupportedException {
    DV Output = (DV) super.clone(); // Shallow copy
    switch (ValueType) { // Deep copy DV's value if needed
      case (ValueTypes.T_Table):
        Output.TableValue = (ArrayList<DV>) TableValue.clone();
      case (ValueTypes.T_IntArray):
        Output.IntArray = (ArrayList<Integer>) IntArray.clone();
      case (ValueTypes.T_FloatArray):
        Output.FloatArray = (ArrayList<Float>) FloatArray.clone();
      case (ValueTypes.T_StringArray):
        Output.StringArray = (ArrayList<String>) StringArray.clone();
    }
    return Output;
  }
  
  
  
  
  
  @Override
  String toString() {
    return CastToString().StringValue;
  }
  
  
  
  
  
  
  
  
  
  
}
