import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:nice_parking/interfaces/report_repository.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:nice_parking/utils/returns/returns.dart';
import 'package:sqflite/sqlite_api.dart';

part 'report_parking_slots_mobx_ctrl.g.dart';

class ReportParkingSlotsMobxCTRL = _ReportParkingSlotsMobxCTRLBase
    with _$ReportParkingSlotsMobxCTRL;

abstract class _ReportParkingSlotsMobxCTRLBase with Store {
  Database? mockDatabase;

  @observable
  ObservableList<ParkingModel> parkinReportList = ObservableList();

  @observable
  bool _noResults = false;

  @computed
  bool get emptyState => parkinReportList.isEmpty && !_noResults;

  @computed
  bool get noResults => parkinReportList.isEmpty && _noResults;

  @computed
  bool get hasResults => parkinReportList.isNotEmpty && !_noResults;

  @action
  void setNoResults(bool value) {
    _noResults = value;
  }

  report({required DateTime startDate, required DateTime endDate}) async {
    parkinReportList.clear();
    String _startDateFormated =
        DateFormat('yyyy-MM-dd').format(startDate) + " 00:01:00";
    String _endDateFormated =
        DateFormat('yyyy-MM-dd').format(endDate) + " 23:59:00";

    ReturnMessage _res = await ParkingSlotsReportRepository.instance
        .reportParkingSlots(
            startDate: _startDateFormated,
            endDate: _endDateFormated,
            mockDatabase: mockDatabase);

    if (_res.sucess) {
      _res.data.forEach((e) {
        parkinReportList.add(ParkingModel.fromMap(e));
      });

      if (parkinReportList.isNotEmpty) {
        setNoResults(false);
      } else {
        setNoResults(true);
      }
    }
  }
}
