import 'package:agenda_eletronica/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';  

class Input extends StatefulWidget{ 

  final String? labelText;

  final String? initialValue; 

  final String? hintText;

  final Function validatorFunction;

  final IconData? icon;
  
  final bool obscureText; 

  final EdgeInsets? margin;

  final double? fontSize;

  final TextAlign? textAlign;

  final double? borderWidth;

  final Color? textColor;

  final Color? hintColor;

  final Color? labelColor;

  final bool? onlyBorder;

  final Color? borderColor;

  final Color? iconColor;

  final double? borderRadius;

  final Color? backgroundColor;

  final FontWeight? textWeight;

  final double? width;

  final double? height; 

  final Function? formSubmitFunction;

  final FocusNode? focusNode;

  final EdgeInsets? padding;

  final double? hintSize;

  final int? maxLength;

  final int? maxLines;

  final FocusNode? nextFocus;

  final FocusNode? previousFocus;

  final List<TextInputFormatter>? mask;

  final TextInputType? keyBoardType;

  final double? letterSpacing;

  final double? iconSize;

  final double? iconHeight;

  const Input({
    Key? key,
    this.mask,
    this.keyBoardType,
    this.previousFocus,
    this.nextFocus,
    this.maxLength,
    this.hintSize,
    this.padding,
    this.focusNode,
    this.formSubmitFunction,
    this.borderRadius,
    this.hintColor,
    this.iconColor,
    this.labelColor,
    this.textAlign,
    this.width,
    this.height,
    this.textWeight,
    this.borderWidth,
    this.iconHeight,
    this.initialValue,
    this.textColor,
    this.borderColor,
    this.backgroundColor,
    this.onlyBorder,
    this.fontSize,
    this.margin,
    this.labelText,
    required this.validatorFunction,
    this.hintText = "",
    this.icon,
    this.obscureText = false,
    this.maxLines,
    this.letterSpacing,
    this.iconSize
    }) : super(key: key);

  @override
  InputState createState() => InputState();
}


class InputState extends State<Input>{  

  final TextEditingController _inputController = TextEditingController(); 

  bool _fieldUpdated = false;

  int _currentLenght = 0;

  @override 
  void initState() {
    super.initState();
    updateValue(widget.initialValue ?? "");
  }

  void updateValue(String value) {
    _inputController.text = widget.initialValue ?? "";
  }

  int getCurrentLenght() {
    return _currentLenght;
  }

  TextEditingController inputController() {
    return _inputController;
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: widget.width ?? double.infinity,
      height: widget.height ?? 40,
      margin: widget.margin ?? const EdgeInsets.all(0),
      padding: widget.padding ?? const EdgeInsets.only(
        left: 5,
        right: 5
      ),
      decoration: BoxDecoration(
        color:  widget.backgroundColor ?? Colors.white,
        borderRadius: BorderRadius.circular(
          widget.borderRadius ?? 0
        ),
        border: Border.all(
          width: widget.borderWidth ?? 0.5,
          color: widget.borderColor ?? primaryColor
        )
      ),
      child: 
        Row(
          children: [ 
            (widget.icon != null)
              ?
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  color: Colors.transparent,
                  child: SizedBox(
                    width: 30,
                    height: widget.iconHeight ?? 30,
                    child: Icon(
                      widget.icon,
                      size: widget.iconSize ?? 15,
                      color: widget.iconColor ?? primaryColor
                    ),
                  )
                )
            :
              const SizedBox.shrink(),
            Expanded(
              child: Container(
                color: Colors.transparent,
                child: TextFormField(
                  maxLines: widget.maxLines ?? 1,
                  keyboardType: widget.keyBoardType,
                  inputFormatters: widget.mask,
                  onChanged: (value){
                    _currentLenght = value.length;
                    if (value.length == widget.maxLength) {
                      FocusScope.of(context).requestFocus(widget.nextFocus);
                    } else if (widget.previousFocus != null && value.isEmpty) { 
                      FocusScope.of(context).requestFocus(widget.previousFocus);
                    }
                  },
                  buildCounter: (context, {required int currentLength, required bool isFocused, required int? maxLength}) {
                    if (widget.nextFocus != null && maxLength != null && currentLength == maxLength) {
                      //FocusScope.of(context).requestFocus(widget.nextFocus);
                    }
                  },
                  maxLength: widget.maxLength,
                  focusNode: widget.focusNode,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  controller: _inputController,
                  style: TextStyle(
                    height: _currentLenght == 0 ? 1 : null,
                    fontSize: widget.fontSize ?? 18,
                    fontWeight: widget.textWeight ?? FontWeight.normal,
                    letterSpacing: widget.letterSpacing,
                    color: widget.textColor ?? const Color.fromRGBO(33, 33, 33, 1)
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    labelText: widget.labelText,
                    counterStyle: const TextStyle(height: 0, color: Colors.transparent),   
                    hintText: widget.hintText ?? widget.labelText,
                    hintStyle: TextStyle(height: 0, color: widget.hintColor ?? widget.borderColor, fontSize: widget.hintSize ?? 14),
                    border: InputBorder.none,
                    labelStyle: TextStyle(height: 0, fontWeight: FontWeight.normal, color: widget.labelColor ?? Colors.grey, fontSize: 15),
                    errorStyle: const TextStyle(height: 0, color: Colors.transparent),   
                  ),
                  validator : (String? value) => widget.validatorFunction(value),
                  obscureText: widget.obscureText, 
                  onFieldSubmitted:(value){ 
                    if(widget.formSubmitFunction == null) return; 
                    widget.formSubmitFunction!(widget.key); 
                  },
                ),
              )
          )
        ]
      )
    );
  }

  @override
  void dispose(){
    super.dispose();
  }
}