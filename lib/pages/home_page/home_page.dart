import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nice_parking/components/parking_slot_component/parking_slot_component.dart';
import 'package:nice_parking/controllers/parking_slot_mobx_ctrl/parking_slot_mobx_ctrl.dart';
import 'package:nice_parking/utils/consts.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ParkingSlotMobxCTRL parkingMobxCTRL = ParkingSlotMobxCTRL();

  @override
  void initState() {
    parkingMobxCTRL.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int _lengthList = parkingMobxCTRL.parkingSlotsList.length;
    return Scaffold(
      backgroundColor: customBlack,
      appBar: AppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => parkingMobxCTRL.insertVehicleParkingSlot(
            numVaga: 5, responsavel: "Marcelo Roberto"),
      ),
      body: Observer(builder: (_) {
        return GridView.builder(
          itemCount: parkingMobxCTRL.parkingSlotsList.length,
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
              parkingSlotMobxCTRL: parkingMobxCTRL,
              onTap: () => print('teste'),
            );
          },
        );
      }),
    );
  }
}
