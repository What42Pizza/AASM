Variable_Manager VariableManager = new Variable_Manager();





public class Variable_Manager {
  
  
  
  // Vars
  
  ArrayList <String> GlobalVarNames = new ArrayList <String> ();
  ArrayList <DV> GlobalVarValues = new ArrayList <DV> ();
  
  ArrayList <String> BlockVarNames = new ArrayList <String> ();
  ArrayList <DV> BlockVarValues = new ArrayList <DV> ();
  ArrayList <Integer> BlockStarts = new ArrayList <Integer> ();
  
  ArrayList <ArrayList <String>> ShelfedVarNames = new ArrayList <ArrayList <String>> (); // this works?
  ArrayList <ArrayList <DV>> ShelfedVarValues = new ArrayList <ArrayList <DV>> ();
  ArrayList <ArrayList <Integer>> ShelfedBlockStarts = new ArrayList <ArrayList <Integer>> ();
  
  
  
  
  
  // Functions
  
  void StartBlock() {
    BlockStarts.add(BlockVarNames.size());
  }
  
  
  
  void EndBlock() {
    int CurrBlockStart = BlockStarts.remove(BlockStarts.size()-1); // Get start of block
    int LengthOfCurrBlock = BlockVarNames.size() - CurrBlockStart; // Calc length (num to remove)
    for (int i = 0; i < LengthOfCurrBlock; i ++) {                 // Remove n times
      BlockVarNames.remove(CurrBlockStart);
      BlockVarValues.remove(CurrBlockStart);
    }
  }
  
  
  
  void ShelfVars() {
    ShelfedVarNames.add(BlockVarNames);
    ShelfedVarValues.add(BlockVarValues);
    ShelfedBlockStarts.add(BlockStarts);
    BlockVarNames = new ArrayList <String> ();
    BlockVarValues = new ArrayList <DV> ();
    BlockStarts = new ArrayList <Integer> ();
  }
  
  
  
  void RetrieveVars() {
    int LastValueIndex = ShelfedVarNames.size() - 1;
    BlockVarNames  = ShelfedVarNames   .remove(LastValueIndex);
    BlockVarValues = ShelfedVarValues  .remove(LastValueIndex);
    BlockStarts    = ShelfedBlockStarts.remove(LastValueIndex);
  }
  
  
  
  boolean AddVar (String VarName) {
    if (VarAlreadyExists(VarName)) return false; // This basically duplicated code is really annoying but I don't really see any way to avoid it (other than having these two lines in a seperate function)
    if (BlockStarts.size() == 0) {
      GlobalVarNames.add(VarName);
      GlobalVarValues.add(new DV());
    } else {
      BlockVarNames.add(VarName);
      BlockVarValues.add(new DV());
    }
    return true;
  }
  
  
  
  boolean AddVar (String VarName, DV VarValue) {
    if (VarAlreadyExists(VarName)) return false;
    if (BlockStarts.size() == 0) {
      GlobalVarNames.add(VarName);
      GlobalVarValues.add(VarValue);
    } else {
      BlockVarNames.add(VarName);
      BlockVarValues.add(VarValue);
    }
    return true;
  }
  
  
  
  boolean VarAlreadyExists (String VarName) { // (same here)
    for (String S : BlockVarNames) {
      if (S.equals(VarName)) return true;
    }
    for (String S : GlobalVarNames) {
      if (S.equals(VarName)) return true;
    }
    return false;
  }
  
  
  
  DV GetVar (String VarName) {
    for (int i = 0; i < BlockVarNames.size(); i ++) {
      if (BlockVarNames.get(i).equals(VarName)) {
        return BlockVarValues.get(i);
      }
    }
    for (int i = 0; i < GlobalVarNames.size(); i ++) {
      if (GlobalVarNames.get(i).equals(VarName)) {
        return GlobalVarValues.get(i);
      }
    }
    return null;
  }
  
  
  
}
