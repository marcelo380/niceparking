import 'package:nice_parking/data/database_helper.dart';
import 'package:nice_parking/utils/returns/returns.dart';
import 'package:sqflite/sqlite_api.dart';

class ParkingSlotsReportRepository {
  ParkingSlotsReportRepository._privateConstructor();
  static final ParkingSlotsReportRepository instance =
      ParkingSlotsReportRepository._privateConstructor();

  Future<ReturnMessage> reportParkingSlots(
      {required String startDate,
      required String endDate,
      Database? mockDatabase}) async {
    Database _db;
    if (mockDatabase == null) {
      _db = await DatabaseHelper.instance.database;
    } else {
      _db = mockDatabase;
    }
    try {
      var _res = await _db.rawQuery(
          "select * from ESTACIONAMENTO WHERE DATA_ENTRADA BETWEEN ('$startDate') AND ('$endDate')");
      return returnSucess("Relatório gerado com sucesso!", data: _res);
    } on DatabaseException catch (e) {
      return Future.value(returnError("Erro ao salvar configuração", error: e));
    }
  }
}
