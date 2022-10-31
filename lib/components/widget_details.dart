import 'package:agenda_eletronica/style.dart';
import 'package:flutter/material.dart';

class Details extends StatefulWidget {

  final Map<dynamic, dynamic> items;

  final bool? inline;

  final EdgeInsets? padding;

  final EdgeInsets? margin;

  final double? marginBottom;

  final Color? titleColor;

  final Color? descriptionColor;

  final double? descriptionSize;

  final double? titleSize;

  final FontWeight? titleFontWeight;

  const Details({Key? key,
    this.margin,
    this.marginBottom,
    this.titleColor,
    this.descriptionColor,
    this.descriptionSize,
    this.titleSize,
    this.inline,
    this.padding,
    required this.items,
    this.titleFontWeight
  }) : super( key : key);

  @override
  DetailsState createState() => DetailsState();
}


class DetailsState extends State<Details> {

  List<Widget> _detailsContainers = [];

  List<Widget> _details = [];


  @override
  void initState() {
    super.initState();

    bool inline = widget.inline ?? false;

    for(dynamic key in widget.items.keys) {
      dynamic value = widget.items[key];
      setState((){
        _detailsContainers.add(
          Container(
            width: double.infinity,
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(bottom: widget.marginBottom ?? 15),
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: inline != true ? 5 : 0),
                  child:  (key.runtimeType.toString() == "String") ? 
                    Text(
                      key,
                      style: TextStyle(
                        fontWeight: widget.titleFontWeight ?? FontWeight.bold,
                        fontSize: widget.titleSize ?? 15.6,
                        color: widget.titleColor ?? primaryColor
                      ),
                    )
                  :
                    key
                ),
                (value.runtimeType.toString() == "String")
                 ?
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: widget.descriptionSize ?? 18.6,
                      color: widget.descriptionColor ?? Colors.grey
                    ),
                  )
                :
                  value
              ],
            )
          )
        );
      });
    }

    List<Widget> children = [];
    int count = 0;
    _detailsContainers.forEach((element) {
      count++;
      children.add(Expanded(child: element));
      if(inline) {
        if (count % 2 == 0 || _detailsContainers.length == count) {
          _details.add(
            Row(
              children: children,
            )
          );
          children = [];
        }
      }else{
        if (count > 0) {
          _details.add(
            Row(
              children: children,
            )
          );
          children = [];
        }
      }
    });

    setState((){
      _details = _details;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin ?? const EdgeInsets.only(bottom: 10),
      padding: widget.padding,
      width: double.infinity,
      child: Column(
        children: _details,
      )
    );
  }
}