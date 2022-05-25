import 'package:nice_parking/data/database_helper.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:nice_parking/utils/returns/returns.dart';

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

      if (numVaga != null && inUse == false) {
        result = await _db.query(DatabaseHelper.tableEstacionalmento,
            where: "(NUM_VAGA = $numVaga) AND (DATA_SAIDA is NULL)");
      } else if (numVaga == null && inUse == true) {
        result = await _db.query(DatabaseHelper.tableEstacionalmento,
            where: "DATA_SAIDA is NULL");
      } else {
        result = await _db.query(DatabaseHelper.tableEstacionalmento,
            where: "DATA_SAIDA IS NOT NULL");
      }
      return Future.value(result);
    } on DatabaseException catch (e) {
      return Future.value(
          returnError("Erro ao tentar exibir os dados", error: e));
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

        return Future.value(returnSucess("Vaga registrada com sucesso!",
            data: _res.toString()));
      } else {
        return Future.value(returnError("Vaga em uso!"));
      }
    } on DatabaseException catch (e) {
      return Future.value(returnError("Erro ao inserir comanda", error: e));
    }
  }

  Future<ReturnMessage> removeVehicleParkingSlot(ParkingModel parkingModel,
      {Database? mockDatabase}) async {
    Database _db;
    if (mockDatabase == null) {
      _db = await DatabaseHelper.instance.database;
    } else {
      _db = mockDatabase;
    }
    try {
      List _resSelect = await ParkingSpacesRepository.instance
          .selectParkingSlots(numVaga: parkingModel.numVaga, mockDatabase: _db);

      if (_resSelect.isNotEmpty) {
        var _res = await _db.update(
            DatabaseHelper.tableEstacionalmento, parkingModel.toMap(),
            where: "CODIGO = ${parkingModel.codigo}");

        return Future.value(
            returnSucess("Vaga liberada com sucesso!", data: _res.toString()));
      } else {
        return Future.value(returnError("Vaga não estava em uso!"));
      }
    } on DatabaseException catch (e) {
      return Future.value(returnError("Erro ao inserir comanda", error: e));
    }
  }
}
