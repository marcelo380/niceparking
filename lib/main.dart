import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nice_parking/controllers/parking_slot_mobx_ctrl/parking_slot_mobx_ctrl.dart';
import 'package:nice_parking/controllers/report_parking_slots_mobx_ctrl/report_parking_slots_mobx_ctrl.dart';
import 'package:nice_parking/pages/home_page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ParkingSlotMobxCTRL parkingMobxCTRL = ParkingSlotMobxCTRL();
  ReportParkingSlotsMobxCTRL reportParkingSlotsMobxCTRL =
      ReportParkingSlotsMobxCTRL();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  parkingMobxCTRL.init();
                },
                child: const Text("Mostra vagas")),
            ElevatedButton(
                onPressed: () async {
                  parkingMobxCTRL.insertVehicleParkingSlot(
                      numVaga: 2, responsavel: "Marcelo Roberto");
                },
                child: const Text("Entrada vaga")),
            ElevatedButton(
                onPressed: () async {
                  parkingMobxCTRL.removeVehicleSlotParking(numVaga: 2);
                },
                child: const Text("remove da vaga")),
            ElevatedButton(
                onPressed: () async {
                  reportParkingSlotsMobxCTRL.report(
                      startDate: DateTime.now(), endDate: DateTime.now());
                },
                child: const Text("Report")),
            Observer(builder: (_) {
              return Expanded(
                child: ListView.builder(
                    itemCount: parkingMobxCTRL.parkingSlotsList.length,
                    itemBuilder: ((context, index) {
                      return Text(
                        parkingMobxCTRL.parkingSlotsList[index].numVaga
                            .toString(),
                        style: TextStyle(
                            color:
                                parkingMobxCTRL.parkingSlotsList[index].empty!
                                    ? Colors.green
                                    : Colors.red),
                      );
                    })),
              );
            }),
            for (var i = 0; i < 10; i++)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Container(
                      height: 75,
                      decoration: _myBoxDecorationRight(),
                      child: Row(
                        children: [
                          const Center(
                            child: RotatedBox(
                              quarterTurns: 1,
                              child: Text("101"),
                            ),
                          ),
                          Image.asset(
                            'assets/png/car_right.png',
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 75,
                      decoration: _myBoxDecorationLeft(),
                      child: Center(
                        child: Text(
                          "190" + (i++ + 1).toString(),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  BoxDecoration _myBoxDecorationRight() => const BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      );
  BoxDecoration _myBoxDecorationLeft() => const BoxDecoration(
        border: Border(
          left: BorderSide(color: Colors.black),
          //top: BorderSide(color: Colors.black),
          bottom: BorderSide(color: Colors.black),
        ),
      );
}
