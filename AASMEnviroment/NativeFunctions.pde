DV ValueOfTHIS; // Temp

NativeFunctions NativeFunctions = new NativeFunctions();





final public class NativeFunctions {
  
  
  
  
  
  final public DV DV_CastTo = new DV (0, true) {@Override public DV CallAsFunction (ArrayList <DV> Args) { // This function is run whenever DV.castTo() is called, so it returns the casted value
    if (Args.size() == 0) {println ("Error: cannot call .castTo with zero arguments"); return new DV();}
    if (Args.size() > 1) {println ("Error: cannot call .castTo with more than one argument"); return new DV();}
    if (Args.get(0).ValueType != ValueTypes.T_String) {println ("Error: cannot call .castTo with non-string as first argument"); return new DV();}
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
    if (ValueOfTHIS.ValueType != ValueTypes.T_String) {println ("Error: cannot call string.sub on a non-string value"); return new DV();}
    if (!ArgsAreOfType(Args, ValueTypes.T_Int)) {println ("Error: cannot call string.sub with non-int values"); return new DV();}
    switch (Args.size()) {
      case (0):
        println ("Error: cannot call string.sub with zero arguments");
        return new DV();
      case (1):
        return new DV (ValueOfTHIS.StringValue.substring(Args.get(0).IntValue));
      case (2):
        return new DV (ValueOfTHIS.StringValue.substring(Args.get(0).IntValue, Args.get(1).IntValue));
      default:
        println ("Error: cannot call string.sub with more than two arguments");
        return new DV();
    }
  }};
  
  
  
  
  
  final public DV String_Find = new DV (0, true) {@Override public DV CallAsFunction (ArrayList <DV> Args) {
    int ArgsSize = Args.size();
    if (ValueOfTHIS.ValueType != ValueTypes.T_String) {println ("Error: cannot call string.find on a non-string value"); return new DV();}
    if (ArgsSize > 2) {println ("Error: cannot call string.find with more than two arguments"); return new DV();}
    if (ArgsSize == 0) {println ("Error: cannot call string.find with zero arguments"); return new DV();}
    if (!ArgsAreOfType (Args, new int[] {ValueTypes.T_String, ValueTypes.T_Int})) {println ("Error: cannot call string.find with non-string value as first argument or non-int value as second argument"); return new DV();}
    Integer FoundPos;
    if (ArgsSize == 1) {
      FoundPos = FindPatternInString (ValueOfTHIS.StringValue, Args.get(0).StringValue, 0);
    } else {
      FoundPos = FindPatternInString (ValueOfTHIS.StringValue, Args.get(0).StringValue, Args.get(1).IntValue);
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
    if (ValueOfTHIS.ValueType != ValueTypes.T_String) {println ("Error: cannot call string.charAt on a non-string value"); return new DV();}
    if (Args.size() == 0) {println ("Error: cannot call string.charAt with zero arguments"); return new DV();}
    if (Args.size() > 1) {println ("Error: cannot call string.charAt with more than one arguments"); return new DV();}
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
        println ("Error: cannot call string.charAt with non-int, non-float as first argument");
        return new DV();
    }
    return new DV(ValueOfTHIS.StringValue.charAt(Index) + "");
  }};
  
  
  
  
  
  final public DV Table_Sub = new DV (0, true) {@Override public DV CallAsFunction (ArrayList <DV> Args) {
    if (ValueOfTHIS.ValueType != ValueTypes.T_Table) {println ("Error: cannot call table.sub on a non-table value"); return new DV();}
    int ArgsSize = Args.size();
    if (ArgsSize == 0) {println ("Error: cannot call table.sub with zero arguments"); return new DV();}
    if (ArgsSize > 2) {println ("Error: cannot call table.sub with more than 2 arguments"); return new DV();}
    if (!ArgsAreOfType(Args, ValueTypes.T_Int)) {println ("Error: cannot call table.sub with non-int arguments"); return new DV();}
    if (ArgsSize == 1) {
      return SubTable (ValueOfTHIS, Args.get(0).IntValue);
    } else {
      return SubTable (ValueOfTHIS, Args.get(0).IntValue, Args.get(1).IntValue);
    }
  }};
  
  
  
  DV SubTable (DV TableValueIn, int EndPos) {
    return SubTable (TableValueIn, 0, EndPos);
  }
  
  DV SubTable (DV TableValueIn, int StartPos, int EndPos) {
    ArrayList <DV> Output = new ArrayList <DV> ();
    ArrayList <DV> TableIn = TableValueIn.TableValue;
    int TableLength = TableIn.size() / 2;
    EndPos   = ((EndPos   - 1 + TableLength * 1000) % TableLength) * 2;
    StartPos = ((StartPos - 1 + TableLength * 1000) % TableLength) * 2;
    for (int i = 0; i < EndPos; i ++) { // This *should* have +=2, but then I'd also have to do two .add()s, so this is actually fine
      Output.add(TableIn.get(i));
    }
    return new DV (Output);
  }
  
  
  
  
  
  final public DV Table_Find = new DV (0, true) {@Override public DV CallAsFunction (ArrayList <DV> Args) {
    if (ValueOfTHIS.ValueType != ValueTypes.T_Table) {println ("Error: cannot call table.find on a non-table value"); return new DV();}
    if (Args.size() == 0) {println ("Error: cannot call table.find with zero arguments"); return new DV();}
    if (Args.size() > 1) {println ("Error: cannot call table.find with more than 1 argument"); return new DV();}
    ArrayList <DV> TableValue = ValueOfTHIS.TableValue;
    DV DVToFind = Args.get(0);
    for (int i = 0; i < TableValue.size(); i += 2) {
      if (TableValue.get(i).Equals(DVToFind)) return new DV (i / 2 + 1);
    }
    return new DV();
  }};
  
  
  
  
  
  final public DV Table_Insert = new DV (0, true) {@Override public DV CallAsFunction (ArrayList <DV> Args) {
    if (ValueOfTHIS.ValueType != ValueTypes.T_Table) {println ("Error: cannot call table.insert on a non-table value"); return new DV();}
    int ArgsSize = Args.size();
    if (ArgsSize == 0) {println ("Error: cannot call table.insert with zero arguments"); return new DV();}
    if (ArgsSize > 2) {println ("Error: cannot call table.insert with more than 2 arguments"); return new DV();}
    ArrayList <DV> TableValue = ValueOfTHIS.TableValue;
    if (ArgsSize == 1) {
      TableValue.add(new DV (TableValue.size() / 2 + 1));
      TableValue.add(Args.get(0));
    } else {
      if (Args.get(1).ValueType != ValueTypes.T_Int) {println ("Error: cannot call table.insert with non-int as second argument"); return new DV();}
      int Pos = Args.get(1).IntValue;
      int TableLength = TableValue.size();
      int TablePos = ((Pos - 1 + TableLength * 1000) % TableLength) * 2;
      TableValue.add(TablePos, new DV (Pos));
      TableValue.add(TablePos+1, Args.get(0));
    }
    return ValueOfTHIS;
  }};
  
  
  
  
  
  final public DV Table_Remove = new DV (0, true) {@Override public DV CallAsFunction (ArrayList <DV> Args) {
    if (ValueOfTHIS.ValueType != ValueTypes.T_Table) {println ("Error: cannot call table.remove on a non-table value"); return new DV();}
    int ArgsSize = Args.size();
    if (ArgsSize > 1) {println ("Error: cannot call table.remove with more than 1 argument"); return new DV();}
    ArrayList <DV> TableValue = ValueOfTHIS.TableValue;
    DV RemovedValue;
    if (ArgsSize == 0) {
      RemovedValue = TableValue.remove(TableValue.size()-1);
      TableValue.remove(TableValue.size()-1);
    } else {
      if (Args.get(0).ValueType != ValueTypes.T_Int) {println ("Error: cannot call table.remove with non-int, non-null value as first argument"); return new DV();}
      int Pos = Args.get(0).IntValue;
      int TableLength = TableValue.size() / 2;
      int TablePos = ((Pos - 1 + TableLength * 1000) % TableLength) * 2;
      TableValue.remove(TablePos);
      RemovedValue = TableValue.remove(TablePos);
    }
    return RemovedValue;
  }};
  
  
  
  
  
  
  
  
  
  
  boolean ArgsAreOfType (ArrayList <DV> Args, int[] ArgTypes) {
    //if (ArgTypes.length != Args.size()) {println ("Internal Error in ArgsAreOfType: Args and ArgTypes have to be the same length (Args.size(): " + Args.size() + ", ArgTypes.length: " + ArgTypes.length + ")"); return false;}
    if (Args.size() > ArgTypes.length) {println ("Internal Error in ArgsAreOfType: Args is longer than ArgTypes"); return false;}
    for (int i = 0; i < Args.size(); i ++) {
      if (ArgTypes[i] == -1) continue;
      if (Args.get(i).ValueType != ArgTypes[i]) return false;
    }
    return true;
  }
  
  boolean ArgsAreOfType (ArrayList <DV> Args, int ArgType) {
    for (DV V : Args) {
      if (V.ValueType != ArgType) return false;
    }
    return true;
  }
  
  
  
  
  
}
