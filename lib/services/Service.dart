import '../data/db/db.dart';

class Service {

  late final DB _dbConn;

  Service() {
    _dbConn = DB();
  }

  get dbConn async => _dbConn.connect();
}