import 'package:agenda_eletronica/components/widget_loading.dart';
import 'package:agenda_eletronica/data/local.dart';
import 'package:agenda_eletronica/providers/contact_provider.dart';
import 'package:agenda_eletronica/screens/widget_common_screen.dart';
import 'package:agenda_eletronica/style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:provider/provider.dart';

import '../components/widget_custom_button.dart';
import '../helpers.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen ({Key? key}) : super(key: key);

  @override
  HomeScreeState createState() => HomeScreeState();

}

class HomeScreeState extends State<HomeScreen> with CommonComponent, AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  ContactProvider contactProvider = Modular.get<ContactProvider>();

  Future _loadPreviews() async {
    String firstInitialization = await (Modular.get<Local>()).getString('app_name_5');
    if (firstInitialization.isEmpty) {
      (Modular.get<Local>()).setString('app_name_5', 'Agenda Eletronica');
      await contactProvider.generateUsers();
    }
    contactProvider.loadContactPreviews();
  }

  @override
  void initState() {
    super.initState();
    _loadPreviews();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return content(
      rightButton: CustomButton(
        width: 45,
        height: 45,
        icon: CupertinoIcons.add,
        iconSize: 25,
        textColor: primaryColor,
        iconColor: primaryColor,
        onClick: () {
          navigatorPushNamed(context, '/contact_register');
        },
      ),
      child: Container(
        margin: noEdgeInsets,
        child: ChangeNotifierProvider(
          create: (BuildContext context) => contactProvider,
          child: Consumer<ContactProvider>(
            builder: (context, value, _) {
              if (value.contactPreviews == null) {
                return Container(
                  key: GlobalKey(),
                  alignment: Alignment.center,
                  child: const Loading(
                    text: "Carregando ..."
                  )
                );
              } else if (value.contactPreviews!.isEmpty) {
                return Container(
                  key: GlobalKey(),
                  padding: const EdgeInsets.all(15),
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        color: Colors.black
                      ),
                      children: [
                        TextSpan(
                          text: "Agenda Vazia :(",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          )
                        ),
                        TextSpan(
                          text: '\nPara adicionar um contato, clique no botão "+"',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w200,
                            color: Colors.black87
                          )
                        )
                      ]
                    )
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
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}