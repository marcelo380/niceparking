import 'package:flutter_test/flutter_test.dart';
import 'package:nice_parking/controllers/parking_mobx_ctrl/parking_mobx_ctrl.dart';
import 'package:nice_parking/data/database_helper.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Database? db;
  ParkingMobxCTRL? parkingMobxCTRL = ParkingMobxCTRL();
  sqfliteFfiInit();

  setUpAll(() async {
    sqfliteFfiInit();
    db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    //criar tabela base, isso vai garantir que o sql seja o mesmo
    await db!.execute(queryDBCreate);

    //mocka a db
    parkingMobxCTRL.mockDatabase = db;

    //inicia
    await parkingMobxCTRL.init();
  });

  test('Testa database do sqlite', () async {
    expect(await db!.getVersion(), 0);
  });

  test('Teste inicialização das vagas ', () async {
    expect(parkingMobxCTRL.parkingSlotsList.length, 10);
  });

  test('Teste inserção de veiculo na vaga', () async {
    await parkingMobxCTRL.insertVehicleParkingSlot(
        numVaga: 1, responsavel: 'marcelo');
    await parkingMobxCTRL.insertVehicleParkingSlot(
        numVaga: 2, responsavel: 'roberto');

    List _testInsert = parkingMobxCTRL.parkingSlotsList
        .where((e) => e.empty == false)
        .toList();

    expect(_testInsert.length, 2);
  });

  test('Testa inserção de vaga duplicada', () async {
    await parkingMobxCTRL.insertVehicleParkingSlot(
        numVaga: 5, responsavel: 'marcelo');
    await parkingMobxCTRL.insertVehicleParkingSlot(
        numVaga: 5, responsavel: 'marcelo');

    List _testInsert =
        parkingMobxCTRL.parkingSlotsList.where((e) => e.numVaga == 5).toList();

    expect(_testInsert.length, 1);
  });
}
