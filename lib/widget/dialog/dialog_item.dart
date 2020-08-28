import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DialogItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;
  final VoidCallback onPressed;

  const DialogItem({Key key, this.icon, this.color, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialogOption(
      onPressed: () {
        if (onPressed != null) {
          onPressed.call();
        }
        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            icon,
            size: 36,
            color: color,
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsetsDirectional.only(start: 16),
              child: Text(text),
            ),
          )
        ],
      ),
    );
  }
}

///加载弹框
class ProgressDialog {
  static bool _isShowing = false;

  static Widget progressChild({String text = "加载中"}) {
    return Container(
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        color: Color(0xBA000000),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.blue),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 11),
            ),
          ),
        ],
      ),
    );
  }

  ///展示
  static void showProgress(
    BuildContext context, {
    Widget child = const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation(Colors.blue),
    ),
  }) {
    if (!_isShowing) {
      _isShowing = true;
      Navigator.push(
        context,
        _PopRoute(
          child: _ProgressWidget(
            child: child,
          ),
        ),
      );
    }
  }

  ///隐藏
  static void dismiss(BuildContext context) {
    if (_isShowing) {
      Navigator.of(context).pop();
    }
    _isShowing = false;
  }
}

///Widget
class _ProgressWidget extends StatelessWidget {
  final Widget child;

  _ProgressWidget({Key key, @required this.child})
      : assert(child != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Center(
        child: child,
      ),
    );
  }
}

///Route
class _PopRoute extends PopupRoute {
  final Duration _duration = Duration(milliseconds: 300);
  Widget child;

  _PopRoute({@required this.child});

  @override
  Color get barrierColor => null;

  @override
  bool get barrierDismissible => true;

  @override
  String get barrierLabel => null;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return child;
  }

  @override
  Duration get transitionDuration => _duration;

  @override
  void dispose() {
    super.dispose();
    ProgressDialog._isShowing = false; //这里不设置,再也弹不出来了.
  }
}
