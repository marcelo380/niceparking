import 'package:nice_parking/data/database_helper.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:nice_parking/utils/messages/messages.dart';
import 'package:sqflite/sqlite_api.dart';

class ParkingSpacesRepository {
  ParkingSpacesRepository._privateConstructor();
  static final ParkingSpacesRepository instance =
      ParkingSpacesRepository._privateConstructor();

  Future<List<Map>> selectParkingSlots({int? numVaga}) async {
    Database _db = await DatabaseHelper.instance.database;
    try {
      List<Map> result;

      if (numVaga != null) {
        result = await _db.query(DatabaseHelper.tableEstacionalmento,
            where: "num_vaga = $numVaga");
      } else {
        result = await _db.query(DatabaseHelper.tableEstacionalmento);
      }

      return Future.value(result);
    } on DatabaseException catch (e) {
      return Future.value(mensagemErro("Erro ao tentar exibir os dados", e));
    }
  }

  Future<Map<String, dynamic>> insertParkingSlot(
      ParkingModel parkingModel) async {
    Database _db = await DatabaseHelper.instance.database;
    try {
      var res = await _db.insert(
          DatabaseHelper.tableEstacionalmento, {...parkingModel.toJson()});

      return Future.value({
        'numero': res,
        'retorno': mensagemSucesso("Nº ${res}, inserido com sucesso}")
      });
    } on DatabaseException catch (e) {
      return Future.value(
          {'retorno': mensagemErro("Erro ao inserir comanda", e)});
    }
  }
}
