import 'package:account_manager/local/app_storage.dart';
import 'package:account_manager/ui/features/gst_calculator/gst_calculator_cubit.dart';
import 'package:account_manager/ui/features/gst_calculator/widgets/button_model.dart';
import 'package:account_manager/ui/features/gst_calculator/widgets/buttons.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/widgets/marquee_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:googleapis/admob/v1.dart';

class GstCalculator extends StatefulWidget {
  const GstCalculator({Key? key}) : super(key: key);

  @override
  State<GstCalculator> createState() => _GstCalculatorState();
}

class _GstCalculatorState extends State<GstCalculator> {

  List<ButtonModel> calcButtons = [];
  List<ButtonModel> gstButtons = [];
  String subTitle = "";
  String mainTitle = "";

  @override
  void initState() {
    calcButtons = getCalculatorButtons();
    gstButtons = getGstButtons();

    BlocProvider.of<GstCalculatorCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery
        .of(context)
        .size;

    const double itemHeight = 160;
    final double itemWidth = size.width / 2;

    const double itemHeight1 = 90;

    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                    child: BlocBuilder<GstCalculatorCubit, GstCalculatorState>(
                      builder: (context, state) {
                        if (state is EvaluationPerformed) {
                          mainTitle = state.expression;
                          subTitle = state.answer;
                          AppStorage.setGstExpression(state.expression);
                          AppStorage.setGstAnswer(state.answer);
                        }

                        return Container(
                          padding: const EdgeInsets.all(16),
                          width: MediaQuery
                              .of(context)
                              .size
                              .width,
                          decoration: BoxDecoration(
                              color: AppColors.primaryLightest,
                              borderRadius: BorderRadius.circular(8)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              MarqueeWidget(
                                  child: Text(
                                    mainTitle,
                                    maxLines: 1,
                                    style: const TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w400,
                                        color: AppColors.primaryDarkest),
                                  )),
                              Flexible(
                                child: Text(
                                  subTitle.isEmpty ? "0" : "= $subTitle",
                                  maxLines: 2,
                                  style: const TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.primaryDarkest),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    )),
                const SizedBox(
                  height: 16,
                ),
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: gstButtons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (itemWidth / itemHeight1),
                      crossAxisCount: 5,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                    ),
                    itemBuilder: (_, index) {
                      var btnModel = gstButtons[index];
                      return BtnType2(
                        buttonModel: btnModel,
                        onItemClick: () {
                          BlocProvider.of<GstCalculatorCubit>(context)
                              .performBtnClick(btnModel);
                        },
                      );
                    }),
                const SizedBox(
                  height: 12,
                ),
                GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: calcButtons.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: (itemWidth / itemHeight),
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                    ),
                    itemBuilder: (_, index) {
                      var btnModel = calcButtons[index];
                      return BtnType1(
                        buttonModel: btnModel,
                        onItemClick: () {
                          BlocProvider.of<GstCalculatorCubit>(context)
                              .performBtnClick(btnModel);
                        },
                      );
                    })
              ],
            ),
          ),
        ));
  }

  List<ButtonModel> getCalculatorButtons() {
    List<ButtonModel> buttons = [];

    // 1st row
    buttons.add(ButtonModel("AC", true, "", CalcAction.allClear));
    buttons.add(ButtonModel("⌫", true, "", CalcAction.delete));
    buttons.add(ButtonModel("%", true, "", CalcAction.percentage));
    buttons.add(ButtonModel("÷", true, "/", CalcAction.division));

    //2nd row
    buttons.add(ButtonModel("7", true, "7", CalcAction.number));
    buttons.add(ButtonModel("8", true, "8", CalcAction.number));
    buttons.add(ButtonModel("9", true, "9", CalcAction.number));
    buttons.add(ButtonModel("x", true, "*", CalcAction.multiplication));

    // 3rd row
    buttons.add(ButtonModel("4", true, "4", CalcAction.number));
    buttons.add(ButtonModel("5", true, "5", CalcAction.number));
    buttons.add(ButtonModel("6", true, "6", CalcAction.number));
    buttons.add(ButtonModel("-", true, "-", CalcAction.subtraction));

    // 4th row
    buttons.add(ButtonModel("1", true, "1", CalcAction.number));
    buttons.add(ButtonModel("2", true, "2", CalcAction.number));
    buttons.add(ButtonModel("3", true, "3", CalcAction.number));
    buttons.add(ButtonModel("+", true, "+", CalcAction.addition));

    // 5th row
    buttons.add(ButtonModel("00", true, "00", CalcAction.number));
    buttons.add(ButtonModel("0", true, "0", CalcAction.number));
    buttons.add(ButtonModel(".", true, ".", CalcAction.number));
    buttons.add(ButtonModel("=", true, "=", CalcAction.eval));

    return buttons;
  }

  List<ButtonModel> getGstButtons() {
    List<ButtonModel> buttons = [];

    // 1st row
    buttons.add(ButtonModel("GST-3%", true, "-3", CalcAction.evalGst));
    buttons.add(ButtonModel("-5%", true, "-5", CalcAction.evalGst));
    buttons.add(ButtonModel("-12%", true, "-12", CalcAction.evalGst));
    buttons.add(ButtonModel("-15%", true, "-15", CalcAction.evalGst));
    buttons.add(ButtonModel("-18%", true, "-18", CalcAction.evalGst));

    // 2nd row
    buttons.add(ButtonModel("GST+3%", true, "+3", CalcAction.evalGst));
    buttons.add(ButtonModel("+5%", true, "+5", CalcAction.evalGst));
    buttons.add(ButtonModel("+12%", true, "+12", CalcAction.evalGst));
    buttons.add(ButtonModel("+15%", true, "+15", CalcAction.evalGst));
    buttons.add(ButtonModel("+18%", true, "+18", CalcAction.evalGst));

    return buttons;
  }
}
