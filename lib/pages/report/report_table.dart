import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nice_parking/components/typography/typography.dart';
import 'package:nice_parking/controllers/report_parking_slots_mobx_ctrl/report_parking_slots_mobx_ctrl.dart';

class DataTableReport extends StatelessWidget {
  final ReportParkingSlotsMobxCTRL reportParkingSlotsMobxCTRL;
  const DataTableReport({required this.reportParkingSlotsMobxCTRL, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                columnSpacing: 20,
                horizontalMargin: 0,
                columns: [
                  DataColumn(
                    label: CustomTypography.title16('Placa'),
                  ),
                  DataColumn(
                    label: CustomTypography.title16('Entrada'),
                  ),
                  DataColumn(
                    label: CustomTypography.title16('Saida'),
                  ),
                  DataColumn(
                    label: Center(
                        child: CustomTypography.title16('Tempo de uso.')),
                  ),
                ],
                rows: reportParkingSlotsMobxCTRL.parkinReportList.map(
                  (item) {
                    return DataRow(
                      cells: [
                        DataCell(
                          Center(
                              child: CustomTypography.body14('${item.placa}')),
                        ),
                        DataCell(
                          Center(
                            child: CustomTypography.body14(
                              DateFormat('dd/MM/yyyy hh:mm')
                                  .format(DateTime.parse(item.dataEntrada!))
                                  .toString(),
                            ),
                          ),
                        ),
                        DataCell(
                          Center(
                              child: CustomTypography.body14(item.dataSaida !=
                                      null
                                  ? DateFormat('dd/MM/yyyy hh:mm')
                                      .format(DateTime.parse(item.dataSaida!))
                                      .toString()
                                  : ' - ')),
                        ),
                        DataCell(
                          Center(
                            child: CustomTypography.body14(
                              (item.dataEntrada != null &&
                                      item.dataSaida != null)
                                  ? _formatHoursInUse(item)
                                  : _formatHoursInUse(item),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ).toList())));
  }

  String _formatHoursInUse(item) {
    String hours;
    if (item.dataSaida != null) {
      hours = DateTime.parse(item.dataSaida!)
          .difference(DateTime.parse(item.dataEntrada!))
          .toString();
    } else {
      hours = DateTime.now()
          .difference(DateTime.parse(item.dataEntrada!))
          .toString();
    }
    return hours.split('.')[0];
  }
}
