import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Browser extends StatelessWidget {
  static open(BuildContext context, String url, String title) {
    Navigator.of(context).push(
      new MaterialPageRoute<void>(
        builder: (_) {
          return Browser(
            url: url,
            title: title,
          );
        },
      ),
    );
  }

  final String url;
  final String title;

  const Browser({Key key, this.url, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: WebView(
        initialUrl: url,
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
