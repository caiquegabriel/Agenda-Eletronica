import 'package:agenda_eletronica/components/widget_local_image.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget{
  final String? text;

  const Loading({Key? key, this.text}) : super(key: key);

  @override
  LoadingState createState() => LoadingState();
}

class LoadingState extends State<Loading> with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  @override 
  Widget build(BuildContext context) {

    Widget loadingBox = Container(
      margin: const EdgeInsets.all(0),
      width: 220,
      height: 76,
      child: Container(
        padding: const EdgeInsets.all(5),
        height: 76,
        alignment: Alignment.center,
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.2),
              blurRadius: 2.0,
              offset: Offset(0.3, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [ 
            const LocalImage(
              margin: EdgeInsets.only(
                left: 10,
                right: 13,
              ),
              width: 25,
              height: 25,
              image: "assets/images/loading.gif",
            ),
            Text(
              widget.text ?? "Carregando ...",
              maxLines: 2,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                overflow: TextOverflow.ellipsis
              ),
            )
          ]
        )
      ),
    );
  
    return loadingBox;
  }
 
 @override
 void dispose(){
   super.dispose();
 }
}