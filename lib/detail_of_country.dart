import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DetailOfCountry extends StatefulWidget {
  final String isoCode; // 詳細を表示したい国のisoCode
  final String flagImagePath; // 詳細を表示したい国の画像パス

  DetailOfCountry(this.isoCode, this.flagImagePath); // コンストラクタ

  @override
  _DetailOfCountryState createState() => _DetailOfCountryState();
}
class _DetailOfCountryState extends State<DetailOfCountry> { // create_one_country_columnクラスで作られた国のリスト内の、画像をクリックした時に表示されるページに関するクラス

  PhotoViewController controller;
  double scaleCopy;
//
//  @override
//  void initState() {
//    super.initState();
//    controller = PhotoViewController()
//      ..outputStateStream.listen(listener);
//  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: GestureDetector(
        child: Container(
          padding: EdgeInsets.only(left: 10.0, right: 10.0),
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: PhotoView( // pinch操作の追加
                backgroundDecoration: BoxDecoration(color: Colors.grey[300]),
                minScale: 0.34,
                maxScale: 1.5,
                initialScale: PhotoViewComputedScale.contained * 0.9,
                heroTag: widget.isoCode, // タグをクリックした国旗の国に関するisoCordに設定(ヒーロータグを設定し、クリックしたある要素から、その要素を表示している別のウィジェットに遷移する時、滑らかに表示するためのウィジェット)
                imageProvider: AssetImage(
                  widget.flagImagePath,
                ),
              ),
            ),
          ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}