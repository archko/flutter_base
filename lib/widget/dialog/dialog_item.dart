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
