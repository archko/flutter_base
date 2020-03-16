import 'package:flutter/material.dart';

enum TabsStyle { iconsAndText, iconsOnly, textOnly }

class TabItem {
  const TabItem({this.icon, this.text});

  final IconData icon;
  final String text;
}

class TabsWidget extends StatefulWidget {
  static const int BOTTOM_TAB = 1;
  static const int TOP_TAB = 2;

  final int type;
  final TabController tabController;
  final TabsStyle tabStyle;

  final bool showAppBar;
  final bool customIndicator;
  final Widget title;
  final List<Widget> tabViews;
  final List<TabItem> tabItems;
  final List<Widget> tabWidgets;

  final bool isScrollable;
  final Color backgroundColor;
  final Color indicatorColor;
  final Color labelColor;
  final Color unselectedLabelColor;
  final Decoration decoration;

  TabsWidget({
    Key key,
    this.type = TOP_TAB,
    this.tabController,
    this.tabViews,
    this.title,
    this.tabItems,
    this.tabWidgets,
    this.tabStyle = TabsStyle.textOnly,
    this.showAppBar = true,
    this.customIndicator = false,
    this.isScrollable = false,
    this.backgroundColor = Colors.black54,
    this.indicatorColor = Colors.white,
    this.labelColor = Colors.white,
    this.unselectedLabelColor = Colors.black,
    this.decoration,
  }) : super(key: key);

  @override
  TabsWidgetState createState() => TabsWidgetState(
        type,
        title,
        tabViews,
        showAppBar,
        customIndicator,
        tabItems,
        tabWidgets,
        tabStyle,
        tabController,
        isScrollable,
        backgroundColor,
        indicatorColor,
        labelColor,
        unselectedLabelColor,
        decoration,
      );
}

class TabsWidgetState extends State<TabsWidget>
    with SingleTickerProviderStateMixin {
  final int _type;
  TabController tabController;
  TabsStyle tabStyle;

  bool showAppBar;
  bool customIndicator;

  final Widget _title;
  final List<Widget> _tabViews;
  final List<TabItem> tabItems;
  final List<Widget> tabWidgets;
  bool isScrollable;

  Color backgroundColor;
  Color indicatorColor;
  Color labelColor;
  Color unselectedLabelColor;
  final Decoration decoration;

  TabsWidgetState(
    this._type,
    this._title,
    this._tabViews,
    this.showAppBar,
    this.customIndicator,
    this.tabItems,
    this.tabWidgets,
    this.tabStyle,
    this.tabController,
    this.isScrollable,
    this.backgroundColor,
    this.indicatorColor,
    this.labelColor,
    this.unselectedLabelColor,
    this.decoration,
  ) : super() {
    assert(tabItems != null || tabWidgets != null);
    assert(_tabViews != null);

    if (null == tabController) {
      tabController = TabController(
          vsync: this,
          length: tabWidgets != null ? tabWidgets.length : tabItems.length);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tabController?.dispose();
    super.dispose();
  }

  void changeDemoStyle(TabsStyle style) {
    setState(() {
      tabStyle = style;
    });
  }

  Decoration getIndicator() {
    if (!customIndicator)
      return UnderlineTabIndicator(
          borderSide: BorderSide(width: 2.0, color: indicatorColor));

    return decoration != null
        ? decoration
        : ShapeDecoration(
            shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  side: BorderSide(
                    color: indicatorColor,
                    width: 2.0,
                  ),
                ) +
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  side: BorderSide(
                    color: Colors.transparent,
                    width: 4.0,
                  ),
                ),
          );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs = tabWidgets != null
        ? tabWidgets
        : tabItems.map<Tab>((TabItem page) {
            assert(tabStyle != null);
            switch (tabStyle) {
              case TabsStyle.iconsAndText:
                return Tab(text: page.text, icon: Icon(page.icon));
              case TabsStyle.iconsOnly:
                return Tab(icon: Icon(page.icon));
              case TabsStyle.textOnly:
                return Tab(text: page.text);
            }
            return Tab(text: "Title");
          }).toList();
    TabBar tabBar = TabBar(
      controller: tabController,
      isScrollable: isScrollable,
      indicator: getIndicator(),
      tabs: tabs,
      labelColor: labelColor,
      unselectedLabelColor: unselectedLabelColor,
      //labelStyle: TextStyle(fontSize: 17),
      //unselectedLabelStyle: TextStyle(fontSize: 15),
    );
    if (showAppBar) {
      if (this._type == TabsWidget.TOP_TAB) {
        return Scaffold(
          appBar: AppBar(
            title: _title,
            bottom: tabBar,
          ),
          body: TabBarView(
            controller: tabController,
            children: _tabViews,
          ),
        );
      } else {
        return Scaffold(
          appBar: AppBar(
            title: _title,
          ),

          ///页面主体，PageView，用于承载Tab对应的页面
          body: TabBarView(
            controller: tabController,
            children: _tabViews,
          ),

          ///底部导航栏，也就是tab栏
          bottomNavigationBar: Material(
            color: backgroundColor,

            ///tabBar控件
            child: tabBar,
          ),
        );
      }
    } else {
      if (this._type == TabsWidget.TOP_TAB) {
        return Scaffold(
          body: TabBarView(
            controller: tabController,
            children: _tabViews,
          ),
        );
      } else {
        return Scaffold(
          body: TabBarView(
            controller: tabController,
            children: _tabViews,
          ),
          bottomNavigationBar: Material(
            color: backgroundColor,
            child: tabBar,
          ),
        );
      }
    }
  }
}