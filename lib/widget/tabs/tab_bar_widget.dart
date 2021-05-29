import 'package:flutter/material.dart';
import 'package:flutter_base/widget/tabs/gsy_tab_bar_widget.dart';

typedef TabClick = void Function(int index, String name);

class TabBarPageWidget extends StatefulWidget {
  final String? title;
  final List<Widget> tabViews;
  final TabClick? tabClick;

  const TabBarPageWidget(
      {Key? key, this.title, required this.tabViews, this.tabClick})
      : super(key: key);

  @override
  _TabBarPageWidgetState createState() => _TabBarPageWidgetState();
}

class _TabBarPageWidgetState extends State<TabBarPageWidget> {
  final PageController pageControl = new PageController();

  _renderTab() {
    List<Widget> list = new List.empty();
    for (int i = 0; i < widget.tabViews.length; i++) {
      list.add(FlatButton(
          onPressed: () {
            pageControl.jumpTo(MediaQuery.of(context).size.width * i);
            if (widget.tabClick != null) {
              widget.tabClick!(i, widget.tabViews[i].toStringShort());
            }
          },
          child: Text(
            widget.tabViews[i].toStringShort(),
            style: TextStyle(color: Colors.white),
            maxLines: 1,
          )));
    }
    return list;
  }

  _renderPage() {
    return widget.tabViews;
  }

  @override
  Widget build(BuildContext context) {
    return new GSYTabBarWidget(
        type: GSYTabBarWidget.TOP_TAB,
        tabItems: _renderTab(),
        tabViews: _renderPage(),
        pageControl: pageControl,
        indicatorColor: Colors.white,
        title: new Text(widget.title == null ? "" : widget.title!));
  }
}
