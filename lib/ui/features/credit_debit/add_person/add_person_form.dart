import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/ui/features/credit_debit/add_person/add_person_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/outlined_text_field.dart';
import 'package:account_manager/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

import '../../../../widgets/primary_button.dart';

class AddPersonForm extends StatefulWidget {
  const AddPersonForm({Key? key}) : super(key: key);

  @override
  State<AddPersonForm> createState() => _AddPersonFormState();
}

class _AddPersonFormState extends State<AddPersonForm> {
  final TextEditingController _txtNameController = TextEditingController();
  final TextEditingController _txtMobileNoController = TextEditingController();
  // final FlutterContactPicker _contactPicker = FlutterContactPicker();
  late PhoneContact _contact;

  bool isValid = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPersonCubit, AddPersonState>(
      listener: (context,state){
        if(state is AddedSuccessfully){
          _txtNameController.text = "";
          _txtMobileNoController.text = "";
          BlocProvider.of<CreditDebitCubit>(context).fetchPersons();
          ScaffoldMessenger.of(context).showToast("Added successfully!!!",ToastType.success);
          Navigator.pop(context,true);
        }
      },

      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 350,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              Text(
                "Add Person".toUpperCase(),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 16),
              OutlinedTextField(
                  controller: _txtNameController,
                  onTextChanged: (txt) {},
                  onSubmitted: (txt) {},
                  inputType: TextInputType.text,
                  maxLength: 100,
                  hintText: "Person Name"),
              Row(
                children: [
                  Expanded(
                    child: OutlinedTextField(
                      controller: _txtMobileNoController,
                      onTextChanged: (txt) {},
                      onSubmitted: (txt) {},
                      inputType: TextInputType.number,
                      maxLength: 12,
                      hintText: "Mobile Number",
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        final PhoneContact contact = await FlutterContactPicker.pickPhoneContact(askForPermission: true);

                        // Contact? contact = await _contactPicker.selectContact();
                        setState(() {
                          _contact = contact;
                        });

                        _txtNameController.text =
                            _contact.fullName.toString();
                        _txtMobileNoController.text =
                            _contact.phoneNumber!.number.toString();
                      },
                      icon: const Icon(Icons.contacts_rounded))
                ],
              ),
              Visibility(
                  visible: !isValid,
                  child: const Text(
                    "Invalid data !!!",
                    style: TextStyle(color: Colors.red),
                  )),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                      child: SecondaryButton(
                          onClick: () {
                            Navigator.pop(context,false);
                          },
                          text: "Cancel")),
                  const SizedBox(width: 8),
                  Expanded(
                      child: PrimaryButton(
                          onClick: () {
                            String name = _txtNameController.text;
                            String mobileNo = _txtMobileNoController.text;

                            if (name.isNotEmpty && mobileNo.isNotEmpty) {
                              setState((){
                                isValid = true;
                              });

                              BlocProvider.of<AddPersonCubit>(context).addNewPerson(PersonModel(
                                name: name,
                                mobileNumber: mobileNo
                              ));
                            }else{
                              setState((){
                                isValid = false;
                              });
                            }
                          },
                          text: "Save"))
                ],
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        );
      },
    );
  }
}
