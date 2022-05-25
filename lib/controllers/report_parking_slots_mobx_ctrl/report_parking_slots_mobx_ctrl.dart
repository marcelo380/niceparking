import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:nice_parking/interfaces/report_repository.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:nice_parking/utils/messages/messages.dart';
part 'report_parking_slots_mobx_ctrl.g.dart';

class ReportParkingSlotsMobxCTRL = _ReportParkingSlotsMobxCTRLBase
    with _$ReportParkingSlotsMobxCTRL;

abstract class _ReportParkingSlotsMobxCTRLBase with Store {
  @observable
  ObservableList<ParkingModel> parkinReportList = ObservableList();

  @observable
  bool isLoading = false;

  @computed
  bool get emptyState => parkinReportList.isEmpty && isLoading == false;

  @computed
  bool get showSkeleton => parkinReportList.isEmpty && isLoading == true;

  report({required DateTime startDate, required DateTime endDate}) async {
    parkinReportList.clear();
    String _startDateFormated =
        DateFormat('yyyy-MM-dd').format(startDate) + " 00:01:00";
    String _endDateFormated =
        DateFormat('yyyy-MM-dd').format(endDate) + " 23:59:00";

    ReturnMessage _res = await ParkingSlotsReportRepository.instance
        .reportParkingSlots(
            startDate: _startDateFormated, endDate: _endDateFormated);

    if (_res.sucess) {
      _res.data.forEach((e) {
        parkinReportList.add(ParkingModel.fromMap(e));
      });
    }
  }
}
