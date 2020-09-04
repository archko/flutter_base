import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_base/widget/dialog/dialog_item.dart';
import 'package:flutter_base/widget/appbar/title_bar.dart';

class TestApp extends StatefulWidget {
  const TestApp({
    Key key,
  }) : super(key: key);

  @override
  _TestAppState createState() => _TestAppState();
}

class _TestAppState extends State<TestApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        appBar: TitleBar.simpleTitleBar("test"),
        body: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  ProgressDialog.showProgress(context);
                },
                child: Text("progress dialog"),
              ),
              RaisedButton(
                onPressed: () {
                  showDialogItems(context);
                },
                child: Text("dialog item"),
              ),
              RaisedButton(
                onPressed: () {
                  modeBottomDialog(context);
                },
                child: Text("modeBottomDialog"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDialogItems(BuildContext context) {
    final theme = Theme.of(context);
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext c) {
        return SimpleDialog(
          title: Text("照片"),
          children: <Widget>[
            DialogItem(
              icon: Icons.camera,
              color: theme.colorScheme.primary,
              text: "拍照",
              onPressed: () {},
            ),
            DialogItem(
              icon: Icons.photo_album,
              color: theme.colorScheme.primary,
              text: "相册",
              onPressed: () {},
            ),
            DialogItem(
              icon: Icons.close,
              color: theme.colorScheme.primary,
              text: "取消",
            ),
            DialogItem(
              color: theme.colorScheme.primary,
              text: "取消",
            ),
          ],
          elevation: 10,
          semanticLabel: "AlertDialog",
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        );
      },
    );
  }

  Future modeBottomDialog(BuildContext context) async {
    var result = await showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DialogItem(
                  text: "分享到 QQ",
                  onPressed: () {
                    print("分享到 QQ");
                  },
                ),
                DialogItem(
                  text: "分享到 微信",
                  onPressed: () {
                    print("分享到 QQ");
                  },
                ),
                DialogItem(
                  text: "分享到 微博",
                  onPressed: () {
                    print("分享到 微博");
                  },
                ),
                SizedBox(width: 0,height: 40,),
              ],
            ),
          );
        });
    return result;
  }
}
