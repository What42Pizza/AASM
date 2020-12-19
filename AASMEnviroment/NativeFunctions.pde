DV ValueOfTHIS; // Temp

NativeFunctions NativeFunctions = new NativeFunctions();





final public class NativeFunctions {
  
  
  
  
  
  final public DV DV_CastTo = new DV (0, true) {@Override public ArrayList <DV> CallAsFunction (ArrayList <DV> Args) { // This function is run whenever DV.castTo() is called, so it returns the casted value
    ArrayList <DV> Output = new ArrayList <DV> ();
    if (Args.size() == 0) {println ("Error: cannot call .CastTo with zero arguments"); return Output;}
    if (Args.size() > 1) {println ("Error: cannot call .CastTo with more than one argument"); return Output;}
    if (Args.get(0).ValueType != ValueTypes.T_String) {println ("Error: cannot call .CastTo with non-string as first argument"); return Output;}
    if (ValueOfTHIS.CustomType != null) {
      DV CustomCastFunction = ValueOfTHIS.GetTableValue(new DV("castTo"));
      // pretend this calls the interpreter
      DV ResultOfCastFunction = null;
      Output.add(ResultOfCastFunction);
    } else {
      Output.add(ValueOfTHIS.CastTo(Args.get(0).StringValue));
    }
    return Output;
  }};
  
  
  
  
  
  final public DV String_Sub = new DV (0, true) {@Override public ArrayList <DV> CallAsFunction (ArrayList <DV> Args) {
    ArrayList <DV> Output = new ArrayList <DV> ();
    if (ValueOfTHIS.ValueType != ValueTypes.T_String) {println ("Error: cannot call string.Sub on a non-string value"); return Output;}
    for (DV V : Args) if (V.ValueType != ValueTypes.T_Int) {println ("Error: cannot call string.Sub with non-int values"); return Output;}
    switch (Args.size()) {
      case (0):
        println ("Error: cannot call string.Sub with zero arguments");
      case (1):
        Output.add(new DV (ValueOfTHIS.StringValue.substring(Args.get(0).IntValue)));
        return Output;
      case (2):
        Output.add(new DV (ValueOfTHIS.StringValue.substring(Args.get(0).IntValue, Args.get(1).IntValue)));
      default:
        println ("Error: cannot call string.Sub with more than two arguments");
        return Output;
    }
  }};
  
  
  
  
  
  final public DV String_Find = new DV (0, true) {@Override public ArrayList <DV> CallAsFunction (ArrayList <DV> Args) {
    ArrayList <DV> Output = new ArrayList <DV> ();
    int ArgsSize = Args.size();
    if (ValueOfTHIS.ValueType != ValueTypes.T_String) {println ("Error: cannot call string.Find on a non-string value"); return Output;}
    if (ArgsSize > 2) {println ("Error: cannot call string.Find with more than two arguments"); return Output;}
    if (ArgsSize == 0) {println ("Error: cannot call string.Find with zero arguments"); return Output;}
    if (Args.get(0).ValueType != ValueTypes.T_String) {println ("Error: cannot call string.Find with non-string value as first argument"); return Output;}
    Integer FoundPos;
    if (ArgsSize == 1) {
      FoundPos = FindPatternInString (ValueOfTHIS.StringValue, Args.get(0).StringValue, 0);
    } else {
      FoundPos = FindPatternInString (ValueOfTHIS.StringValue, Args.get(0).StringValue, Args.get(0).IntValue);
    }
    if (FoundPos != null) Output.add(new DV(FoundPos));
    return Output;
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
  
  
  
  
  
  final public DV String_CharAt = new DV (0, true) {@Override public ArrayList <DV> CallAsFunction (ArrayList <DV> Args) {
    ArrayList <DV> Output = new ArrayList <DV> ();
    if (ValueOfTHIS.ValueType != ValueTypes.T_String) {println ("Error: cannot call string.CharAt on a non-string value"); return Output;}
    if (Args.size() == 0) {println ("Error: cannot call string.CharAt with zero arguments"); return Output;}
    if (Args.size() > 1) {println ("Error: cannot call string.CharAt with more than one arguments"); return Output;}
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
        return Output;
    }
    Output.add(new DV(ValueOfTHIS.StringValue.charAt(Index) + ""));
    return Output;
  }};
  
  
  
  
  
}
