import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/isolate_utils.dart';
import 'package:flutter_base/utils/json_utils.dart';
import 'package:flutter_base_example/entity/animate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieProvider extends BaseListViewModel with ChangeNotifier {
  RefreshController refreshController;

  bool refreshFailed = false;

  MovieProvider({this.refreshController}) {
    //refresh();
  }

  @override
  Future loadData({int pn}) async {
    List<Animate> list = await loadMovie(pn: 0);
    setData(list);
    if (list == null || list.length == 0) {
      refreshFailed = true;
      refreshController?.refreshCompleted();
      notifyListeners();
      return;
    }
    refreshFailed = false;
    if (list != null && list.length > 0) {
      refreshController?.refreshCompleted();
    } else {
      refreshController?.loadNoData();
    }

    notifyListeners();
  }

  Future loadMore({int pn}) async {
    List<Animate> list = await loadMovie(pn: page + 1);
    if (list != null && list.length > 0) {
      addData(list);

      setPage(page + 1);

      refreshController?.loadComplete();
    } else {
      if (list == null) {
        refreshController?.loadFailed();
      } else {
        refreshController?.resetNoData();
      }
    }

    notifyListeners();
  }

  Future<List<Animate>> loadMovie({int pn}) async {
    pn ??= 0;
    List<Animate> list;
    String url =
        'https://sp0.baidu.com/8aQDcjqpAAV3otqbppnN2DJv/api.php?resource_id=28286&from_mid=1&&format=json&ie=utf-8&oe=utf-8&query=电影&sort_key=16&sort_type=1&stat0=&stat1=&stat2=&stat3=&pn=$pn&rn=6&cb=cbs';
    try {
      HttpResponse httpResponse = await HttpClient.instance.get(url);
      String result =
          httpResponse.data.replaceAll('cbs(', '').replaceAll(')', '');
      //print("result:$result");
      //list = await compute(decodeMovieListResult, result);
      list = await loadWithBalancer<List<Animate>, String>(
          decodeMovieListResult, result);
    } catch (e) {
      print(e);
    }
    return list;
  }

  static List<Animate> decodeMovieListResult(String result) {
    return JsonUtils.decodeAsMap(result)['data'][0]['result']
        .map<Animate>((dynamic json) => Animate.fromJson(json))
        .toList();
  }
}
