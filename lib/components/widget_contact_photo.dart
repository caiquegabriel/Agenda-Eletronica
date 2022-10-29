import 'package:agricultorsuiteapp/components/widget_custom_image.dart';
import 'package:flutter/material.dart';

class ContactPhoto extends StatefulWidget {

  final EdgeInsets? margin;
  
  final dynamic avatar;

  final double? width; 

  final double? height; 

  final double? borderRadius; 

  final bool? local;

  final Color? borderColor;

  final Function? onClick;

  final double? borderWidth;

  const ContactPhoto({
    Key? key,
    this.borderRadius,
    this.onClick,
    this.borderColor,
    this.margin,
    this.local = false,
    required this.avatar,
    this.width,
    this.height,
    this.borderWidth
  }) : super(key: key);

  @override
  ContactPhotoState createState() => ContactPhotoState();

}

class ContactPhotoState extends State<ContactPhoto> {

  final GlobalKey<CustomImageState> _keyImageNetwork = GlobalKey();
  
  String? _avatar;  
  
  void removeContactPhoto(){
    _keyImageNetwork.currentState!.update("");
  }

  void updateContactPhoto(dynamic avatar) {    
    _keyImageNetwork.currentState!.update(avatar); 
  }

  @override
  void initState() {
    super.initState();  
    _avatar = widget.avatar; 
  }

  @override
  Widget build(BuildContext context) {

    return Container( 
      width: widget.width ?? 40,
      height: widget.height ?? 40, 
      margin: widget.margin,
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: widget.borderColor ?? Colors.transparent, width: widget.borderWidth ?? 1), 
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 1000),  
      ),  
      clipBehavior: Clip.antiAlias,
      child: Container(    
        width: widget.width ?? 40,
        height: widget.height ?? 40,
        decoration: BoxDecoration( 
          borderRadius: BorderRadius.circular(widget.borderRadius ?? 1000),  
        ),  
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          splashColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          child: CustomImage(
            key: _keyImageNetwork,
            image: _avatar ?? "",
            local: widget.local,
            defaultImage: "assets/images/default_avatar.png",
            height: widget.height ?? 40,
            width:  widget.width ?? 40,
            fit: BoxFit.cover
          ),
          onTap: () => ({
            if(widget.onClick != null) {
              widget.onClick!()
            }
          })
        ), 
      ),
    );
  }
}