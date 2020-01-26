import 'dart:convert';
import 'dart:typed_data';
import 'package:dollychallange/home/widgets/photo_container_widget.dart';
import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey _globalKey = new GlobalKey();
  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  Future<Uint8List> _capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary boundary =
          _globalKey.currentContext.findRenderObject();
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      appBar: AppBar(
        title: Text("SELECIONE SUAS FOTOS"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 50),
        child: Center(
          child: GridView.count(
            key: _globalKey,
            crossAxisCount: 2,
            children: ["LINKEDIN", "FACEBOOK", "INSTAGRAM", "TINDER"]
                .map((i) => PhotoContainerWidget(
                      title: i,
                    ))
                .toList(),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: Icon(
          Icons.share,
          color: Colors.white,
        ),
        label: Text(
          "COMPARTILHAR",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          _scaffold.currentState.showSnackBar(SnackBar(
            content: Row(
              children: <Widget>[
                Text("Estamos gerando sua foto, aguarde..."),
                CircularProgressIndicator()
              ],
            ),
            duration: Duration(seconds: 3),
          ));
          var bytes = await _capturePng();
          await Share.file('dollypartonchallenge', 'dollypartonchallenge.png',
              bytes, 'image/png',
              text: '#dollypartonchallenge');
        },
      ),
    );
  }
}
