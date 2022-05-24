import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:nice_parking/controllers/parking_mobx_ctrl/parking_mobx_ctrl.dart';
import 'package:nice_parking/interfaces/parking_repository.dart';
import 'package:nice_parking/models/parking_model.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
                  ParkingMobxCTRL parkingMobxCTRL = ParkingMobxCTRL();
                  parkingMobxCTRL.fetchParkingSpacesList();
                },
                child: Text("E dale teste"))
            // for (var i = 0; i < 10; i++)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: <Widget>[
            //       Expanded(
            //         child: Container(
            //           height: 75,
            //           decoration: _myBoxDecorationRight(),
            //           child: Center(
            //             child: Text(
            //               '190$i',
            //               style: const TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 30,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 1,
            //         child: Container(
            //           height: 75,
            //           decoration: _myBoxDecorationLeft(),
            //           child: Center(
            //             child: Text(
            //               "190" + (i++ + 1).toString(),
            //               style: const TextStyle(
            //                 color: Colors.black,
            //                 fontSize: 30,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
