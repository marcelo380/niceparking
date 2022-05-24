import 'dart:convert';

import 'package:mobx/mobx.dart';
import 'package:nice_parking/interfaces/parking_repository.dart';
import 'package:nice_parking/models/parking_model.dart';
part 'parking_mobx_ctrl.g.dart';

const mockVagas = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10];
class ParkingMobxCTRL = _ParkingMobxCTRLBase with _$ParkingMobxCTRL;

abstract class _ParkingMobxCTRLBase with Store {
  @observable
  ObservableList<ParkingModel> parkingSlotsList = ObservableList();

  fetchParkingSpacesList() async {
    List<ParkingModel> _listSelectParkingSlots = [];

    List<Map> _resSelect =
        await ParkingSpacesRepository.instance.selectParkingSlots(inUse: false);

    _resSelect.forEach((element) {
      _listSelectParkingSlots.add(ParkingModel.fromMap(element));
    });

    mockVagas.forEach((element) {
      List<ParkingModel> _res = _listSelectParkingSlots
          .where((slot) => slot.numVaga == element)
          .toList();

      if (_res.isNotEmpty) {
        parkingSlotsList.addAll(_res);
      }
    });
  }
}
