import 'package:mobx/mobx.dart';
import 'package:nice_parking/interfaces/parking_repository.dart';
import 'package:nice_parking/models/parking_model.dart';
part 'parking_mobx_ctrl.g.dart';

const mockVagas = [1, 2, 3, 4, 5];
class ParkingMobxCTRL = _ParkingMobxCTRLBase with _$ParkingMobxCTRL;

abstract class _ParkingMobxCTRLBase with Store {
  @observable
  ObservableList<ParkingModel>? parkingModel;

  fetchParkingSpaces() async {
    mockVagas.forEach((int e) async {
      var res =
          await ParkingSpacesRepository.instance.selectParkingSlots(numVaga: e);
      print("oi $res");
    });
  }
}
