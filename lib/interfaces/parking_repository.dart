import 'package:nice_parking/data/database_helper.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:nice_parking/utils/messages/messages.dart';
import 'package:sqflite/sqlite_api.dart';

class ParkingSpacesRepository {
  ParkingSpacesRepository._privateConstructor();
  static final ParkingSpacesRepository instance =
      ParkingSpacesRepository._privateConstructor();

  ///[inUse] referece se a vaga está em uso ou seja dataSaida null
  Future<dynamic> selectParkingSlots(
      {int? numVaga, bool inUse = false, Database? mockDatabase}) async {
    Database _db;
    if (mockDatabase == null) {
      _db = await DatabaseHelper.instance.database;
    } else {
      _db = mockDatabase;
    }
    try {
      List<Map> result;

      if (numVaga != null) {
        result = await _db.query(DatabaseHelper.tableEstacionalmento,
            where: "NUM_VAGA = $numVaga");
      } else if (numVaga == null && inUse == true) {
        result = await _db.query(DatabaseHelper.tableEstacionalmento,
            where: "DATA_SAIDA is NULL");
      } else {
        result = await _db.query(DatabaseHelper.tableEstacionalmento);
      }

      return Future.value(result);
    } on DatabaseException catch (e) {
      return Future.value(
          mensagemErro("Erro ao tentar exibir os dados", error: e));
    }
  }

  Future<ReturnMessage> insertVehicleParkingSlot(ParkingModel parkingModel,
      {Database? mockDatabase}) async {
    Database _db;
    if (mockDatabase == null) {
      _db = await DatabaseHelper.instance.database;
    } else {
      _db = mockDatabase;
    }
    try {
      var _resSelect = await ParkingSpacesRepository.instance
          .selectParkingSlots(numVaga: parkingModel.numVaga, mockDatabase: _db);

      if (_resSelect.isEmpty) {
        var _res = await _db.insert(
            DatabaseHelper.tableEstacionalmento, {...parkingModel.toMap()});

        return Future.value(mensagemSucesso(_res.toString()));
      } else {
        return Future.value(mensagemErro("Vaga em uso!"));
      }
    } on DatabaseException catch (e) {
      return Future.value(mensagemErro("Erro ao inserir comanda", error: e));
    }
  }
}
