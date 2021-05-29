import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TitleBar {
  static PreferredSizeWidget simpleTitleBar(String title) {
    return PreferredSize(
      child: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      preferredSize: Size.fromHeight(48),
    );
  }
}
