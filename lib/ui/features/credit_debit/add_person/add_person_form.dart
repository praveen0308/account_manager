import 'package:account_manager/models/person_model.dart';
import 'package:account_manager/models/wallet_model.dart';
import 'package:account_manager/res/app_constants.dart';
import 'package:account_manager/ui/features/credit_debit/add_person/add_person_cubit.dart';
import 'package:account_manager/ui/features/credit_debit/credit_debit_cubit.dart';
import 'package:account_manager/utils/toaster.dart';
import 'package:account_manager/widgets/custom_dropdown.dart';
import 'package:account_manager/widgets/outlined_text_field.dart';
import 'package:account_manager/widgets/secondary_button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttercontactpicker/fluttercontactpicker.dart';

import '../../../../res/app_colors.dart';
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
  int _walletId = 1;

  final List<WalletModel> _wallets = AppConstants.getWallets();

  var _activeWallet = "Business 1";
  int getActiveWalletId(){
    if(_activeWallet == "Business 1"){return 1;}
    if(_activeWallet == "Business 2"){return 2;}
    else{return 3;}

  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPersonCubit, AddPersonState>(
      listener: (context, state) {
        if (state is AddedSuccessfully) {
          _txtNameController.text = "";
          _txtMobileNoController.text = "";
          BlocProvider.of<CreditDebitCubit>(context).fetchPersons();
          ScaffoldMessenger.of(context)
              .showToast("Added successfully!!!", ToastType.success);
          Navigator.pop(context, true);
        }
        if (state is Failed) {
          ScaffoldMessenger.of(context)
              .showToast("Already exists!!!", ToastType.error);
        }
      },
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
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
              DropdownButtonHideUnderline(
                  child: DropdownButton2(
                hint: Text(
                  'Select Item',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: _wallets
                    .map((item) => DropdownMenuItem<String>(
                          value: item.name,
                          child: Text(
                            item.name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ))
                    .toList(),
                value: _activeWallet,
                onChanged: (value) {
                  _activeWallet = value as String;
                  _walletId = getActiveWalletId();
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
                      maxLength: 20,
                      hintText: "Mobile Number",
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        final PhoneContact contact =
                            await FlutterContactPicker.pickPhoneContact(
                                askForPermission: true);

                        // Contact? contact = await _contactPicker.selectContact();

                        setState(() {
                          _contact = contact;
                        });

                        _txtNameController.text = _contact.fullName.toString();
                        var mobileNumber = _contact.phoneNumber!.number.toString();

                        mobileNumber = mobileNumber.replaceAll(RegExp(r"\D"), "");
                        if(mobileNumber.length>10){
                          mobileNumber = mobileNumber.substring(mobileNumber.length - 10);
                        }
                        _txtMobileNoController.text = mobileNumber;
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
                            Navigator.pop(context, false);
                          },
                          text: "Cancel")),
                  const SizedBox(width: 8),
                  Expanded(
                      child: PrimaryButton(
                          onClick: () {
                            String name = _txtNameController.text;
                            String mobileNo = _txtMobileNoController.text;

                            if (name.isNotEmpty && mobileNo.isNotEmpty) {
                              setState(() {
                                isValid = true;
                              });

                              BlocProvider.of<AddPersonCubit>(context)
                                  .addNewPerson(PersonModel(
                                      name: name,
                                      mobileNumber: mobileNo,
                                      walletId: _walletId));
                            } else {
                              setState(() {
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
