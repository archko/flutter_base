import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

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
      //body: WebView(
      //  initialUrl: url,
      //  javascriptMode: JavascriptMode.unrestricted,
      //),
      body: WebviewScaffold(
        url: url,
        withZoom: true,
        withLocalStorage: true,
        hidden: true,
        initialChild: Container(
          color: Colors.greenAccent,
          child: const Center(
            child: Text('Waiting.....'),
          ),
        ),
      ),
    );
  }
}
