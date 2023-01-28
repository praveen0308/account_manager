import 'package:account_manager/local/app_storage.dart';
import 'package:account_manager/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';

import '../../../../local/secure_storage.dart';
import '../../../../widgets/numeric_keyboard_view.dart';

class PinAuthenticationScreen extends StatefulWidget {
  const PinAuthenticationScreen({Key? key}) : super(key: key);

  @override
  State<PinAuthenticationScreen> createState() => _PinAuthenticationScreenState();
}

class _PinAuthenticationScreenState extends State<PinAuthenticationScreen> {
  final TextEditingController _pin = TextEditingController();
  late String originalPin = "";
  final SecureStorage _secureStorage =SecureStorage();

  @override
  void initState() {
    _secureStorage.getPin().then((value) {
      originalPin = value.toString();
    });
    super.initState();
  }


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

            const Text("Enter Pin",style: TextStyle(fontSize: 22,fontWeight: FontWeight.w600),),
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
              validator: (s) {
                if(s != originalPin){
                  _pin.clear();
                }
                return s == originalPin ? null : 'Pin is incorrect';
              },
              pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
              showCursor: true,
              onCompleted: (pin){
                if(pin==originalPin){
                 Navigator.pushReplacementNamed(context, "/notes");
                }
              },

            ),

            const Spacer(),
            NumericKeyboardView(onTap: (String char) {
              if(char=="⌫"){
                _pin.delete();
              }
              else{
                _pin.append(char,4);

              }

            }, isEnterEnabled: false,),
            const SizedBox(height: 32,)
          ],
        ),
      ),
    ));
  }


}
