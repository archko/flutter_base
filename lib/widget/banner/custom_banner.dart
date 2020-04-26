import 'dart:async';

import 'package:flutter/material.dart';

class BannerBean {
  String imageUrl;
  String title;

  BannerBean({
    this.imageUrl,
    this.title,
  });

  @override
  String toString() {
    return 'BannerBean{imageUrl: $imageUrl, title: $title}';
  }
}

class CustomBanner extends StatefulWidget {
  final List<BannerBean> _images;
  final double height;
  final ValueChanged<int> onTap;
  final Curve curve;
  final Widget indicator;

  CustomBanner(
    this._images, {
    this.height = 200,
    this.onTap,
    this.curve = Curves.linearToEaseOut,
    this.indicator,
  }) : assert(_images != null);

  @override
  _CustomBannerState createState() => _CustomBannerState();
}

class _CustomBannerState extends State<CustomBanner> {
  PageController _pageController;
  int _index;
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _index = widget._images.length * 5;
    _pageController = PageController(initialPage: _index);
    _initTimer();
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
    var length = widget._images.length;

    return widget.indicator != null
        ? widget.indicator
        : Positioned(
            bottom: 10,
            child: Row(
              children: widget._images.map((s) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: s == widget._images[_index % length]
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
    var length = widget._images.length;
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
        itemBuilder: (context, index) {
          return GestureDetector(
            onPanDown: (details) {
              _cancelTimer();
            },
            onTap: () {
              widget.onTap(index);
            },
            child: Image.network(
              widget._images[index % length].imageUrl,
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }

  _cancelTimer() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
      _initTimer();
    }
  }

  _initTimer() {
    if (_timer == null) {
      _timer = Timer.periodic(Duration(seconds: 3), (t) {
        _index++;
        _pageController.animateToPage(
          _index,
          duration: Duration(milliseconds: 800),
          curve: widget.curve,
        );
      });
    }
  }

  _switchPage() {
    Timer(Duration(milliseconds: 800), () {
      _pageController.jumpToPage(_index);
    });
  }
}
