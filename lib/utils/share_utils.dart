import 'package:url_launcher/url_launcher.dart';

class ShareUtil{
  static launchWhatsapp(String msg) async {
    var whatsappAndroid =Uri.parse("whatsapp://send?text=$msg");
    await launchUrl(whatsappAndroid);

  }
  static launchWhatsapp1(String msg,String mobileNumber) async {
    var whatsappAndroid =Uri.parse("whatsapp://send?phone=+91$mobileNumber&text=$msg");
    await launchUrl(whatsappAndroid);

  }
}