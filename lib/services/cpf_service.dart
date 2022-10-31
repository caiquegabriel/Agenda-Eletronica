import 'package:agenda_eletronica/services/service.dart';

class CPFService extends Service {

  CPFService() : super();

  Future<String> generateCPF() async {

    String response = await call(
      Uri.parse('https://www.4devs.com.br/ferramentas_online.php'),
      'POST',
      {'acao': 'gerar_cpf'},
      jsonFormat: false,
      headers: {"content-type": "application/x-www-form-urlencoded"}
    );

    return response;
  }
}