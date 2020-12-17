final public static class ValueTypes {
  
  final static int T_Null = 0;
  final static int T_Int = 1;
  final static int T_Float = 2;
  final static int T_Bool = 3;
  final static int T_String = 4;
  final static int T_Table = 5;
  final static int T_LabelFunction = 6;
  final static int T_IntArray = 7;
  final static int T_FloatArray = 8;
  final static int T_StringArray = 9;
  
  final static String N_Null = "null";
  final static String N_Int = "int";
  final static String N_Float = "float";
  final static String N_Bool = "bool";
  final static String N_String = "string";
  final static String N_Table = "table";
  final static String N_LabelFunction = "function";
  final static String N_IntArray = "intarray";
  final static String N_FloatArray = "floatarray";
  final static String N_StringArray = "stringarray";
  
  final static String[] TypeNames = {
    N_Null,
    N_Int,
    N_Float,
    N_Bool,
    N_String,
    N_Table,
    N_LabelFunction,
    N_IntArray,
    N_FloatArray,
    N_StringArray,
  };
  
  final static String GetName (int ValueType) {
    if (ValueType < 0) return "Internal Error in GetName(): ValueType " + ValueType + " cannot be negative";
    if (ValueType >= TypeNames.length) return "Internal Error in GetName(): ValueType " + ValueType + " is too high";
    return TypeNames[ValueType];
  }
  
}
