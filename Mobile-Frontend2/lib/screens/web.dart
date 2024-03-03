import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'package:algorithm/utilities/constants.dart';

// ignore: must_be_immutable
class WebScreen extends StatefulWidget {
  String url;

  WebScreen({Key? key, this.url = ''}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  double progress = 0;

  WebViewController? controller;

  @override
  void initState() {
    super.initState();
    if (!widget.url.contains("https://")) {
      setState(() {
        widget.url = "https://${widget.url}";
      });
    }

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              this.progress = progress / 100;
            });
          },
        ),
      )
      ..enableZoom(false)
      ..setBackgroundColor(Colors.white)
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.url),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
          iconSize: 30,
        ),
      ),
      body: Column(children: [
        LinearProgressIndicator(
          value: progress,
          backgroundColor: Colors.white,
          valueColor: const AlwaysStoppedAnimation<Color>(Constants.orange),
          minHeight: 1,
        ),
        Expanded(child: WebViewWidget(controller: controller!)),
      ]),
    );
  }
}
