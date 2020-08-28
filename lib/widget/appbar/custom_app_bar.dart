import 'package:flutter/material.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  bool isDefault = true;
  final double height;
  final Color backgroundColor;
  final String title;
  Widget child;

  CustomAppBar({
    this.child,
    this.backgroundColor,
    this.title,
    this.height = 48,
  }) {
    if (child == null) {
      Widget titleWidget = Container(
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      );
      Widget back = Container(
        alignment: Alignment.centerLeft,
        child: BackButton(),
      );
      child = Stack(
        children: <Widget>[
          titleWidget,
          back,
        ],
      );
    } else {
      isDefault = false;
    }
  }

  @override
  State<StatefulWidget> createState() {
    return _CustomAppBarState();
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    if (widget.isDefault) {
      return SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          height: widget.height,
          color: widget.backgroundColor,
          child: widget.child,
        ),
      );
    } else {
      return SafeArea(
        top: true,
        child: Container(
          width: double.infinity,
          color: widget.backgroundColor,
          child: widget.child,
        ),
      );
    }
  }
}
