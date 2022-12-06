import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../common/app_color.dart';

class WebViewView extends StatelessWidget {
  const WebViewView({
    super.key,
    required this.title,
    required this.initialPath,
  });

  final String title;
  final String initialPath;

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      WebView.platform = AndroidWebView();
    }
    final url = 'https://cajico.herokuapp.com/$initialPath';
    return Scaffold(
      appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black54),
          centerTitle: true,
          title: Text(title, style: const TextStyle(color: gray2)),
          backgroundColor: Colors.white,
          titleTextStyle: const TextStyle(fontSize: 22)),
      body: WebView(initialUrl: url),
    );
  }
}
