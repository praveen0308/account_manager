import 'package:account_manager/local/app_storage.dart';
import 'package:account_manager/ui/features/gst_calculator/widgets/button_model.dart';
import 'package:bloc/bloc.dart';
import 'package:function_tree/function_tree.dart';
part 'gst_calculator_state.dart';

class GstCalculatorCubit extends Cubit<GstCalculatorState> {
  GstCalculatorCubit() : super(GstCalculatorInitial());

  String expression = "";
  String answer = "";
  List<String> operationSigns = ["+","-","*","/","%"];
  Future<void> init() async{

    expression = await AppStorage.getGstExpression() ?? "";
    answer = await AppStorage.getGstAnswer() ?? "";

    emit(EvaluationPerformed(expression, answer));
  }
  void performBtnClick(ButtonModel btnModel){



    switch(btnModel.action){

      case CalcAction.number:
        expression += btnModel.quantity;
        break;
      case CalcAction.allClear:
        answer = "";
        expression = "";
        break;
      case CalcAction.delete:
        if(expression.isNotEmpty){
          expression = expression.substring(0,expression.length-1);
        }
        if(expression.isEmpty){answer = "";}


        break;
      case CalcAction.percentage:
        if(expression.isNotEmpty){
          if(operationSigns.contains(expression[expression.length-1])){

          }else{
            expression = "$expression%";
          }
        }

        break;
      case CalcAction.division:
        if(expression.isNotEmpty){
          if(!operationSigns.contains(expression[expression.length-1])){
            expression = "$expression/";
          }

        }
        break;
      case CalcAction.multiplication:
        if(expression.isNotEmpty){
          if(!operationSigns.contains(expression[expression.length-1])){
            expression = "$expression*";
          }
        }
        break;
      case CalcAction.addition:
        if(expression.isNotEmpty){
          if(!operationSigns.contains(expression[expression.length-1])){
            expression = "$expression+";
          }

        }
        break;
      case CalcAction.subtraction:
        if(expression.isNotEmpty){
          if(!operationSigns.contains(expression[expression.length-1])){
            expression = "$expression-";
          }
        }
        break;
      case CalcAction.eval:
        expression = "";
        break;
      case CalcAction.evalGst:
        final operation = btnModel.quantity[0];
        final quantity = int.parse(btnModel.quantity.substring(0,btnModel.quantity.length));
        if(operation == "+"){
          final gstAmount = "($answer*$quantity)/100".interpret().toString();
          expression = "$expression+$gstAmount";
          // answer = (answer + gstAmount).interpret().toString();
        }else{
          final gstAmount = "$answer-($answer*(100/(100+$quantity)))".interpret().toString();
          expression = "$expression$gstAmount";
        }



        break;
    }
    evaluateExpression();

    emit(EvaluationPerformed(expression, answer));
  }

  void evaluateExpression(){

    try{

      if(expression.length<250){
        RegExp regex = RegExp(r'([.]*0)(?!.*\d)');
        answer = expression.interpret().toString();
        answer = answer.toString().replaceAll(regex, '');
      }
      else{
        expression = "";
        answer = "LimitReached!!!";
      }
    }catch(e){

    }
  }

}
