import 'package:agenda_eletronica/components/widget_local_image.dart';
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

  final GlobalKey<LocalImageState> localImageKey = GlobalKey();
  
  String? _avatar;
  
  void removeContactPhoto(){
    localImageKey.currentState!.updateImage("");
  }

  void updateContactPhoto(dynamic avatar) {    
    localImageKey.currentState!.updateImage(avatar); 
  }

  @override
  void initState() {
    super.initState();  
    setState(() {
      _avatar = widget.avatar;
    });
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
          onTap: () => ({
            if(widget.onClick != null) {
              widget.onClick!()
            }
          }),
          child: LocalImage(
            key: localImageKey,
            width: widget.width ?? 40,
            height: widget.height ?? 40,
            image: _avatar!,
            fit: BoxFit.cover,
          )
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}