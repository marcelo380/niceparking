import 'package:flutter_test/flutter_test.dart';
import 'package:nice_parking/controllers/parking_slot_mobx_ctrl/parking_slot_mobx_ctrl.dart';
import 'package:nice_parking/controllers/report_parking_slots_mobx_ctrl/report_parking_slots_mobx_ctrl.dart';
import 'package:nice_parking/data/database_helper.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Database? db;
  ParkingSlotMobxCTRL? parkingMobxCTRL = ParkingSlotMobxCTRL();

  ReportParkingSlotsMobxCTRL reportParkingSlotsMobxCTRL =
      ReportParkingSlotsMobxCTRL();

  sqfliteFfiInit();

  setUpAll(() async {
    sqfliteFfiInit();
    db = await databaseFactoryFfi.openDatabase(inMemoryDatabasePath);
    //criar tabela base, isso vai garantir que o sql seja o mesmo
    await db!.execute(queryDBCreate);
    //mocka a db
    parkingMobxCTRL.mockDatabase = db;
    reportParkingSlotsMobxCTRL.mockDatabase = db;
    //inicia
    await parkingMobxCTRL.init();
  });

  test('Testa database do sqlite', () async {
    expect(await db!.getVersion(), 0);
  });

  test('Testa a inicialização das vagas ', () async {
    expect(parkingMobxCTRL.parkingSlotsList.length, 10);
  });

  test('Testa inserção de veiculo na vaga', () async {
    await parkingMobxCTRL.insertVehicleParkingSlot(
        numVaga: 1, placa: 'marcelo');
    await parkingMobxCTRL.insertVehicleParkingSlot(
        numVaga: 2, placa: 'roberto');

    List _testInsert = parkingMobxCTRL.parkingSlotsList
        .where((e) => e.empty == false)
        .toList();

    expect(_testInsert.length, 2);
  });

//toDo revisar esse código
  test('Testa inserção de vaga duplicada', () async {
    await parkingMobxCTRL.insertVehicleParkingSlot(
        numVaga: 5, placa: 'marcelo');
    await parkingMobxCTRL.insertVehicleParkingSlot(
        numVaga: 5, placa: 'marcelo');

    List _testInsert =
        parkingMobxCTRL.parkingSlotsList.where((e) => e.numVaga == 5).toList();

    expect(_testInsert.length, 1);
  });

  test('Testa remover veiculo da vaga', () async {
    await parkingMobxCTRL.removeVehicleSlotParking(numVaga: 5);

    ParkingModel _testRemove =
        parkingMobxCTRL.parkingSlotsList.firstWhere((e) => e.numVaga == 5);

    expect(_testRemove.empty, true);
  });

  test('Testa relatorio', () async {
    await reportParkingSlotsMobxCTRL.report(
        startDate: DateTime.now(), endDate: DateTime.now());
    //! atenção: por conta dos testes anteriores o relatorio tem que trazer 3 resultados

    expect(reportParkingSlotsMobxCTRL.parkinReportList.length, 3);
  });
}
