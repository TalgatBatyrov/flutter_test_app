import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreen extends StatefulWidget {
  final String url;

  const WebViewScreen(this.url, {super.key});

  @override
  State<WebViewScreen> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewScreen> {
  late final WebViewController controller;

  @override
  void initState() {
    print('url: ${widget.url}');
    super.initState();

    controller = WebViewController()
      ..loadRequest(
        Uri.parse(widget.url),
      );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: WebViewWidget(
          controller: controller,
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (await controller.canGoBack()) {
      controller.goBack();
      return false;
    } else {
      return true;
    }
  }
}
