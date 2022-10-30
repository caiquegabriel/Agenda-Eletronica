import 'package:flutter/material.dart';

class LocalImage extends StatefulWidget {
  final EdgeInsets? margin;
  final String image;
  final double? width;
  final double? height;
  final BoxFit? fit;

  const LocalImage ({super.key, this.margin, required this.image, this.width, this.height, this.fit});

  @override
  LocalImageState createState() => LocalImageState();
}

class LocalImageState extends State<LocalImage> {

  String? _image;

  @override
  void initState() {
    super.initState();

    setState(() {
      _image = widget.image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      child: Image.asset(
        _image ?? "assets/images/loading.gif",
        fit: widget.fit,
        width: widget.width ?? double.infinity,
        height: widget.height
      )
    );
  }
}