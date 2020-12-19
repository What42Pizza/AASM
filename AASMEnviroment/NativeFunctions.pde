DV ValueOfTHIS; // Temp

NativeFunctions NativeFunctions = new NativeFunctions();





final public class NativeFunctions {
  
  
  
  
  
  final public DV DV_CastTo = new DV (0, true) {@Override public DV CallAsFunction (ArrayList <DV> Args) { // This function is run whenever DV.castTo() is called, so it returns the casted value
    if (Args.size() == 0) {println ("Error: cannot call .CastTo with zero arguments"); return new DV();}
    if (Args.size() > 1) {println ("Error: cannot call .CastTo with more than one argument"); return new DV();}
    if (Args.get(0).ValueType != ValueTypes.T_String) {println ("Error: cannot call .CastTo with non-string as first argument"); return new DV();}
    if (ValueOfTHIS.CustomType != null) {
      DV CustomCastFunction = ValueOfTHIS.GetTableValue(new DV("castTo"));
      // pretend this calls the interpreter
      DV ResultOfCastFunction = null;
      return ResultOfCastFunction;
    } else {
       return ValueOfTHIS.CastTo(Args.get(0).StringValue);
    }
  }};
  
  
  
  
  
  final public DV String_Sub = new DV (0, true) {@Override public DV CallAsFunction (ArrayList <DV> Args) {
    if (ValueOfTHIS.ValueType != ValueTypes.T_String) {println ("Error: cannot call string.Sub on a non-string value"); return new DV();}
    for (DV V : Args) if (V.ValueType != ValueTypes.T_Int) {println ("Error: cannot call string.Sub with non-int values"); return new DV();}
    switch (Args.size()) {
      case (0):
        println ("Error: cannot call string.Sub with zero arguments");
        return new DV();
      case (1):
        return new DV (ValueOfTHIS.StringValue.substring(Args.get(0).IntValue));
      case (2):
        return new DV (ValueOfTHIS.StringValue.substring(Args.get(0).IntValue, Args.get(1).IntValue));
      default:
        println ("Error: cannot call string.Sub with more than two arguments");
        return new DV();
    }
  }};
  
  
  
  
  
  final public DV String_Find = new DV (0, true) {@Override public DV CallAsFunction (ArrayList <DV> Args) {
    int ArgsSize = Args.size();
    if (ValueOfTHIS.ValueType != ValueTypes.T_String) {println ("Error: cannot call string.Find on a non-string value"); return new DV();}
    if (ArgsSize > 2) {println ("Error: cannot call string.Find with more than two arguments"); return new DV();}
    if (ArgsSize == 0) {println ("Error: cannot call string.Find with zero arguments"); return new DV();}
    if (Args.get(0).ValueType != ValueTypes.T_String) {println ("Error: cannot call string.Find with non-string value as first argument"); return new DV();}
    Integer FoundPos;
    if (ArgsSize == 1) {
      FoundPos = FindPatternInString (ValueOfTHIS.StringValue, Args.get(0).StringValue, 0);
    } else {
      FoundPos = FindPatternInString (ValueOfTHIS.StringValue, Args.get(0).StringValue, Args.get(0).IntValue);
    }
    if (FoundPos != null) {
      return new DV(FoundPos);
    } else {
      return new DV();
    }
  }};
  
  
  
  Integer FindPatternInString (String In, String Pattern, int StartPos) {
    if (In == null || Pattern == null) return null;
    int InLength = In.length();
    int PatternLength = Pattern.length();
    if (InLength < PatternLength || PatternLength == 0) return null; // If InLength == 0, then either InLength < PatternLength or PatternLength == 0
    if (In.equals(Pattern)) return 1;
    char StartingChar = Pattern.charAt(0);
    int SameStartingChars = 1;
    if (PatternLength > 1) while (Pattern.charAt(SameStartingChars) == StartingChar) SameStartingChars ++; // Count same starting chars
    int EndPos = InLength - PatternLength + 1;
    for (int i = StartPos-1; i < EndPos;) { // This is still garunteed to inc
      //println (i);
      for (int c = 0; c < PatternLength; c ++) {
        if (In.charAt(i+c) != Pattern.charAt(c)) {
          i += min(c+1, SameStartingChars);
          break;
        }
        if (c == PatternLength-1) return i+1;
      }
    }
    return null;
  }
  
  
  
  
  
  final public DV String_CharAt = new DV (0, true) {@Override public DV CallAsFunction (ArrayList <DV> Args) {
    if (ValueOfTHIS.ValueType != ValueTypes.T_String) {println ("Error: cannot call string.CharAt on a non-string value"); return new DV();}
    if (Args.size() == 0) {println ("Error: cannot call string.CharAt with zero arguments"); return new DV();}
    if (Args.size() > 1) {println ("Error: cannot call string.CharAt with more than one arguments"); return new DV();}
    DV IndexValue = Args.get(0);
    int Index;
    switch (IndexValue.ValueType) {
      case (ValueTypes.T_Int):
        Index = IndexValue.IntValue;
        break;
      case (ValueTypes.T_Float):
        Index = (int) IndexValue.FloatValue;
        break;
      default:
        println ("Error: cannot call string.CharAt with non-int, non-float as first argument");
        return new DV();
    }
    return new DV(ValueOfTHIS.StringValue.charAt(Index) + "");
  }};
  
  
  
  
  
}
