import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherController extends GetxController {
  final String gmail = 'jahangirad14@gmail.com';
  final String phoneNumber = '01796196500'; // With country code
  final String whatsappNumber = '01796196500'; // No '+'

  Future<void> launchGmail() async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: gmail,
    );
    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      Get.snackbar("Error", "Could not open Gmail");
    }
  }

  Future<void> launchPhone() async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    } else {
      Get.snackbar("Error", "Could not open Phone dialer");
    }
  }

  Future<void> launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse("https://wa.me/$whatsappNumber");
    if (await canLaunchUrl(whatsappUri)) {
      await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar("Error", "Could not open WhatsApp");
    }
  }
}
