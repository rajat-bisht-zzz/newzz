import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:newzz/app/modules/news/news_controller.dart';

class SettingsScreen extends StatelessWidget {
  final NewsController controller = Get.find<NewsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => SwitchListTile(
                  title: const Text('Dark Mode'),
                  value: controller.isDarkMode.value,
                  onChanged: (value) {
                    controller.toggleTheme();
                  },
                )),
          ],
        ),
      ),
    );
  }
}
