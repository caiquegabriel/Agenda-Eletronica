import 'package:agenda_eletronica/components/widget_loading.dart';
import 'package:agenda_eletronica/providers/contact_provider.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen ({Key? key}) : super(key: key);

  @override
  HomeScreeState createState() => HomeScreeState();

}

class HomeScreeState extends State<HomeScreen> with CommonComponent {

  ContactProvider contactProvider = Modular.get<ContactProvider>();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      contactProvider.loadContactPreviews();
    });
  }

  @override
  Widget build(BuildContext context) {
    return content(
      child: ChangeNotifierProvider(
          create: (BuildContext context) => contactProvider,
          child: Consumer<ContactProvider>(
            builder: (context, value, _) {
              if (value.contactPreviews == null) {
                return Container(
                  alignment: Alignment.center,
                  child: const Loading(
                    text: "Carregando ..."
                  )
                );
              } else {
                return ListView(
                  padding: noEdgeInsets,
                  children: value.contactPreviews!
                );
              }
            }
          )
        )
    );
  }
}