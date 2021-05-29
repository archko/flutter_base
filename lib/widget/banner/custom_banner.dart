import 'dart:async';

import 'package:flutter/material.dart';

class BannerBean {
  String imageUrl;
  String title;
  String? action;
  String? extend;

  BannerBean({
    required this.imageUrl,
    required this.title,
    this.action,
    this.extend,
  });

  @override
  String toString() {
    return 'BannerBean{imageUrl: $imageUrl, title: $title, action: $action, extend: $extend}';
  }
}

class CustomBanner extends StatefulWidget {
  final List<BannerBean> banners;
  final double height;
  final ValueChanged<int>? onTap;
  final Curve curve;
  final Widget? indicator;
  final Widget Function(BuildContext context, int index)? itemBuilder;
  final int switchDuration;
  final int animationDuration;

  CustomBanner({
    Key? key,
    required this.banners,
    this.height = 200,
    this.onTap,
    this.curve = Curves.linearToEaseOut,
    this.indicator,
    this.itemBuilder,
    this.switchDuration = 3000,
    this.animationDuration = 1000,
  }) : super(key: key);

  @override
  _CustomBannerState createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  late PageController _pageController;
  int _index = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _index);
    initTimer();
  }

  @override
  void deactivate() {
    super.deactivate();
    print("deactivate");
  }

  @override
  void dispose() {
    super.dispose();
    cancelTimer();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        _buildView(),
        _buildIndicator(),
      ],
    );
  }

  Widget _buildIndicator() {
    var length = widget.banners.length;

    return widget.indicator != null
        ? widget.indicator!
        : Positioned(
            bottom: 10,
            child: Row(
              children: widget.banners.map((s) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: s == widget.banners[_index % length]
                            ? Colors.white
                            : Colors.green,
                        //gradient: s == widget._images[_index % length]
                        //    ? LinearGradient(
                        //        colors: [Colors.white, Colors.white])
                        //    : LinearGradient(
                        //        colors: [Colors.green, Colors.green]), //背景渐变
                        borderRadius: BorderRadius.circular(3.0),
                        //3像素圆角
                        boxShadow: [
                          //阴影
                          BoxShadow(
                              color: Colors.black54,
                              offset: Offset(1.0, 1.0),
                              blurRadius: 1.0)
                        ]),
                    width: 12,
                    height: 4,
                  ),
                );
              }).toList(),
            ),
          );
  }

  Widget _buildView() {
    var length = widget.banners.length;
    if (length == 0) {
      return Container(
        height: widget.height,
        alignment: Alignment.center,
        child: Text("loading..."),
      );
    }
    return Container(
      height: widget.height,
      child: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _index = index;
            if (index == 0) {
              _index = length;
              _switchPage();
            }
          });
        },
        itemBuilder: widget.itemBuilder != null
            ? widget.itemBuilder!
            : (context, index) {
                return GestureDetector(
                  onPanDown: (details) {
                    cancelTimer();
                    initTimer();
                  },
                  onTap: () {
                    if (null != widget.onTap) {
                      widget.onTap!(index);
                    }
                  },
                  child: Image.network(
                    widget.banners[index % length].imageUrl,
                    fit: BoxFit.cover,
                  ),
                );
              },
      ),
    );
  }

  cancelTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
  }

  initTimer() {
    if (_timer == null) {
      _timer =
          Timer.periodic(Duration(milliseconds: widget.switchDuration), (t) {
        _index++;
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            _index,
            duration: Duration(milliseconds: widget.animationDuration),
            curve: widget.curve,
          );
        }
      });
    }
  }

  _switchPage() {
    Timer(Duration(milliseconds: widget.animationDuration), () {
      _pageController.jumpToPage(_index);
    });
  }
}
