import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base_example/entity/animate.dart';

class MovieListItem extends StatelessWidget {
  MovieListItem({required this.bean, this.onPressed}) : super();
  final Animate bean;
  final VoidCallback? onPressed;

  void detail(String bean) {}

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(10.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image(
                  image: CachedNetworkImageProvider('${bean.kg_pic_url}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              margin: const EdgeInsets.only(left: 10.0),
              height: 150.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text('${bean.name}',
                      style: TextStyle(fontSize: 20.0, color: Colors.blue)),
                  Text('${bean.additional}'),
                  Text('${bean.sort}'),
                  Text('${bean.statlst}'),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
