import 'package:account_manager/features/gst_calculator/gst_calculator_cubit.dart';
import 'package:account_manager/features/gst_calculator/widgets/button_model.dart';
import 'package:account_manager/features/gst_calculator/widgets/buttons.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:account_manager/res/app_strings.dart';
import 'package:account_manager/widgets/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GstCalculator extends StatefulWidget {
  const GstCalculator({Key? key}) : super(key: key);

  @override
  State<GstCalculator> createState() => _GstCalculatorState();
}

class _GstCalculatorState extends State<GstCalculator> {
  late GstCalculatorCubit _cubit;
  List<ButtonModel> calcButtons = [];
  List<ButtonModel> gstButtons = [];
  String subTitle = "";
  String mainTitle = "";

  @override
  void initState() {
    setState(() {
      calcButtons = getCalculatorBtns();
      gstButtons = getGstBtns();
    });
    _cubit = BlocProvider.of<GstCalculatorCubit>(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    const double itemHeight = 180;
    final double itemWidth = size.width / 2;

    const double itemHeight1 = 90;

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.gstCalculator),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(child: BlocBuilder<GstCalculatorCubit, GstCalculatorState>(
              builder: (context, state) {
                if (state is EvaluationPerformed) {
                  mainTitle = state.expression;
                  subTitle = state.answer;
                }

                return Container(
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
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
                      _cubit.performBtnClick(btnModel);
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
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemBuilder: (_, index) {
                  var btnModel = calcButtons[index];
                  return BtnType1(
                    buttonModel: btnModel,
                    onItemClick: () {
                      _cubit.performBtnClick(btnModel);
                    },
                  );
                })
          ],
        ),
      ),
    ));
  }

  List<ButtonModel> getCalculatorBtns() {
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

  List<ButtonModel> getGstBtns() {
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

class MarqueeWidget extends StatefulWidget {
  final Widget child;
  final Axis direction;
  final Duration animationDuration, backDuration, pauseDuration;

  const MarqueeWidget({
    Key? key,
    required this.child,
    this.direction = Axis.horizontal,
    this.animationDuration = const Duration(milliseconds: 6000),
    this.backDuration = const Duration(milliseconds: 800),
    this.pauseDuration = const Duration(milliseconds: 800),
  }) : super(key: key);

  @override
  _MarqueeWidgetState createState() => _MarqueeWidgetState();
}

class _MarqueeWidgetState extends State<MarqueeWidget> {
  late ScrollController scrollController;

  @override
  void initState() {
    scrollController = ScrollController(initialScrollOffset: 50.0);
    WidgetsBinding.instance!.addPostFrameCallback(scroll);
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: widget.child,
      scrollDirection: widget.direction,
      controller: scrollController,
    );
  }

  void scroll(_) async {
    while (scrollController.hasClients) {
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: widget.animationDuration,
          curve: Curves.ease,
        );
      }
      await Future.delayed(widget.pauseDuration);
      if (scrollController.hasClients) {
        await scrollController.animateTo(
          0.0,
          duration: widget.backDuration,
          curve: Curves.easeOut,
        );
      }
    }
  }
}
