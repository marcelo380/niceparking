import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nice_parking/components/contained_button/contained_button.dart';
import 'package:nice_parking/components/date_field/date_field.dart';
import 'package:nice_parking/components/empty_state/empty_state.dart';
import 'package:nice_parking/components/typography/typography.dart';
import 'package:nice_parking/controllers/report_parking_slots_mobx_ctrl/report_parking_slots_mobx_ctrl.dart';
import 'package:nice_parking/utils/consts.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({Key? key}) : super(key: key);

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController startDateTxCTRL = TextEditingController();
  TextEditingController endDateTxCTRL = TextEditingController();
  ReportParkingSlotsMobxCTRL reportParkingSlotsMobxCTRL =
      ReportParkingSlotsMobxCTRL();
  final format = DateFormat("dd/MM/yyyy");
  final outputFormat = DateFormat('MM-dd-yyyy hh:mm');
  DateTime? startDate;
  DateTime? endDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: black2,
        title: const Text("Relatório"),
      ),
      body: _body(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 32),
        child: ContainedButton(
            label: "Gerar relatório",
            onPressed: () async {
              startDate = format.parse(startDateTxCTRL.text);
              endDate = format.parse(endDateTxCTRL.text);
              if (_formKey.currentState!.validate()) {
                await reportParkingSlotsMobxCTRL.report(
                    startDate: startDate!, endDate: endDate!);
              }
            }),
      ),
    );
  }

  Widget _body() => Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20),
          child: Observer(
            builder: (_) => Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: _infoBox(),
                ),
                _dateFields(),
                if (reportParkingSlotsMobxCTRL.emptyState)
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: EmptyState(
                        title: "Preencha os campos",
                        description:
                            "Para gerar relatório selecione uma data de inicio e termino.",
                        icon: Icons.document_scanner_sharp),
                  ),
                if (reportParkingSlotsMobxCTRL.noResults)
                  const Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: EmptyState(
                        title: "Nada para exibir :( ",
                        description:
                            "Parece que não existem dados para as datas selecionadas.",
                        icon: Icons.browser_not_supported_outlined),
                  ),
              ],
            ),
          ),
        ),
      );

  Widget _dateFields() => Column(
        children: [
          CustomDateField(
            label: "Date inicial",
            controller: startDateTxCTRL,
            validator: (value) {
              if (startDateTxCTRL.text.isEmpty) {
                return 'Campo de data inicial obrigatório';
              }

              if (Jiffy(startDate).isAfter(Jiffy(endDate))) {
                return 'O período inicial deve ser antes do final';
              }

              return null;
            },
          ),
          const SizedBox(
            height: 8,
          ),
          CustomDateField(
              label: "Date final",
              controller: endDateTxCTRL,
              validator: (value) {
                if (endDateTxCTRL.text.isEmpty) {
                  return 'Campo de data inicial obrigatório';
                }

                if (Jiffy(endDate).isBefore(Jiffy(startDate))) {
                  return 'O período final deve ser depois do inicial';
                }

                return null;
              }),
        ],
      );

  Widget _infoBox() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.info,
            color: greenPrimary1,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              child: CustomTypography.title14(
                "Digite um intervalo de data para buscar.",
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ],
      );
}
