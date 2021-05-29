import 'package:flutter/material.dart';
import 'package:flutter_base/utils/string_utils.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class Browser extends StatelessWidget {
  static open(BuildContext context, String url,
      {required String title, String? waitingTxt}) {
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
  final String title;
  final String? waitingTxt;

  const Browser(
      {Key? key, required this.url, required this.title, this.waitingTxt})
      : super(key: key);

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
          color: Colors.white10,
          child: Center(
            child: Text(waitingTxt != null ? waitingTxt! : 'Waiting.....'),
          ),
        ),
      ),
    );
  }
}
