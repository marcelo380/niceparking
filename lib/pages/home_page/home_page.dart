import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:jiffy/jiffy.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nice_parking/components/contained_button/contained_button.dart';
import 'package:nice_parking/components/parking_slot_component/parking_slot_component.dart';
import 'package:nice_parking/components/typography/typography.dart';
import 'package:nice_parking/controllers/parking_slot_mobx_ctrl/parking_slot_mobx_ctrl.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:nice_parking/pages/home_page/modals/register_slot_parking.dart';
import 'package:nice_parking/pages/home_page/modals/remove_slot_parking.dart';
import 'package:nice_parking/pages/report/report_page.dart';
import 'package:nice_parking/utils/consts.dart';

class HomePage extends StatefulWidget {
  final ParkingSlotMobxCTRL? mockParkingSlotMobxCTRL;
  const HomePage({this.mockParkingSlotMobxCTRL, Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ParkingSlotMobxCTRL? parkingMobxCTRL;

  @override
  void initState() {
    if (widget.mockParkingSlotMobxCTRL == null) {
      parkingMobxCTRL = ParkingSlotMobxCTRL();
    } else {
      parkingMobxCTRL = widget.mockParkingSlotMobxCTRL!;
    }

    parkingMobxCTRL!.init();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Jiffy.locale("pt");
    int _lengthList = parkingMobxCTRL!.parkingSlotsList.length;
    return Scaffold(
      backgroundColor: black2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: black2,
        title: const Text("Nice Parking"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Center(
              child: Observer(
                builder: (_) => Text(
                  _slotsInUse(),
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
        ],
      ),
      body: Observer(builder: (_) {
        return Column(
          children: [
            _infoBox(),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: GridView.builder(
                  itemCount: parkingMobxCTRL!.parkingSlotsList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 2,
                  ),
                  itemBuilder: (
                    context,
                    index,
                  ) {
                    return ParkingSlotComponent(
                      index: index,
                      lengthList: _lengthList,
                      parkingSlotMobxCTRL: parkingMobxCTRL!,
                      onTap: () async {
                        if (parkingMobxCTRL!.parkingSlotsList[index].empty!) {
                          await _showModal(
                            ModalRegisterParkingSlot(
                                parkingSlotMobxCTRL: parkingMobxCTRL!,
                                parkingModel:
                                    parkingMobxCTRL!.parkingSlotsList[index]),
                          );
                        } else {
                          await _showModal(
                            ModalRemoveParkingSlot(
                                parkingSlotMobxCTRL: parkingMobxCTRL!,
                                parkingModel:
                                    parkingMobxCTRL!.parkingSlotsList[index]),
                          );
                          setState(() {});
                        }
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 32),
        child: ContainedButton(
          label: "Gerar relatório do dia",
          onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const ReportPage())),
        ),
      ),
    );
  }

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
                "Para registrar ou remover um veículo basta clicar na vaga desejada.",
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ),
        ],
      );

  _showModal(modal) async => await showBarModalBottomSheet(
        expand: false,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => modal,
      );

  String _slotsInUse() {
    List<ParkingModel> _parkingSlotsList = parkingMobxCTRL!.parkingSlotsList;
    if (parkingMobxCTRL!.parkingSlotsList.isNotEmpty) {
      int _slotCount = _parkingSlotsList
          .where((element) => element.empty == false)
          .toList()
          .length;
      return "$_slotCount/${mockVagas.length}";
    } else {
      return "0/0";
    }
  }
}
