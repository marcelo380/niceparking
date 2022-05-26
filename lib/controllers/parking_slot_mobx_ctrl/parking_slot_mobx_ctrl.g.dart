// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking_slot_mobx_ctrl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ParkingSlotMobxCTRL on _ParkingSlotMobxCTRLBase, Store {
  late final _$parkingSlotsListAtom =
      Atom(name: '_ParkingSlotMobxCTRLBase.parkingSlotsList', context: context);

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

  late final _$initAsyncAction =
      AsyncAction('_ParkingSlotMobxCTRLBase.init', context: context);

  @override
  Future init() {
    return _$initAsyncAction.run(() => super.init());
  }

  late final _$insertVehicleParkingSlotAsyncAction = AsyncAction(
      '_ParkingSlotMobxCTRLBase.insertVehicleParkingSlot',
      context: context);

  @override
  Future<bool> insertVehicleParkingSlot(
      {required int numVaga, required String placa}) {
    return _$insertVehicleParkingSlotAsyncAction.run(
        () => super.insertVehicleParkingSlot(numVaga: numVaga, placa: placa));
  }

  late final _$removeVehicleSlotParkingAsyncAction = AsyncAction(
      '_ParkingSlotMobxCTRLBase.removeVehicleSlotParking',
      context: context);

  @override
  Future removeVehicleSlotParking({required int numVaga}) {
    return _$removeVehicleSlotParkingAsyncAction
        .run(() => super.removeVehicleSlotParking(numVaga: numVaga));
  }

  @override
  String toString() {
    return '''
parkingSlotsList: ${parkingSlotsList}
    ''';
  }
}
