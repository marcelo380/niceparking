import 'package:mobx/mobx.dart';
import 'package:nice_parking/interfaces/parking_repository.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:sqflite/sqlite_api.dart';

part 'parking_mobx_ctrl.g.dart';

const mockVagas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
class ParkingMobxCTRL = _ParkingMobxCTRLBase with _$ParkingMobxCTRL;

abstract class _ParkingMobxCTRLBase with Store {
  Database? mockDatabase;

  @observable
  ObservableList<ParkingModel> parkingSlotsList = ObservableList();

  @action
  init() async {
    parkingSlotsList.clear();
    List<ParkingModel> _listSelectParkingSlots = [];

    List<Map> _resSelect = await ParkingSpacesRepository.instance
        .selectParkingSlots(inUse: false, mockDatabase: mockDatabase);

    _resSelect.forEach((element) {
      _listSelectParkingSlots.add(ParkingModel.fromMap(element));
    });

    mockVagas.forEach((numVaga) {
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
    });
  }

  @action
  insertVehicleParkingSlot(
      {required int numVaga, required String responsavel}) async {
    ParkingModel _dataInsert = ParkingModel();
    _dataInsert.empty = false;
    _dataInsert.dataEntrada = DateTime.now().toString();
    _dataInsert.numVaga = numVaga;
    _dataInsert.responsavel = responsavel;

    var _res = await ParkingSpacesRepository.instance
        .insertVehicleParkingSlot(_dataInsert, mockDatabase: mockDatabase);

    if (_res.sucess) {
      _dataInsert.codigo = int.parse(_res.message);

      int _indexList = parkingSlotsList.indexWhere((e) => e.numVaga == numVaga);

      parkingSlotsList[_indexList] = _dataInsert;
    } else {
      //toDo tratar com flushbar ou snack
      print("Vaga em uso");
    }
  }
}
