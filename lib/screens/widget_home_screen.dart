import 'package:agenda_eletronica/components/widget_contact_preview.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen ({Key? key}) : super(key: key);

  @override
  HomeScreeState createState() => HomeScreeState();

}

class HomeScreeState extends State<HomeScreen> with CommonComponent {

  @override
  Widget build(BuildContext context) {
    return content(
      child: ListView(
        padding: noEdgeInsets,
        children: [
          ContactPreview(),
          ContactPreview(),
          ContactPreview(),
          ContactPreview(),
          ContactPreview(),
        ]
      )
    );
  }
}