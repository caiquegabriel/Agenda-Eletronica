import 'package:agenda_eletronica/data/network_service.dart';

import '../data/db/db.dart';

class Service {

  late final DB _dbConn;

  Service() {
    _dbConn = DB();
  }

  Future? call(Uri uri, String method, Map<String, dynamic>? params, {bool jsonFormat = true, Map<String, String>? headers}) {
    return callService(
      uri,
      method,
      params,
      jsonFormat: jsonFormat,
      headers: headers
    );
  }

  get dbConn async => _dbConn.connect();
}