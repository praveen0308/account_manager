import 'package:account_manager/models/feedback_model.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'feedback_form_cubit.dart';

class FeedbackForm extends StatefulWidget {
  const FeedbackForm({Key? key}) : super(key: key);

  @override
  State<FeedbackForm> createState() => _FeedbackFormState();
}

class _FeedbackFormState extends State<FeedbackForm> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  // TextField Controllers
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileNoController = TextEditingController();
  TextEditingController feedbackController = TextEditingController();

  // Method to Submit Feedback and save it in Google Sheets
  void _submitForm() {
    // Validate returns true if the form is valid, or false
    // otherwise.
    if (_formKey.currentState!.validate()) {
      // If the form is valid, proceed.
      FeedbackModel feedbackModel = FeedbackModel(
          nameController.text,
          emailController.text,
          mobileNoController.text,
          feedbackController.text);
      BlocProvider.of<FeedbackFormCubit>(context).submitFeedback(feedbackModel);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Feedback"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(

          children: <Widget>[
            BlocListener<FeedbackFormCubit, FeedbackFormState>(
              listener: (context, state) {
                if (state is SubmittedSuccessfully) {
                  showToast("Feedback Submitted", ToastType.success);
                  Navigator.pop(context);
                }
                if (state is Error) {
                  showToast(state.msg, ToastType.error);
                }
              },
              child: Form(
                  key: _formKey,
                  child:
                  Padding(padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Valid Name';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              labelText: 'Name'
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value == null || !value.contains("@")) {
                              return 'Enter Valid Email';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                              labelText: 'Email'
                          ),
                        ),
                        TextFormField(
                          controller: mobileNoController,
                          validator: (value) {
                            if (value == null || value
                                .trim()
                                .length != 10) {
                              return 'Enter 10 Digit Mobile Number';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Mobile Number',
                          ),
                        ),
                        TextFormField(
                          controller: feedbackController,
                          maxLines: 100,
                          minLines: 5,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Valid Feedback';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                              labelText: 'Feedback'
                          ),
                        ),
                      ],
                    ),
                  )
              ),
            ),
            const Spacer(),
            BlocBuilder<FeedbackFormCubit, FeedbackFormState>(
              builder: (context, state) {
                if(state is Loading) return const Center(child: CircularProgressIndicator(),);
                return PrimaryButton(
                  onClick: _submitForm,
                  text: 'Submit Feedback',
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
