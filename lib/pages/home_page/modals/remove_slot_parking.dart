import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nice_parking/components/confirm_dialog/alert_dialog.dart';
import 'package:nice_parking/components/contained_button/contained_button.dart';
import 'package:nice_parking/components/typography/typography.dart';
import 'package:nice_parking/controllers/parking_slot_mobx_ctrl/parking_slot_mobx_ctrl.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:nice_parking/utils/consts.dart';

class ModalRemoveParkingSlot extends StatelessWidget {
  final ParkingModel parkingModel;
  final ParkingSlotMobxCTRL parkingSlotMobxCTRL;
  const ModalRemoveParkingSlot(
      {required this.parkingSlotMobxCTRL, required this.parkingModel, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController plateTxCTRL = TextEditingController();
    Size _size = MediaQuery.of(context).size;

    return Material(
      child: CupertinoPageScaffold(
        backgroundColor: black2,
        navigationBar: CupertinoNavigationBar(
          backgroundColor: black2,
          middle: CustomTypography.title20("Finalizar uso da vaga"),
        ),
        child: _body(context, _size, plateTxCTRL, _formKey),
      ),
    );
  }

  _body(BuildContext context, Size _size, TextEditingController plateTxCTRL,
          _formKey) =>
      Form(
        key: _formKey,
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: _size.height / 3,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0, right: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: Center(
                            child: CustomTypography.title28(
                                "Vaga: ${parkingModel.numVaga}",
                                color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Center(
                            child: CustomTypography.title28(
                                "Placa: ${parkingModel.placa}",
                                color: Colors.white)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Center(
                            child: CustomTypography.title14(
                                "Tempo estacionado: ${Jiffy(parkingModel.dataEntrada).fromNow()}",
                                color: Colors.white)),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32.0),
                    child: Center(
                      child: SizedBox(
                          width: _size.width - 40,
                          child: ContainedButton(
                            label: "Finalizar vaga",
                            overideColor: Colors.red,
                            onPressed: () =>
                                _submitForm(context, plateTxCTRL, _formKey),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  Future _submitForm(
      BuildContext context, TextEditingController plateTxCTRL, _formKey) async {
    bool _res = await showAlertDialog(
        context: context,
        title: "Finalizar vaga",
        content: "Placa ${parkingModel.placa}",
        defaultActionText: "Confirmar",
        cancelActionText: "Cancelar");

    if (_res) {
      await parkingSlotMobxCTRL.removeVehicleSlotParking(
          numVaga: parkingModel.numVaga!);
      Navigator.pop(context);
    }
  }
}
