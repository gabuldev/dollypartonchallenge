import 'dart:io';

import 'package:dollychallange/home/widgets/photo_container_bloc.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class PhotoContainerWidget extends StatefulWidget {
  final String title;
  PhotoContainerWidget({Key key, this.title}) : super(key: key);

  @override
  _PhotoContainerWidgetState createState() => _PhotoContainerWidgetState();
}

class _PhotoContainerWidgetState extends State<PhotoContainerWidget> {
  var bloc = PhotoContainerBloc();

  void getCamera() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text("SELECIONE UM OPCAO"),
              actions: <Widget>[
                FlatButton(
                  child: Text("GALERIA"),
                  onPressed: () async {
                    File file = await ImagePicker.pickImage(
                        source: ImageSource.gallery);
                    bloc.add(file?.path);
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("CAMERA"),
                  onPressed: () async {
                    File file =
                        await ImagePicker.pickImage(source: ImageSource.camera);
                    bloc.add(file?.path);
                    Navigator.pop(context);
                  },
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          getCamera();
        },
        child: Container(
          height: size.width * .46,
          width: size.width * .46,
          decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          child: StreamBuilder(
            stream: bloc.photoOut,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    Center(
                      child: Container(
                        height: 500,
                        width: 500,
                        child: Image.file(
                          File(snapshot.data),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Stack(
                              children: <Widget>[
                                // Stroked text as border.
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: 25,
                                    foreground: Paint()
                                      ..style = PaintingStyle.stroke
                                      ..strokeWidth = 6
                                      ..color = Colors.black,
                                  ),
                                ),
                                // Solid text as fill.
                                Text(
                                  widget.title,
                                  style: TextStyle(
                                    fontSize: 25,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ))),
                  ],
                );
              } else {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.add_a_photo),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Stack(
                        children: <Widget>[
                          // Stroked text as border.
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 25,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 6
                                ..color = Colors.black,
                            ),
                          ),
                          // Solid text as fill.
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.grey[300],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ));
  }
}
