import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nice_parking/controllers/parking_slot_mobx_ctrl/parking_slot_mobx_ctrl.dart';

class ParkingSlotComponent extends StatelessWidget {
  final ParkingSlotMobxCTRL parkingSlotMobxCTRL;
  final int index;
  final int lengthList;
  final VoidCallback onTap;
  const ParkingSlotComponent(
      {required this.parkingSlotMobxCTRL,
      required this.index,
      required this.lengthList,
      required this.onTap,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        key: const Key("slotContainer"),
        decoration: index % 2 == 0
            ? _myBoxDecorationRight(index, lengthList)
            : _myBoxDecorationLeft(index, lengthList),
        child: index % 2 == 0
            ? makeSlotParkingRight(index)
            : makeSlotParkingLeft(index),
      ),
    );
  }

  Widget makeSlotParkingRight(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          if (parkingSlotMobxCTRL.parkingSlotsList[index].empty!)
            SvgPicture.asset(
              'assets/svg/rectangle_slot.svg',
              key: const Key("emptySvg"),
              width: 130,
            ),
          if (!parkingSlotMobxCTRL.parkingSlotsList[index].empty!)
            Image.asset(
              'assets/png/car_right.png',
            )
        ],
      );

  Widget makeSlotParkingLeft(int index) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (parkingSlotMobxCTRL.parkingSlotsList[index].empty!)
            SvgPicture.asset(
              'assets/svg/rectangle_slot.svg',
              width: 130,
              key: const Key("emptySvg"),
            ),
          if (!parkingSlotMobxCTRL.parkingSlotsList[index].empty!)
            Image.asset(
              'assets/png/car_left.png',
            ),
          RotatedBox(
            quarterTurns: 3,
            child: Text(
              (index + 1).toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      );

  BoxDecoration _myBoxDecorationRight(int indexList, int lengthList) {
    if (indexList == lengthList - 2) {
      return const BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white),
        ),
      );
    } else {
      return const BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white),
          bottom: BorderSide(color: Colors.white),
        ),
      );
    }
  }

  BoxDecoration _myBoxDecorationLeft(int indexList, int lengthList) {
    if (indexList == lengthList - 1) {
      return const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.white),
        ),
      );
    } else {
      return const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.white),
          bottom: BorderSide(color: Colors.white),
        ),
      );
    }
  }
}
