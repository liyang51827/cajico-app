import 'package:cajico_app/ui/view/reward_view.dart';
import 'package:get/get.dart';
import 'base_view_controller.dart';

class HomeViewController extends BaseViewController {

  void toReward() {
    Get.to(const RewardView());
  }
}
