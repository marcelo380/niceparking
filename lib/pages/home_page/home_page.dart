import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:nice_parking/components/parking_slot_component/parking_slot_component.dart';
import 'package:nice_parking/controllers/parking_slot_mobx_ctrl/parking_slot_mobx_ctrl.dart';
import 'package:nice_parking/pages/home_page/modals/register_slot_parking.dart';
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
    int _lengthList = parkingMobxCTRL!.parkingSlotsList.length;
    return Scaffold(
      backgroundColor: black2,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: black2,
        title: const Text("Parking slots"),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Center(
              child: Text("3/10", style: TextStyle(fontSize: 18)),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        parkingMobxCTRL!.insertVehicleParkingSlot(
            numVaga: 5, responsavel: "Marcelo Roberto");
      }),
      body: Observer(builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
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
                  await showBarModalBottomSheet(
                    expand: false,
                    context: context,
                    backgroundColor: Colors.transparent,
                    builder: (context) => ModalRegisterParkingSlot(
                        parkingModel: parkingMobxCTRL!.parkingSlotsList[index]),
                  );
                },
              );
            },
          ),
        );
      }),
    );
  }
}
