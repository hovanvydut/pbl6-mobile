import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebviewPaymentPage extends StatelessWidget {
  const WebviewPaymentPage({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(),
      url: url,
    );
  }
}
