import 'package:flutter/material.dart';

class Badge extends StatelessWidget {

  final String? text;
  
  final double? fontSize;

  final Color? textColor;

  final FontWeight? fontWeight;

  final Color? bgColor;

  final Color? borderColor;

  final EdgeInsets? margin;

  final EdgeInsets? padding;

  final double? borderRadius;

  final IconData? icon;

  final double? width;

  final double? height;

  final double? opacity;

  const Badge({
    Key? key,
    this.borderColor,
    this.fontWeight,
    this.opacity = 1,
    this.height,
    this.width,
    this.icon,
    this.borderRadius,
    this.text,
    this.padding,
    this.margin,
    this.fontSize,
    this.textColor,
    this.bgColor
  }) : super(key: key);

  @override 
  Widget build(BuildContext context) {


    return Container( 
      width: width,
      height: height,
      alignment: Alignment.center,
      padding: padding ?? const EdgeInsets.only(
        bottom: 6,
        top: 6,
        left: 12,
        right: 12
      ),
      margin: margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        border: Border.all(
          color: borderColor ?? Colors.black.withOpacity(0.1),
          width: 0.5
        ),
        color: bgColor ?? Colors.white.withOpacity(opacity!),
        borderRadius: BorderRadius.circular(borderRadius ?? 5)
      ),
      child: Container(
        alignment: Alignment.center,
        child:
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              (icon != null) ? 
                Container( 
                  margin: EdgeInsets.only(right: text != null ? 10 : 0 ),
                  child: Icon(
                    icon!,
                    color: textColor ?? Colors.black,
                    size: fontSize ?? 13
                  )
                )
              :
                const SizedBox.shrink(),
              (text != null) ?
                Text(
                  text!,
                  style: TextStyle(
                    fontWeight: fontWeight ?? FontWeight.normal,
                    fontSize: fontSize ?? 13, 
                    color: textColor ?? Colors.black,
                    overflow: TextOverflow.ellipsis,
                    wordSpacing: 2
                  )
                )
              :
                const SizedBox.shrink()
            ]
          )
      )
    );
  }

}