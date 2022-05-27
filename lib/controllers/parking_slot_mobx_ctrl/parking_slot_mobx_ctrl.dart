import 'package:mobx/mobx.dart';
import 'package:nice_parking/interfaces/parking_repository.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:sqflite/sqlite_api.dart';

part 'parking_slot_mobx_ctrl.g.dart';

const mockVagas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
class ParkingSlotMobxCTRL = _ParkingSlotMobxCTRLBase with _$ParkingSlotMobxCTRL;

abstract class _ParkingSlotMobxCTRLBase with Store {
  Database? mockDatabase;

  @observable
  ObservableList<ParkingModel> parkingSlotsList = ObservableList();

  @action
  init() async {
    parkingSlotsList.clear();
    List<ParkingModel> _listSelectParkingSlots = [];

    List<Map> _resSelect = await ParkingSpacesRepository.instance
        .selectParkingSlots(inUse: true, mockDatabase: mockDatabase);

    for (var element in _resSelect) {
      _listSelectParkingSlots.add(ParkingModel.fromMap(element));
    }

    for (var numVaga in mockVagas) {
      List<ParkingModel> _selectEmptySlot = _listSelectParkingSlots
          .where((slot) => slot.numVaga == numVaga)
          .toList();

      if (_selectEmptySlot.isNotEmpty) {
        _selectEmptySlot[0].numVaga = numVaga;
        _selectEmptySlot[0].empty = false;
        parkingSlotsList.addAll(_selectEmptySlot);
      } else {
        parkingSlotsList.add(ParkingModel(numVaga: numVaga));
      }
    }
  }

  @action
  Future<bool> insertVehicleParkingSlot(
      {required int numVaga, required String placa}) async {
    ParkingModel _dataInsert = ParkingModel();
    _dataInsert.empty = false;
    _dataInsert.dataEntrada = DateTime.now().toString();
    _dataInsert.numVaga = numVaga;
    _dataInsert.placa = placa;

    var _res = await ParkingSpacesRepository.instance
        .insertVehicleParkingSlot(_dataInsert, mockDatabase: mockDatabase);

    if (_res.sucess) {
      _dataInsert.codigo = _res.data;

      int _indexList = parkingSlotsList.indexWhere((e) => e.numVaga == numVaga);

      parkingSlotsList[_indexList] = _dataInsert;
      return true;
    } else {
      return false;
    }
  }

  @action
  removeVehicleSlotParking({required int numVaga}) async {
    int _indexList = parkingSlotsList.indexWhere((e) => e.numVaga == numVaga);
    parkingSlotsList[_indexList].dataSaida = DateTime.now().toString();

    var _res = await ParkingSpacesRepository.instance.removeVehicleParkingSlot(
        parkingSlotsList[_indexList],
        mockDatabase: mockDatabase);
    if (_res.sucess) {
      parkingSlotsList[_indexList].empty = true;
    }
  }
}
