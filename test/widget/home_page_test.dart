import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobx/mobx.dart';
import 'package:nice_parking/components/parking_slot_component/parking_slot_component.dart';
import 'package:nice_parking/controllers/parking_slot_mobx_ctrl/parking_slot_mobx_ctrl.dart';
import 'package:nice_parking/models/parking_model.dart';
import 'package:nice_parking/pages/home_page/home_page.dart';

import '../fixtures.dart';

main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  testWidgets('🔏 Testar componente de vaga [NORMAL]',
      (WidgetTester tester) async {
    ParkingSlotMobxCTRL parkingSlotMobxCTRL = ParkingSlotMobxCTRL();

    vagasListJson.forEach((element) {
      parkingSlotMobxCTRL.parkingSlotsList
          .add(ParkingModel.fromMap(json.decode(element)));
    });
    var app = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: ParkingSlotComponent(
            index: 1,
            lengthList: 10,
            onTap: () {},
            parkingSlotMobxCTRL: parkingSlotMobxCTRL,
          ),
        ));
    await tester.pumpWidget(app);

    Finder slotContainer = find.byKey(const Key('slotContainer'));
    expect(slotContainer, findsOneWidget);
  });

  testWidgets('🔏 Testar componente de vaga [EM USO]',
      (WidgetTester tester) async {
    ParkingSlotMobxCTRL parkingSlotMobxCTRL = ParkingSlotMobxCTRL();

    vagasListJson.forEach((element) {
      parkingSlotMobxCTRL.parkingSlotsList
          .add(ParkingModel.fromMap(json.decode(element)));
    });

    parkingSlotMobxCTRL.parkingSlotsList[0].empty = true;
    var app = MediaQuery(
        data: const MediaQueryData(),
        child: MaterialApp(
          home: ParkingSlotComponent(
            index: 1,
            lengthList: 10,
            onTap: () {},
            parkingSlotMobxCTRL: parkingSlotMobxCTRL,
          ),
        ));
    await tester.pumpWidget(app);

    Finder slotContainer = find.byKey(const Key('emptySvg'));
    expect(slotContainer, findsOneWidget);
  });
}
