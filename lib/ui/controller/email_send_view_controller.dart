import 'package:cajico_app/ui/view/email_sent_view.dart';
import 'package:get/get.dart';
import '../../model/form_validation.dart';
import '../../util/form_validator.dart';
import 'base_view_controller.dart';

class EmailSendViewController extends BaseViewController {
  EmailSendViewController();

  final RxString email = ''.obs;

  FormValidation validateInputEmailData(String? value) => FormValidator.validateRequireEmail(value);

  bool get isSendButtonValid => validateInputEmailData(email()).isValid;

  Future<void> onTapSendEmail({required type}) async {
    var result = false;
    await callAsyncApi(() async {
      if (type == 'invite') {
        result = await api.sendInvitationEmail(email: email(), type: type);
      } else {
        result = await api.sendEmail(email: email(), type: type);
      }
    });
    if (result) {
      email.value = '';
      Get.to(EmailSentView(type: type));
    }
  }
}
