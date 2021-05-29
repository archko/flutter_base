import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/http/http_client.dart';
import 'package:flutter_base/http/http_response.dart';
import 'package:flutter_base/model/base_list_view_model.dart';
import 'package:flutter_base/utils/isolate_utils.dart';
import 'package:flutter_base/utils/json_utils.dart';
import 'package:flutter_base/widget/banner/custom_banner.dart';
import 'package:flutter_base_example/entity/animate.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MovieProvider extends BaseListViewModel<Animate> with ChangeNotifier {
  RefreshController? refreshController;
  List<BannerBean>? _bannerBeans;

  MovieProvider({this.refreshController}) {
    page = 0;
  }

  @override
  List<Animate> getData() {
    return data;
  }

  @override
  Future loadData({int? pn}) async {
    List<Animate>? list = await loadMovie(pn: 0);
    print("loadData:$list");
    setData(list);
    if (list == null || list.length == 0) {
      loadingStatus = LoadingStatus.failed;
      refreshController?.refreshCompleted();
      notifyListeners();
      return;
    }
    loadingStatus = LoadingStatus.successed;
    if (list.length > 0) {
      refreshController?.refreshCompleted();
    } else {
      refreshController?.loadNoData();
    }

    notifyListeners();
  }

  Future loadMore({int? pn}) async {
    List<Animate>? list = await loadMovie(pn: page + 1);
    print("loadMore:$list");
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

  Future<List<Animate>?> loadMovie({int? pn}) async {
    pn ??= 0;
    List<Animate>? list;
    String url =
        'https://sp0.baidu.com/8aQDcjqpAAV3otqbppnN2DJv/api.php?resource_id=28286&from_mid=1&&format=json&ie=utf-8&oe=utf-8&query=电影&sort_key=16&sort_type=1&stat0=&stat1=&stat2=&stat3=&pn=$pn&rn=6&cb=cbs';
    try {
      HttpResponse httpResponse = await HttpClient.instance.get(url);
      String result =
          httpResponse.data?.replaceAll('cbs(', '').replaceAll(')', '');
      //print("result:$result");
      list = await compute(decodeMovieListResult, result);
      //list = await loadWithBalancer<List<Animate>, String>(
      //    decodeMovieListResult, result);
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

  static List<BannerBean> decodeBannerListResult(String result) {
    return JsonUtils.decodeAsList(result).map<BannerBean>((dynamic json) {
      BannerBean bean = BannerBean();
      bean.imageUrl = json['image'];
      bean.title = json['title'];
      return bean;
    }).toList();
  }

  Future loadBanner() async {
    String bannerJson =
        '[{"image":"http://gank.io/images/cfb4028bfead41e8b6e34057364969d1","title":"干货集中营新版更新","url":"https://gank.io/migrate_progress"},{"image":"http://gank.io/images/aebca647b3054757afd0e54d83e0628e","title":"- 春水初生，春林初盛，春风十里，不如你。","url":"https://gank.io/post/5e51497b6e7524f833c3f7a8"},{"image":"https://pic.downk.cc/item/5e7b64fd504f4bcb040fae8f.jpg","title":"盘点国内那些免费好用的图床","url":"https://gank.io/post/5e7b5a8b6d2e518fdeab27aa"}]';
    _bannerBeans = await compute(decodeBannerListResult, bannerJson);
    //_bannerBeans = await loadWithBalancer<List<BannerBean>, String>(
    //    decodeBannerListResult, bannerJson);
    notifyListeners();
  }

  List<BannerBean>? getBannerBeans() {
    if (_bannerBeans == null) {
      return [];
    }
    return _bannerBeans;
  }
}
