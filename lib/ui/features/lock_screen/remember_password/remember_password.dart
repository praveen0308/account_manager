import 'package:account_manager/local/secure_storage.dart';
import 'package:account_manager/models/pair.dart';
import 'package:account_manager/res/app_constants.dart';
import 'package:account_manager/ui/features/lock_screen/remember_password/remember_password_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../res/app_colors.dart';
import '../../../../widgets/outlined_text_field.dart';

class RememberPassword extends StatefulWidget {
  const RememberPassword({Key? key}) : super(key: key);

  @override
  State<RememberPassword> createState() => _RememberPasswordState();
}

class _RememberPasswordState extends State<RememberPassword> {
  final TextEditingController _answer = TextEditingController();
  bool isAllowed = true;
  final List<String> _questions = [];
  var _activeQuestion = "";
  List<Pair<String, String>> qNAPairs = [];


  @override
  void initState() {
    _questions.clear();
    _questions.addAll(AppConstants.getQuestions());
    _activeQuestion = _questions[0];
    super.initState();
  }

  bool alreadyExist(String str) {
    bool exist = false;
    for (Pair p in qNAPairs) {
      if (str == p.first) {
        exist = true;
      }
    }
    return exist;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Remember Password"),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Note: Choose questions and answer the questions carefully. It will be necessary to answer the your opt questions.",style: TextStyle(color: Colors.red),),
              const SizedBox(height: 16,),
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
                    items: _questions
                        .map((item) =>
                        DropdownMenuItem<String>(
                          value: item,
                          enabled: !alreadyExist(item),
                          child: Text(
                            item,
                            overflow: TextOverflow.clip,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ))
                        .toList(),
                    value: _activeQuestion,
                    onChanged: (value) {
                      _activeQuestion = value as String;

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
              const Text(
                "Answer",
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
              ),
              OutlinedTextField(
                controller: _answer,
                onTextChanged: (txt) {},
                onSubmitted: (txt) {},
                inputType: TextInputType.text,
                hintText: "Enter answer",
                maxLength: 250,
              ),
              ElevatedButton(
                  onPressed: isAllowed
                      ? () {
                    if (alreadyExist(_activeQuestion)) {
                      showToast("Already exists!!!", ToastType.error);
                    } else {
                      qNAPairs.add(Pair(_activeQuestion, _answer.text));
                      isAllowed = qNAPairs.length < 3;
                      setState(() {});
                    }
                  }
                      : null,
                  child: const Text("Add")),
              ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (_, index) {
                    var qA = qNAPairs[index];
                    return ListTile(
                      title: Text(qA.first),
                      subtitle: Text(qA.second),
                      trailing: IconButton(
                          onPressed: () {
                            qNAPairs.removeAt(index);
                            isAllowed = qNAPairs.length < 3;
                            setState(() {});
                          },
                          icon: const Icon(Icons.close_rounded)),
                    );
                  },
                  separatorBuilder: (_, index) {
                    return const Divider();
                  },
                  itemCount: qNAPairs.length),
              const Spacer(),
              BlocConsumer<RememberPasswordCubit, RememberPasswordState>(
                listener: (context, state) {
                  if(state is SavedSuccessfully){
                    showToast("Saved Successfully!!!", ToastType.success);
                    Navigator.pushReplacementNamed(context, "/notes");
                  }
                },
                builder: (context, state) {
                  if(state is Loading){
                    return const Center(child: CircularProgressIndicator(),);
                  }
                  return ElevatedButton(
                      onPressed: !isAllowed ? () {
                        BlocProvider.of<RememberPasswordCubit>(context).saveQNA(qNAPairs);
                      } : null,
                      child: const Text("Save"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}