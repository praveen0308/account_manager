class ButtonModel {
  String displayText;
  bool isOperation;
  String quantity;
  CalcAction action;

  ButtonModel(this.displayText, this.isOperation, this.quantity, this.action);
}

enum CalcAction {
  number,
  allClear,
  delete,
  percentage,
  division,
  multiplication,
  addition,
  subtraction,
  eval,
  evalGst,

}
