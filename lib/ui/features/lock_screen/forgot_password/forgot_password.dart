import 'package:account_manager/local/secure_storage.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/pair.dart';
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
  int activeQ = 0;

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

                    Text(
                      "Question No. ${activeQ+1}",
                      style:
                          const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                    ),

                    const SizedBox(
                      height: 24,
                    ),
                    Text(
                      questions.isEmpty ? "NA" : questions[activeQ].first,
                      style:
                          const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      controller: _answer,
                      autofocus: true,
                      textInputAction:
                          activeQ == 2 ? TextInputAction.done : TextInputAction.next,
                      onFieldSubmitted: (txt) {
                        var isValid = _formKey.currentState!.validate();
                        if (isValid) {
                          activeQ++;
                          setState(() {

                          });
                        }
                        if (activeQ > 2) {
                          showToast(
                              "You've successfully answered all 3 questions right!!!",
                              ToastType.success);
                          Navigator.pushReplacementNamed(context, "/createPin",arguments: false);
                        }
                      },
                      validator: (txt) {
                        if (txt != questions[activeQ].second) {
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
                        activeQ++;
                      }
                      if (activeQ > 2) {
                        showToast(
                            "You've successfully answered all 3 questions right!!!",
                            ToastType.success);
                        Navigator.pushReplacementNamed(context, "/createPin");
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
