public class DV implements Cloneable {
  
  
  
  
  
  // Vars
  
  int IntValue = 0;
  float FloatValue = 0.0;
  boolean BoolValue = false;
  String StringValue = null;
  ArrayList <DV> TableValue = null;
  int LabelFunctionValue = -1;
  ArrayList <DV> ArrayValue = null;
  ArrayList <Integer> IntArray = null;
  ArrayList <Float> FloatArray = null;
  ArrayList <String> StringArray = null;
  
  int ValueType;
  
  String CustomType = null;
  boolean TableIsLocked = false;
  
  
  
  
  
  
  
  
  
  
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
  
  public DV (ArrayList <DV> ArrayValue, DV ThisIsANormalArrayButTheresAlreadyAnArrayList) {
    ValueType = ValueTypes.T_Array;
    this.ArrayValue = ArrayValue;
  }
  
  public DV (ArrayList <Integer> IntArray, int WhyDoIStillHaveToAddTheseThisIsntEvenTheSameArrayList) {
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
      
      case (ValueTypes.T_Array):
        ArrayValue = NewDV.ArrayValue;
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
  
  
  
  
  
  public DV CallAsFunction (ArrayList <DV> Args) {
    // pretend this is interacting with the interpreter
    DV OutputOfInterpreter = null;
    return OutputOfInterpreter;
  }
  
  
  
  
  
  public DV GetIndex (DV Key) {
    
    if (Key.ValueType == ValueTypes.T_String) {
      switch (Key.StringValue) {
        case ("castTt"):
          return NativeFunctions.DV_CastTo;
        case ("clone"):
          try {return (DV) this.clone();} catch (Exception e) {println ("Internal Error: could not clone DV: " + e); return new DV();}
      }
    }
    
    switch (ValueType) {
      
      
      
      case (ValueTypes.T_Null):
        println ("Error: cannot index null");
        return new DV();
      
      
      
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
        println ("Error: cannot index bool");
        return new DV();
      
      
      
      case (ValueTypes.T_String):
        switch (Key.ValueType) {
          
          case (ValueTypes.T_String):
            switch (Key.StringValue) { // three level switch, yay or nay?
              case ("length"):
                return new DV (StringValue.length());
              case ("sub"):
                return NativeFunctions.String_Sub;
              case ("find"):
                return NativeFunctions.String_Find;
              case ("charAt"):
                return NativeFunctions.String_CharAt;
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
            if (!TableIsLocked) {
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
                case ("lockTable"):
                  return null; // this needs to be a function
                default:
                  return GetTableValue (Key);
              }
            } else {
              return GetTableValue (Key);
            }
          
          case (ValueTypes.T_Int):
            return GetTableValue (Key);
          
          default:
            println ("Error: cannot index table with non-string, non-int value");
            return new DV();
          
        }
      
      
      
      case (ValueTypes.T_LabelFunction):
        println ("Error: cannot index function");
        return new DV();
        
      
      
      case (ValueTypes.T_Array):
        switch (Key.ValueType) {
          
          case (ValueTypes.T_String):
            switch (Key.StringValue) {
              case ("length"):
                return new DV (ArrayValue.size());
              case ("sub"):
                return null; // this needs to be a function
              case ("find"):
                return null; // this needs to be a function
              case ("insert"):
                return null; // this needs to be a function
              case ("remove"):
                return null; // this needs to be a function
            }
          
          case (ValueTypes.T_Int):
            if (Key.IntValue < 1) {println ("Error: cannot index this array with " + Key.IntValue + "; index is too low");}
            if (Key.IntValue > IntArray.size()) {println ("Error: cannot index this array with " + Key.IntValue + "; length is " + ArrayValue.size());} // This isn't >= size() because it starts at 1 (index == size works)
            return ArrayValue.get(Key.IntValue);
          
          default:
            println ("Error: cannot index array with non-int, non-string value");
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
            if (Key.IntValue > IntArray.size()) {println ("Error: cannot index this intarray with " + Key.IntValue + "; length is " + IntArray.size());}
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
      
      case (ValueTypes.N_Array):
        return CastToArray();
      
      case (ValueTypes.N_IntArray):
        return CastToIntArray();
      
      case (ValueTypes.N_FloatArray):
        return CastToFloatArray();
      
      case (ValueTypes.N_StringArray):
        return CastToStringArray();
      
      default:
        if (CustomType != null) {
          
          return new DV();
        } else {
          println ("Error: cannot cast " + ValueTypes.TypeNames[ValueType] + " to " + NewType);
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
      
      case (ValueTypes.T_Array):
        return new DV (ArrayValue.size());
      
      case (ValueTypes.T_IntArray):
        return new DV (IntArray.size());
      
      case (ValueTypes.T_FloatArray):
        return new DV (FloatArray.size());
      
      case (ValueTypes.T_StringArray):
        return new DV (StringArray.size());
      
      default:
        println ("Internal Error in CastToInt(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  Integer CastToIntExplicit() {
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return null;
      
      case (ValueTypes.T_Int):
        return IntValue;
      
      case (ValueTypes.T_Float):
        return (int) FloatValue;
      
      case (ValueTypes.T_Bool):
        return BoolValue ? 1 : 0;
      
      case (ValueTypes.T_String):
        try {
          return Integer.parseInt(StringValue);
        } catch (NumberFormatException e) { // If StringValue cannot be cast, return 0
          return null;
        }
      
      case (ValueTypes.T_Array):
        return null;
      
      case (ValueTypes.T_Table):
        return null;
      
      case (ValueTypes.T_LabelFunction):
        return null;
      
      case (ValueTypes.T_IntArray):
        return null;
      
      case (ValueTypes.T_FloatArray):
        return null;
      
      case (ValueTypes.T_StringArray):
        return null;
      
      default:
        println ("Internal Error in CastToIntExplicit(): ValueType " + ValueType + " is not recognised");
        return null;
      
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
      
      case (ValueTypes.T_Array):
        return new DV((float)ArrayValue.size());
      
      case (ValueTypes.T_IntArray):
        return new DV ((float)IntArray.size());
      
      case (ValueTypes.T_FloatArray):
        return new DV ((float)FloatArray.size());
      
      case (ValueTypes.T_StringArray):
        return new DV ((float)StringArray.size());
      
      default:
        println ("Internal Error in CastToFloat(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  Float CastToFloatExplicit() {
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return null;
      
      case (ValueTypes.T_Int):
        return (float) IntValue;
      
      case (ValueTypes.T_Float):
        return FloatValue;
      
      case (ValueTypes.T_Bool):
        return BoolValue ? 1.0 : 0.0;
      
      case (ValueTypes.T_String):
        try {
          return Float.parseFloat(StringValue);
        } catch (NumberFormatException e) { // If StringValue cannot be cast, return 0.0
          return null;
        }
      
      case (ValueTypes.T_Table):
        return null;
      
      case (ValueTypes.T_LabelFunction):
        return null;
      
      case (ValueTypes.T_Array):
        return null;
      
      case (ValueTypes.T_IntArray):
        return null;
      
      case (ValueTypes.T_FloatArray):
        return null;
      
      case (ValueTypes.T_StringArray):
        return null;
      
      default:
        println ("Internal Error in CastToFloat(): ValueType " + ValueType + " is not recognised");
        return null;
      
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
      
      case (ValueTypes.T_Array):
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
      
      case (ValueTypes.T_Array):
        return new DV (ConvertArrayToString());
      
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
  
  
  
  
  
  String CastToStringExplicit() {
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return null;
      
      case (ValueTypes.T_Int):
        return Integer.toString(IntValue);
      
      case (ValueTypes.T_Float):
        return Float.toString(FloatValue);
      
      case (ValueTypes.T_Bool):
        return BoolValue ? "true" : "false";
      
      case (ValueTypes.T_String):
        return StringValue;
      
      case (ValueTypes.T_Table):
        return null;
      
      case (ValueTypes.T_LabelFunction):
        return null;
      
      case (ValueTypes.T_Array):
        return null;
      
      case (ValueTypes.T_IntArray):
        return null;
      
      case (ValueTypes.T_FloatArray):
        return null;
      
      case (ValueTypes.T_StringArray):
        return null;
      
      default:
        println ("Internal Error in CastToStringExplicit(): ValueType " + ValueType + " is not recognised");
        return null;
      
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
      
      case (ValueTypes.T_Array):
        return ConvertArrayToTable();
      
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
    println ("Error: cannot cast " + ValueTypes.GetName(ValueType) + " to function");
    return new DV();
  }
  
  
  
  
  
  DV CastToArray() {
    ArrayList <DV> Output = new ArrayList <DV> ();
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return new DV (Output, null); // This shouldn't be able to call the constructor DV(ArrayList<String>, null), right?
      
      case (ValueTypes.T_Int):
        for (int i = 0; i < IntValue; i ++) {Output.add(new DV());}
        return new DV (Output, null);
      
      case (ValueTypes.T_Float):
        for (int i = 0; i < floor(FloatValue); i ++) {Output.add(new DV());}
        return new DV (Output, null);
      
      case (ValueTypes.T_Bool):
        Output.add(BoolValue ? new DV(true) : new DV(false));
        return new DV (Output, null);
      
      case (ValueTypes.T_String):
        Output.add(new DV(StringValue));
        return new DV(Output, null);
      
      case (ValueTypes.T_Table):
        return ConvertTableToArray();
      
      case (ValueTypes.T_LabelFunction):
        println ("Error: cannot cast function to array");
        return new DV (Output, null);
      
      case (ValueTypes.T_Array):
        return new DV (ArrayValue, null);
      
      case (ValueTypes.T_IntArray):
        return ConvertIntArrayToArray();
      
      case (ValueTypes.T_FloatArray):
        return ConvertFloatArrayToArray();
      
      case (ValueTypes.T_StringArray):
        return ConvertStringArrayToArray();
      
      default:
        println ("Internal Error in CastToArray(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
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
        return ConvertTableToIntArray();
      
      case (ValueTypes.T_LabelFunction):
        println ("Error: cannot cast function to intarray");
        return new DV (Output, 0);
      
      case (ValueTypes.T_Array):
        return ConvertArrayToIntArray();
      
      case (ValueTypes.T_IntArray):
        return new DV (IntArray, 0);
      
      case (ValueTypes.T_FloatArray):
        return ConvertFloatArrayToIntArray();
      
      case (ValueTypes.T_StringArray):
        return ConvertStringArrayToIntArray();
      
      default:
        println ("Internal Error in CastToIntArray(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  DV CastToFloatArray() {
    ArrayList <Float> Output = new ArrayList <Float> ();
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return new DV (Output, 0.0);
      
      case (ValueTypes.T_Int):
        for (int i = 0; i < IntValue; i ++) {Output.add(0.0);}
        return new DV (Output, 0.0);
      
      case (ValueTypes.T_Float):
        for (int i = 0; i < floor(FloatValue); i ++) {Output.add(0.0);}
        return new DV (Output, 0.0);
      
      case (ValueTypes.T_Bool):
        Output.add(BoolValue ? 1.0 : 0.0);
        return new DV (Output, 0.0);
      
      case (ValueTypes.T_String):
        try {
          Output.add(Float.parseFloat(StringValue));
          return new DV (Output, 0.0);
        } catch (NumberFormatException e) {
          return new DV (Output, 0.0);
        }
      
      case (ValueTypes.T_Table):
        return ConvertTableToFloatArray();
      
      case (ValueTypes.T_LabelFunction):
        println ("Error: cannot cast function to floatarray");
        return new DV (Output, 0.0);
      
      case (ValueTypes.T_Array):
        return ConvertArrayToFloatArray();
      
      case (ValueTypes.T_IntArray):
        return ConvertIntArrayToFloatArray();
      
      case (ValueTypes.T_FloatArray):
        return new DV (FloatArray, 0.0);
      
      case (ValueTypes.T_StringArray):
        return ConvertStringArrayToFloatArray();
      
      default:
        println ("Internal Error in CastToFloatArray(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  DV CastToStringArray() {
    ArrayList <String> Output = new ArrayList <String> ();
    switch (ValueType) {
      
      case (ValueTypes.T_Null):
        return new DV (Output, "");
      
      case (ValueTypes.T_Int):
        for (int i = 0; i < IntValue; i ++) {Output.add(null);}
        return new DV (Output, "");
      
      case (ValueTypes.T_Float):
        for (int i = 0; i < floor(FloatValue); i ++) {Output.add("");}
        return new DV (Output, "");
      
      case (ValueTypes.T_Bool):
        Output.add(BoolValue ? "1" : "0");
        return new DV (Output, "");
      
      case (ValueTypes.T_String):
        Output.add(StringValue);
        return new DV (Output, "");
      
      case (ValueTypes.T_Table):
        return ConvertTableToStringArray();
      
      case (ValueTypes.T_LabelFunction):
        println ("Error: cannot cast function to stringarray");
        return new DV (Output, "");
      
      case (ValueTypes.T_Array):
        return ConvertArrayToStringArray();
      
      case (ValueTypes.T_IntArray):
        return ConvertIntArrayToStringArray();
      
      case (ValueTypes.T_FloatArray):
        return ConvertFloatArrayToStringArray();
      
      case (ValueTypes.T_StringArray):
        return new DV (StringArray, "");
      
      default:
        println ("Internal Error in CastToStringArray(): ValueType " + ValueType + " is not recognised");
        return new DV();
      
    }
  }
  
  
  
  
  
  
  
  
  
  
  boolean Equals (DV OtherDV) {
    if (ValueType != OtherDV.ValueType) return false;
    if (ValueType == ValueTypes.T_Null) return true; // Only reaches here if both are null
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
      
      case (ValueTypes.T_Array):
        if (ArrayValue.size() != OtherDV.ArrayValue.size()) return false;
        for (int i = 0; i < ArrayValue.size(); i ++) {
          if (!ArrayValue.get(i).Equals(OtherDV.ArrayValue.get(i))) return false;
        }
        return true;
      
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
      
      case (ValueTypes.T_Array):
        ArrayValue = null;
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
  
  
  
  String ConvertArrayToString() {
    if (ValueType != ValueTypes.T_Array) {println ("Internal Error in ConvertArrayToString(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return "array to string errored";}
    String Output = "{array: ";
    if (ArrayValue.size() > 0) Output += ArrayValue.get(0);
    for (int i = 0; i < ArrayValue.size(); i += 1) {
      Output += ", " + i + ": " + ArrayValue.get(i);
    }
    return Output + "}";
  }
  
  
  
  String ConvertIntArrayToString() {
    if (ValueType != ValueTypes.T_IntArray) {println ("Internal Error in ConvertIntArrayToString(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return "intarray to string errored";}
    String Output = "{intarray: ";
    if (IntArray.size() > 0) Output += IntArray.get(0);
    for (int i = 0; i < IntArray.size(); i += 1) {
      Output += ", " + i + ": " + IntArray.get(i);
    }
    return Output + "}";
  }
  
  
  
  String ConvertFloatArrayToString() {
    if (ValueType != ValueTypes.T_FloatArray) {println ("Internal Error in ConvertFloatArrayToString(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return "floatarray to string errored";}
    String Output = "{foatarray: ";
    if (FloatArray.size() > 0) Output += FloatArray.get(0);
    for (int i = 0; i < FloatArray.size(); i += 1) {
      Output += ", " + i + ": " + FloatArray.get(i);
    }
    return Output + "}";
  }
  
  
  
  String ConvertStringArrayToString() {
    if (ValueType != ValueTypes.T_StringArray) {println ("Internal Error in ConvertStringArrayToString(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return "stringarray to string errored";}
    String Output = "{stringarray: ";
    if (StringArray.size() > 0) Output += StringArray.get(0);
    for (int i = 0; i < StringArray.size(); i += 1) {
      Output += ", " + i + ": " + StringArray.get(i);
    }
    return Output + "}";
  }
  
  
  
  DV ConvertArrayToTable() {
    if (ValueType != ValueTypes.T_Array) {println ("Internal Error in ConvertArrayToTable(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <DV> ());}
    ArrayList <DV> Output = new ArrayList <DV> ();
    for (int i = 0; i < ArrayValue.size(); i ++) {
      Output.add(new DV (i+1));
      Output.add(ArrayValue.get(i));
    }
    return new DV (Output);
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
  
  
  
  DV ConvertTableToArray() {
    if (ValueType != ValueTypes.T_Table) {println ("Internal Error in ConvertTableToArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <DV> (), null);}
    ArrayList <DV> Output = new ArrayList <DV> ();
    for (int i = 0; i < TableValue.size(); i += 2) {
      DV V = TableValue.get(i);
      
      switch (V.ValueType) {
        case (ValueTypes.T_Table):
          Output.addAll(V.ConvertTableToArray().ArrayValue);
          break;
        case (ValueTypes.T_Array):
          Output.addAll(V.ArrayValue);
          break;
        case (ValueTypes.T_IntArray):
          Output.addAll(V.ConvertIntArrayToArray().ArrayValue);
          break;
        case (ValueTypes.T_FloatArray):
          Output.addAll(V.ConvertFloatArrayToArray().ArrayValue);
          break;
        case (ValueTypes.T_StringArray):
          Output.addAll(V.ConvertStringArrayToArray().ArrayValue);
          break;
        default:
          Output.add(V);
          break;
      }
      
    }
    return new DV (Output, null);
  }
  
  
  
  DV ConvertIntArrayToArray() {
    if (ValueType != ValueTypes.T_IntArray) {println ("Internal Error in ConvertIntArrayToArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <DV> (), null);}
    ArrayList <DV> Output = new ArrayList <DV> ();
    for (int I : IntArray) {
      Output.add(new DV(I));
    }
    return new DV (Output, null);
  }
  
  
  
  DV ConvertFloatArrayToArray() {
    if (ValueType != ValueTypes.T_FloatArray) {println ("Internal Error in ConvertFloatArrayToArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <DV> (), null);}
    ArrayList <DV> Output = new ArrayList <DV> ();
    for (float F : FloatArray) {
      Output.add(new DV(F));
    }
    return new DV (Output,  null);
  }
  
  
  
  DV ConvertStringArrayToArray() {
    if (ValueType != ValueTypes.T_StringArray) {println ("Internal Error in ConvertStringArrayToArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <DV> (), null);}
    ArrayList <DV> Output = new ArrayList <DV> ();
    for (String S : StringArray) {
      Output.add(new DV(S));
    }
    return new DV (Output, null);
  }
  
  
  
  DV ConvertTableToIntArray() {
    if (ValueType != ValueTypes.T_Table) {println ("Internal Error in ConvertTableToIntArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <Integer> (), 0);}
    ArrayList <Integer> Output = new ArrayList <Integer> ();
    for (int i = 0; i < TableValue.size(); i += 2) {
      DV V = TableValue.get(i);
      
      switch (V.ValueType) {
        case (ValueTypes.T_Table):
          Output.addAll(V.ConvertTableToIntArray().IntArray);
          break;
        case (ValueTypes.T_IntArray):
          Output.addAll(V.IntArray);
          break;
        case (ValueTypes.T_FloatArray):
          Output.addAll(V.ConvertFloatArrayToIntArray().IntArray);
          break;
        case (ValueTypes.T_StringArray):
          Output.addAll(V.ConvertStringArrayToIntArray().IntArray);
          break;
        default:
          Integer NewInt = V.CastToIntExplicit();
          if (NewInt != null) Output.add(NewInt);
          break;
      }
      
    }
    return new DV (Output, 0);
  }
  
  
  
  DV ConvertArrayToIntArray() {
    if (ValueType != ValueTypes.T_Array) {println ("Internal Error in ConvertArrayToIntArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <Integer> (), 0);}
    ArrayList <Integer> Output = new ArrayList <Integer> ();
    for (DV V : ArrayValue) {
      Integer CastedInt = V.CastToIntExplicit();
      if (CastedInt != null) {
        Output.add(CastedInt);
      }
    }
    return new DV (Output,  0);
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
    return new DV (Output, 0);
  }
  
  
  
  DV ConvertTableToFloatArray() {
    if (ValueType != ValueTypes.T_Table) {println ("Internal Error in ConvertTableToFloatArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <Float> (), 0.0);}
    ArrayList <Float> Output = new ArrayList <Float> ();
    for (int i = 0; i < TableValue.size(); i += 2) {
      DV V = TableValue.get(i);
      
      switch (V.ValueType) {
        case (ValueTypes.T_Table):
          Output.addAll(V.ConvertTableToFloatArray().FloatArray);
          break;
        case (ValueTypes.T_IntArray):
          Output.addAll(V.ConvertIntArrayToFloatArray().FloatArray);
          break;
        case (ValueTypes.T_FloatArray):
          Output.addAll(V.FloatArray);
          break;
        case (ValueTypes.T_StringArray):
          Output.addAll(V.ConvertStringArrayToFloatArray().FloatArray);
          break;
        default:
          Float NewFloat = V.CastToFloatExplicit();
          if (NewFloat != null) Output.add(NewFloat);
          break;
      }
      
    }
    return new DV (Output, 0.0);
  }
  
  
  
  DV ConvertArrayToFloatArray() {
    if (ValueType != ValueTypes.T_Array) {println ("Internal Error in ConvertArrayToFloatArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <Float> (), 0.0);}
    ArrayList <Float> Output = new ArrayList <Float> ();
    for (DV V : ArrayValue) {
      Float CastedFloat = V.CastToFloatExplicit();
      if (CastedFloat != null) {
        Output.add(CastedFloat);
      }
    }
    return new DV (Output, 0.0);
  }
  
  
  
  DV ConvertIntArrayToFloatArray() {
    if (ValueType != ValueTypes.T_IntArray) {println ("Internal Error in ConvertIntArrayToFloatArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <Float> (), 0.0);}
    ArrayList <Float> Output = new ArrayList <Float> ();
    for (int I : IntArray) {
      Output.add((float) I);
    }
    return new DV (Output, 0.0);
  }
  
  
  
  DV ConvertStringArrayToFloatArray() {
    if (ValueType != ValueTypes.T_StringArray) {println ("Internal Error in ConvertStringArrayToFloatArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <Float> (), 0.0);}
    ArrayList <Float> Output = new ArrayList <Float> ();
    for (String S : StringArray) {
      try {
        Output.add(Float.parseFloat(S));
      } catch (NumberFormatException e) {}
    }
    return new DV (Output, 0.0);
  }
  
  
  
  DV ConvertTableToStringArray() {
    if (ValueType != ValueTypes.T_Table) {println ("Internal Error in ConvertTableToStringArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <String> (), "");}
    ArrayList <String> Output = new ArrayList <String> ();
    for (int i = 0; i < TableValue.size(); i += 2) {
      DV V = TableValue.get(i);
      
      switch (V.ValueType) {
        case (ValueTypes.T_Table):
          Output.addAll(V.ConvertTableToStringArray().StringArray);
          break;
        case (ValueTypes.T_IntArray):
          Output.addAll(V.ConvertIntArrayToStringArray().StringArray);
          break;
        case (ValueTypes.T_FloatArray):
          Output.addAll(V.ConvertFloatArrayToStringArray().StringArray);
          break;
        case (ValueTypes.T_StringArray):
          Output.addAll(V.StringArray);
          break;
        default:
          String NewString = V.CastToStringExplicit();
          if (NewString != null) Output.add(NewString);
          break;
      }
      
    }
    return new DV (Output, "");
  }
  
  
  
  DV ConvertArrayToStringArray() {
    if (ValueType != ValueTypes.T_IntArray) {println ("Internal Error in ConvertArrayToStringArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <String> (), "");}
    ArrayList <String> Output = new ArrayList <String> ();
    for (DV V : ArrayValue) {
      String CastedString = V.CastToStringExplicit();
      if (CastedString != null) {
        Output.add(CastedString);
      }
    }
    return new DV (Output, "");
  }
  
  
  
  DV ConvertIntArrayToStringArray() {
    if (ValueType != ValueTypes.T_IntArray) {println ("Internal Error in ConvertIntArrayToStringArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <String> (), "");}
    ArrayList <String> Output = new ArrayList <String> ();
    for (int I : IntArray) {
      Output.add(Integer.toString(I));
    }
    return new DV (Output, "");
  }
  
  
  
  DV ConvertFloatArrayToStringArray() {
    if (ValueType != ValueTypes.T_FloatArray) {println ("Internal Error in ConvertFloatArrayToStringArray(): cannot convert when ValueType is " + ValueTypes.GetName(ValueType)); return new DV (new ArrayList <String> (), "");}
    ArrayList <String> Output = new ArrayList <String> ();
    for (float F : FloatArray) {
      Output.add(Float.toString(F));
    }
    return new DV (Output, "");
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
