import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/cajico_text_form_field.dart';
import 'package:cajico_app/ui/widget/loading_stack.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../common/ui_helper.dart';
import '../controller/house_work_edit_view_controller.dart';
import '../widget/primary_button.dart';

class HouseWorkCreateView extends StatelessWidget {
  HouseWorkCreateView({
    super.key,
    required this.categoryId,
    required this.categoryName,
  });

  final int categoryId;
  final String categoryName;
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HouseWorkEditViewController());
    final houseWorkInfo = controller.houseWorkCreateData;

    return Focus(
      focusNode: focusNode,
      child: GestureDetector(
        onTap: focusNode.requestFocus,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            iconTheme: const IconThemeData(color: Colors.black54),
            centerTitle: true,
            title: const Text('家事の登録', style: TextStyle(color: gray2)),
            backgroundColor: secondaryColor,
            titleTextStyle: const TextStyle(fontSize: 22),
          ),
          body: GetLoadingStack<HouseWorkEditViewController>(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  verticalSpaceLarge,
                  CajicoTextFormField(
                    readOnly: true,
                    initValue: categoryName,
                    label: '家事カテゴリー',
                    filled: true,
                    fillColor: gray8,
                    focusedBorderColor: gray4,
                  ),
                  verticalSpaceMedium,
                  CajicoTextFormField(
                    initValue: '',
                    label: '家事名',
                    onChanged: (value) => houseWorkInfo.houseWorkName.value = value,
                    validator: (value) =>
                        controller.validateInputEditData(value: value, maxLength: 10).message,
                  ),
                  verticalSpaceMedium,
                  CajicoTextFormField(
                    initValue: '',
                    label: '獲得ポイント',
                    suffixText: 'ポイント',
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly],
                    onChanged: (value) => houseWorkInfo.point.value = int.parse(value),
                    validator: (value) =>
                        controller.validateInputPointData(value: value, maxLength: 3).message,
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(16),
            child: Obx(
              () => PrimaryButton(
                label: '登録する',
                isValid: controller.isHouseWorkCreateButtonValid,
                onPressed: () => controller.onTapCreateDialog(houseWorkCategoryId: categoryId),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
