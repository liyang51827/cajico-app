import 'package:cajico_app/ui/common/app_color.dart';
import 'package:flutter/material.dart';
import '../widget/background.dart';
import '../widget/footer.dart';
import '../widget/header.dart';
import '../widget/home_drawer.dart';

class ScheduleView extends StatelessWidget {
  const ScheduleView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray7,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(55),
        child: Header(
          imageUrl: 'assets/images/logo_schedule.png',
          title: 'スケジュール',
        ),
      ),
      drawer: const HomeDrawer(),
      body: Background(
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            child: Column(
              children: const [],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const Footer(),
    );
  }
}
