import 'package:flutter/material.dart';
import 'package:flutter_base/model/provider_widget.dart';
import 'package:flutter_base/widget/tabs/tabs_widget.dart';
import 'package:flutter_base_example/page/movie_list_page.dart';

class HomeTabsPage extends StatefulWidget {
  HomeTabsPage({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeTabsPageState();
  }

  @override
  String toStringShort() {
    return '';
  }
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  List<Widget> defaultTabViews = [
    MovieListPage(),
    MovieListPage(),
  ];
  List<TabItem> defaultTabItems = <TabItem>[
    TabItem(text: 'Movie'),
    TabItem(text: 'Movie'),
  ];
  ShapeDecoration _decoration = ShapeDecoration(
    shape: StadiumBorder(
          side: BorderSide(
            color: Colors.white,
            width: 1.5,
          ),
        ) +
        const StadiumBorder(
          side: BorderSide(
            color: Colors.transparent,
            width: 1.5,
          ),
        ),
  );

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildContent(context),
    );
  }

  Widget buildContent(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).padding.top;

    ///轮播图高度
    double _swiperHeight = 200 + 10.0;

    ///提示头部高度
    double _spikeHeight = 80;

    ///_appBarHeight算的是AppBar的bottom高度，kToolbarHeight是APPBar高，statusBarHeight是状态栏高度
    double _appBarHeight =
        _swiperHeight + _spikeHeight - kToolbarHeight - statusBarHeight;

    //return Scaffold(
    //  body: Container(
    //    margin: EdgeInsets.only(top: 0, bottom: 5),
    //    child: CustomScrollView(
    //      slivers: <Widget>[
    //        _bar(context, model),
    //        SliverToBoxAdapter(
    //          child: Container(
    //            width: double.maxFinite,
    //            height: double.maxFinite,
    //            child: _buildBody(context, model),
    //          ),
    //        ),
    //      ],
    //    ),
    //  ),
    //);
    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverOverlapAbsorber(
            handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),

            ///SliverAppBar也可以实现吸附在顶部的TabBar，但是高度不好计算，总是会有AppBar的空白高度，
            ///所以我就用了SliverPersistentHeader来实现这个效果，SliverAppBar的bottom中只放TabBar顶部的布局
            sliver: _bar(context),
          ),

          ///停留在顶部的TabBar
          //SliverPersistentHeader(
          //  delegate: _SliverAppBarDelegate(_timeSelection()),
          //  pinned: true,
          //),
        ];
      },
      body: _buildBody(context),
    );
  }

  Widget _bar(BuildContext context) {
    Widget widget;
    //if (model.getBannerBeans() == null) {
    //  widget = Center(
    //    child: CircularProgressIndicator(),
    //  );
    //} else {
    //  widget = CustomBanner(model.getBannerBeans());
    //}
    return SliverAppBar(
      centerTitle: true,
      expandedHeight: 200.0,
      pinned: true,
      floating: false,
      snap: false,
      primary: true,
      //backgroundColor: Theme.of(context).backgroundColor,
      //backgroundColor: Color(0xFF303030),
      elevation: 10.0,
      forceElevated: true,
      title: Text("a"),
      leading: Icon(Icons.arrow_back),
      iconTheme: IconThemeData(color: Color(0xFFD8D8D8)),
      textTheme:
          TextTheme(title: TextStyle(fontSize: 17.0, color: Color(0xFFFFFFFF))),
      actions: <Widget>[
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.only(top: 17, right: 15.0),
            child: Text("b"),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          width: double.maxFinite,
          height: double.maxFinite,
          child: widget,
        ),
        centerTitle: true,
        collapseMode: CollapseMode.pin,
        stretchModes: [StretchMode.fadeTitle],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return buildDefaultTabs();
  }

  Widget buildDefaultTabs() {
    return TabsWidget(
      tabsViewStyle: TabsViewStyle.noAppbarTopTab,
      tabStyle: TabsStyle.textOnly,
      tabViews: defaultTabViews,
      tabItems: defaultTabItems,
      isScrollable: true,
      customIndicator: true,
      decoration: _decoration,
      backgroundColor: Theme.of(context).accentColor,
      title: Text("干货"),
    );
  }
}
