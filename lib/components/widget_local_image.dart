import 'dart:io';

import 'package:flutter/material.dart';

class LocalImage extends StatefulWidget {
  final EdgeInsets? margin;
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const LocalImage(
      {super.key,
      this.margin,
      required this.image,
      this.width,
      this.height,
      this.fit});

  @override
  LocalImageState createState() => LocalImageState();
}

class LocalImageState extends State<LocalImage> {
  String? _image;

  void updateImage(String? image) {
    image ??= "";
    File(image).exists().then((results) {
      if (results) {
        setState(() {
          _image = image;
        });
      } else {
        setState(() {
          _image = null;
        });
      }
    });
  }

  @override
  void initState() {
    super.initState();

    updateImage(widget.image);
  }

  @override
  Widget build(BuildContext context) {
    if (_image == null || _image!.isEmpty) {
      return Container(
          margin: widget.margin,
          child: Image.asset(("assets/images/default_avatar.png"),
              fit: widget.fit,
              width: widget.width ?? double.infinity,
              height: widget.height));
    }
    return Container(
        margin: widget.margin,
        child: Image.file(File(_image ?? "assets/images/default_avatar.png"),
            fit: widget.fit,
            width: widget.width ?? double.infinity,
            height: widget.height));
  }
}
