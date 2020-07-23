import 'package:flutter/cupertino.dart';

abstract class BaseListViewModel<T> {
  bool hasMore = true;
  LoadingStatus loadingStatus = LoadingStatus.idle;
  int page = 0;
  List<T> data = new List<T>();

  BaseListViewModel({this.page});

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

  void addData(List<T> list) {
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

  void setData(List<T> list) {
    data = list;
    data ??= [];
  }

  int getCount() {
    return data == null ? 0 : data.length;
  }

  Future loadData({int pn});

  Future loadMore({int pn});

  @override
  String toString() {
    return 'BaseListViewModel{hasMore: $hasMore, _loadingStatus: $loadingStatus, page: $page, data: $data}';
  }
}

Widget getLoadingStatusWidget(
    LoadingStatus loadingStatus, bool hasData, Widget widget) {
  if (loadingStatus != LoadingStatus.successed &&
      loadingStatus != LoadingStatus.loadingMore) {
    String text = "无数据";
    if (loadingStatus == LoadingStatus.failed) {
      text = "加载失败";
    } else if (loadingStatus == LoadingStatus.loading) {
      text = "加载中";
    }
    return Center(
      child: Text(text),
    );
  } else {
    if (loadingStatus == LoadingStatus.successed) {
      if (!hasData) {
        return Center(
          child: Text("无数据"),
        );
      }
    }
  }
  return widget;
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
