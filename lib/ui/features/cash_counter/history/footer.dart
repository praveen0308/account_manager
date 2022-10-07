import 'package:account_manager/res/text_styles.dart';
import 'package:account_manager/ui/features/cash_counter/history/cc_history_cubit.dart';
import 'package:account_manager/ui/features/cash_counter/history/cc_history_cubit.dart';
import 'package:account_manager/widgets/footer_container.dart';
import 'package:account_manager/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../../../../res/app_colors.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  State<Footer> createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  double grandTotal = 0.0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CcHistoryCubit, CcHistoryState>(
      listener: (context, state) {
        if (state is ReceivedHistory) {
          setState(() {
            grandTotal = state.grandTotal;
          });
        }
      },
      listenWhen: (previousState, state) {
        if (state is ReceivedHistory) {
          return true;
        }
        return false;
      },
      child: FooterContainer(
          child: Row(
        children: [
          Column(
            children: [
              Text(
                "Grand Total",
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle1(),
              ),
              Text(
                "₹$grandTotal",
                textAlign: TextAlign.center,
                style: AppTextStyles.headline6(
                    txtColor: AppColors.primaryDarkest, wFont: FontWeight.w800),
              ),
            ],
          ),
          const Spacer(),
          PrimaryButton(onClick: () {
            _launchWhatsapp();
          }, text: "Total Notes")
        ],
      )),
    );
  }

  _launchWhatsapp() async {

    var whatsappAndroid =Uri.parse(  "whatsapp://send?text=Hello World!");
    await launchUrl(whatsappAndroid);
    /*if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }*/
  }

  // ...somewhere in your Flutter app...
  /*launchWhatsApp() async {
    final link = WhatsAppUnilink(
      text: "Hey! I'm inquiring about the apartment listing",
    );
    // Convert the WhatsAppUnilink instance to a string.
    // Use either Dart's string interpolation or the toString() method.
    // The "launch" method is part of "url_launcher".
    await launchUrl(link.text);
  }*/
}
