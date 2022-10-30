import 'package:agenda_eletronica/style.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {

  final String? text;

  final IconData? icon;

  final double? iconSize;

  final double? fontSize;

  final Function? onClick;

  final int? count;

  final double? width;

  final double? height;

  final EdgeInsets? margin;

  final bool? enableBorderTop;

  final Color? textColor;

  final Color? backgroundColor;

  final Color? iconColor;

  final BorderRadius? borderRadius;

  final EdgeInsets? iconMargin;

  const CustomButton({
    Key? key,
    this.iconColor,
    this.textColor,
    this.backgroundColor,
    this.enableBorderTop,
    this.margin,
    this.text,
    this.fontSize,
    this.iconSize,
    this.icon,
    this.onClick,
    this.count,
    this.width,
    this.height,
    this.borderRadius,
    this.iconMargin
  }) : super(key: key);

  @override
  CustomButtonState createState() => CustomButtonState();

}

class CustomButtonState extends State<CustomButton> {

  bool _current = false;

  void currentButton(bool current) {  
    if(!mounted) return;  
    
    setState((){ 
      _current = current;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      margin: widget.margin ?? const EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        color: widget.backgroundColor ?? Colors.transparent
      ),
      child: InkWell(
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: () {
          if (widget.onClick != null) {
            widget.onClick!();
          }
        },
        child: Stack(
          children: [
            Container(
              margin: const EdgeInsets.all(0),
              width: widget.width,
              height: widget.height,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: widget.text == null ? widget.width : null,
                    height: widget.text == null ? widget.height : null,
                    margin: widget.icon != null ? widget.iconMargin : null,
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(0),
                          child: Icon(
                            widget.icon,
                            size: widget.iconSize ?? 18,
                            color: _current == true ? widget.iconColor ?? Colors.white : widget.iconColor ?? Colors.white.withOpacity(0.5),
                          ),
                        ),
                        (widget.count != null)
                          ?
                            Positioned(
                              right: 0,
                              top: 0,
                              child: Container(
                                width: 14,
                                height: 14,
                                alignment: Alignment.center,
                                clipBehavior: Clip.antiAlias,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(100)
                                ),
                                child: Text(
                                  widget.count! < 10 ? widget.count!.toString() : "+9",
                                  style: const TextStyle(
                                    fontSize: 10,
                                    height: 0,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white
                                  ),
                                ),
                              )
                            )
                          :
                            const SizedBox.shrink()
                      ]
                    )
                  ),
                  (widget.text != null)
                    ?
                      Container(
                        margin: const EdgeInsets.only(
                          left: 6
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.text!,
                          style: TextStyle(
                            fontSize: widget.fontSize ?? 11,
                            color: widget.textColor ?? (_current == true ? Colors.white : Colors.white.withOpacity(0.5)),
                            fontWeight: FontWeight.w400
                          ),
                        )
                      )
                    :
                      const SizedBox.shrink()
                ],
              ),
            ),
            (widget.enableBorderTop == true)
            ?
            (
              (_current)
                ?
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 50,
                      height: 4.5,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(255, 255, 255, 0.3),
                        borderRadius: BorderRadius.circular(100)
                      ),
                    ),
                  )
                :
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 50,
                      height: 4.5,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        color: Color.fromRGBO(0, 0, 0, 0.06)
                      ),
                    ),
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