import 'package:account_manager/local/secure_storage.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../widgets/numeric_keyboard_view.dart';

class CreatePin extends StatefulWidget {
  const CreatePin({Key? key}) : super(key: key);

  @override
  State<CreatePin> createState() => _CreatePinState();
}

class _CreatePinState extends State<CreatePin> {
  final TextEditingController _pin = TextEditingController();
  String _savedPin = "";
  String _tempPin = "";
  final SecureStorage _secureStorage = SecureStorage();
  @override
  Widget build(BuildContext context) {

    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle:const TextStyle(fontSize: 20, color: AppColors.primaryDarkest, fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primary),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.primaryDarkest),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: AppColors.primaryLightest,
      ),
    );
    return SafeArea(child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            const Spacer(),

            Text(_savedPin.isEmpty?"Create Pin":"Re-enter Pin",style: const TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
            const SizedBox(height: 24,),
            const Spacer(),
            Pinput(
              controller: _pin,
              keyboardType: TextInputType.none,
              obscureText: true,
              obscuringCharacter: "*",
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              crossAxisAlignment: CrossAxisAlignment.center,
              /*validator: (s) {
                return s == '2222' ? null : 'Pin is incorrect';
              },*/
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin){
                _tempPin = pin;
              },

            ),
            const Spacer(),
            NumericKeyboardView(onTap: (String char) {
              if(char=="⌫"){
                _pin.delete();
              }
              else if(char=="OK"){
                if(_savedPin.isNotEmpty){
                  // second time
                  _secureStorage.savePin(_savedPin).then((value) => Navigator.pushReplacementNamed(context, "/notes"));
                }else{
                  _savedPin = _tempPin;
                }

                _tempPin = "";
                _pin.text = "";

                setState((){});
              }
              else{
                _pin.append(char,4);

              }

            }, isEnterEnabled: true,),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    ));
  }


}



