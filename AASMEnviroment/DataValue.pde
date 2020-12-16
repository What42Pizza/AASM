public class DV implements Cloneable {
  
  
  
  
  
  // Vars
  
  int IntValue = 0;
  float FloatValue = 0;
  boolean BoolValue = false;
  String StringValue = null;
  ArrayList <DV> TableValue = null;
  int LabelFunctionValue = -1;
  ArrayList <Integer> IntArray = null;
  ArrayList <Float> FloatArray = null;
  ArrayList <String> StringArray = null;
  
  int ValueType;
  
  
  
  
  
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
  
  public DV (int LabelFunctionValue, boolean ThisIsLabelFunctionValueButICantHaveAnotherIntConstructorSo) {
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
  
  
  
  
  
  
  
  
  
  // Custom functions
  
  
  
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
        println ("Internal error: Cannot determin type " + ValueType);
        return false;
      
    }
  }
  
  
  
  
  
  void ForgetValue() { // DOES NOT RESET VALUE TYPE!!!!!!!!!!!!!!!!!!!
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
  
  
  
  
  
  
  
  
  
  
  // Other functions
  
  
  
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
  
  
  
  
  
  
  
  
  
  
}
