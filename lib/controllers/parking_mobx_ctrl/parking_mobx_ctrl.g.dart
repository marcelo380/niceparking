// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_mobx_ctrl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ParkingMobxCTRL on _ParkingMobxCTRLBase, Store {
  late final _$parkingSlotsListAtom =
      Atom(name: '_ParkingMobxCTRLBase.parkingSlotsList', context: context);

  @override
  ObservableList<ParkingModel> get parkingSlotsList {
    _$parkingSlotsListAtom.reportRead();
    return super.parkingSlotsList;
  }

  @override
  set parkingSlotsList(ObservableList<ParkingModel> value) {
    _$parkingSlotsListAtom.reportWrite(value, super.parkingSlotsList, () {
      super.parkingSlotsList = value;
    });
  }

  @override
  String toString() {
    return '''
parkingSlotsList: ${parkingSlotsList}
    ''';
  }
}
