import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/primary_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/pair.dart';
import '../../../../res/app_colors.dart';
import 'forgot_password_cubit.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _answer = TextEditingController();
  final List<Pair<String, String>> questions = [];
  Pair<String,String> _activeQuestion = Pair("","");

  @override
  void initState() {
    BlocProvider.of<ForgotPasswordCubit>(context).loadQuestions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text("Forgot Password"),),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
              listener: (context, state) {
                if (state is ReceivedQuestions) {
                  questions.clear();
                  questions.addAll(state.questions);
                  _activeQuestion = questions[0];
                  setState(() {

                  });
                }
              },
              builder: (context, state) {
                if (state is Loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [

                    const Text(
                      "Select 1 of 3 questions",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(
                      height: 24,
                    ),
                    DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          isExpanded: true,
                          hint: Text(
                            'Select Item',
                            style: TextStyle(
                              fontSize: 14,
                              color: Theme
                                  .of(context)
                                  .hintColor,
                            ),
                          ),
                          items: questions
                              .map((item) =>
                              DropdownMenuItem<Pair<String,String>>(
                                value: item,
                                child: Text(
                                  item.first,
                                  overflow: TextOverflow.clip,
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ))
                              .toList(),
                          value: _activeQuestion,
                          onChanged: (value) {
                            _activeQuestion = value as Pair<String,String>;

                            setState(() {});
                          },
                          buttonHeight: 40,
                          itemHeight: 40,
                          buttonPadding: const EdgeInsets.only(left: 14, right: 14),
                          buttonDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border:
                            Border.all(color: AppColors.primaryDarkest, width: 1.5),
                            color: Colors.white,
                          ),
                          dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        )),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _answer,
                      autofocus: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (txt) {
                        var isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          showToast(
                              "You've successfully answered the given question right!!!",
                              ToastType.success);
                          Navigator.pushReplacementNamed(context, "/createPin",arguments: false);
                        }
                      },
                      validator: (txt) {
                        if (txt != _activeQuestion.second) {
                          return "Wrong Answer!!!";
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                          hintText: "Enter answer...", labelText: "Answer"),
                    ),
                    const Spacer(),
                    PrimaryButton(onClick: () {
                      var isValid = _formKey.currentState!.validate();
                      if (isValid) {
                        showToast(
                            "You've successfully answered the given question right!!!",
                            ToastType.success);
                        Navigator.pushReplacementNamed(context, "/createPin",arguments: false);
                      }
                    }, text: "Continue")
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
