public class DV {
  
  
  
  
  
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
  
  
  
  public void WhenWrittenTo (DV NewDV) {
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
  
  
  
  
  
  void SetTo (DV NewDV) {
    WhenWrittenTo (NewDV);
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
  
  
  
  
  
  
  
  
  
  
}
