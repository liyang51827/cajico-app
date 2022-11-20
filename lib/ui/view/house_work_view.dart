import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/notification.dart';
import 'package:flutter/material.dart';

class HouseWorkView extends StatelessWidget {
  const HouseWorkView({
    super.key,
    required this.categoryName
  });
  final String categoryName;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black54),
          centerTitle: true,
          title: Text(categoryName),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(
              color: gray2,
              fontSize: 22
          ),
          actions: const [
            NotificationAction(),
          ],
        ),
      ),
    );
  }
}
