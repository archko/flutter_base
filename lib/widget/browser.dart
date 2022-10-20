import 'package:flutter/material.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:webview_flutter_plus/webview_flutter_plus.dart';

class Browser extends StatelessWidget {
  static open(
      BuildContext context, String url, String? title, String? waitingTxt) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (_) {
          return Browser(
            url: url,
            title: title,
            waitingTxt: waitingTxt,
          );
        },
      ),
    );
  }

  final String url;
  final String? title;
  final String? waitingTxt;

  const Browser({Key? key, required this.url, this.title, this.waitingTxt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringUtils.isEmpty(title) ? "" : title!),
      ),
      body: WebViewPlus(
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (controller) {
          //controller.loadString(r"""
          // <html lang="en">
          //  <body>Waiting.....</body>
          // </html>
          //""");
          controller.loadUrl(url);
        },
      ),
    );
  }
}
