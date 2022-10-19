import 'package:flutter/cupertino.dart';

abstract class BaseListViewModel<T> {
  bool hasMore = true;
  LoadingStatus loadingStatus = LoadingStatus.idle;
  int page = 0;
  List<T> data = new List.empty(growable: true);

  //BaseListViewModel({this.page = 0});

  bool get value => hasMore;

  void setHasMore(bool hasMore) {
    this.hasMore = hasMore;
  }

  void setPage(int page) {
    this.page = page;
  }

  List<T> getData() {
    return data;
  }

  void addData(List<T>? list) {
    if (null != list) {
      data.addAll(list);
    }
  }

  void updateDataAndPage(List<T> list, int pageNumber) {
    if (null != list) {
      data.addAll(list);
    }
    page = pageNumber;
  }

  void setData(List<T>? list) {
    if (list == null) {
      data = [];
    } else {
      data = list;
    }
  }

  int getCount() {
    return data == null ? 0 : data.length;
  }

  Future loadData({int? pn});

  Future loadMore({int? pn});

  @override
  String toString() {
    return 'BaseListViewModel{hasMore: $hasMore, _loadingStatus: $loadingStatus, page: $page, data: $data}';
  }
}

Widget getLoadingStatusWidget(
  Widget widget, {
  LoadingStatus loadingStatus = LoadingStatus.idle,
  bool hasData = true,
  Widget? loadingWidget,
  Widget? loadErrorWidget,
  Widget? loadNoDataWidget,
}) {
  String text = "加载中";
  if (loadingStatus == LoadingStatus.successed) {
    if (hasData) {
      return widget;
    } else {
      text = "无数据";
      if (loadNoDataWidget != null) {
        return loadNoDataWidget;
      }
    }
  } else if (loadingStatus == LoadingStatus.loading ||
      loadingStatus == LoadingStatus.loadingMore) {
    text = "加载中";
    if (loadingWidget != null) {
      return loadingWidget;
    }
  } else if (loadingStatus == LoadingStatus.failed) {
    text = "加载失败";
    if (loadErrorWidget != null) {
      return loadErrorWidget;
    }
  } else {
    text = "无数据";
    if (loadNoDataWidget != null) {
      return loadNoDataWidget;
    }
  }
  return Center(
    child: Text(text),
  );
}

enum LoadingStatus {
  /// Initial state
  idle,

  /// the indicator is loading,waiting for the finish callback
  loading,
  loadingMore,

  /// the indicator refresh completed
  successed,

  /// the indicator refresh failed
  failed,
}
