import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/loading_state.dart';
import '../controller/base_view_controller.dart';

class LoadingStack extends StatelessWidget {
  const LoadingStack({
    this.child,
    required this.isLoading,
    super.key,
  });

  final Widget? child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final widgets = <Widget>[
      child ?? const SizedBox(),
    ];

    if (isLoading) {
      widgets.add(Container(
        color: Colors.white.withOpacity(0.5),
        constraints: const BoxConstraints.expand(),
        child: const Center(
          child: CircularProgressIndicator(color: primaryColor),
        ),
      ));
    }

    return Stack(
      children: widgets,
    );
  }
}

class GetLoadingStack<T extends BaseViewController> extends GetView<T> {
  const GetLoadingStack({
    this.child,
    super.key,
  });

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => LoadingStack(
        isLoading: controller.loadingState.value is LoadingInProgress,
        child: child,
      ),
    );
  }
}
