import 'package:account_manager/models/feedback_model.dart';
import 'package:account_manager/ui/features/feedback/feedback_controller.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'dart:convert' as convert;
import 'package:account_manager/models/feedback_model.dart';
import 'package:http/http.dart' as http;

part 'feedback_form_state.dart';

class FeedbackFormCubit extends Cubit<FeedbackFormState> {
  FeedbackFormCubit() : super(FeedbackFormInitial());
  FormController formController = FormController();

  static const String URL =
      "https://script.google.com/macros/s/AKfycbx81hCiTHJaVVHgzlp5KDSysulF4YdINgOcUdXsolPnIe5SsSzfPDc1OOnTlkO-q9h7IQ/exec";
  static const STATUS_SUCCESS = "SUCCESS";

  Future<void> submitFeedback(FeedbackModel feedbackModel)async{

    emit(Loading());
    /*try{
      formController.submitForm(feedbackModel, (String response) {
        print("Response: $response");
        if (response == FormController.STATUS_SUCCESS) {
          emit(SubmittedSuccessfully());

        } else {
          emit(Error("Error Occurred!"));

        }
      });
    }catch(e){
      emit(Error("Something went wrong!!!"));
    }
*/
    try {
      await http
          .post(Uri.parse(URL), body: feedbackModel.toJson())
          .then((response) async {
        if (response.statusCode == 302) {
          emit(SubmittedSuccessfully());
        } else {
          debugPrint("Response >> ${response.body}");
          emit(Error("Error Occurred!"));
        }
      });
    } catch (e) {
      debugPrint(e.toString());
      emit(Error("Something went wrong!!!"));
    }
  }
}
