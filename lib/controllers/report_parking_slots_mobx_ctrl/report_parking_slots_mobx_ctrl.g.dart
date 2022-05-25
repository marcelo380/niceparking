// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_parking_slots_mobx_ctrl.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReportParkingSlotsMobxCTRL on _ReportParkingSlotsMobxCTRLBase, Store {
  Computed<bool>? _$emptyStateComputed;

  @override
  bool get emptyState =>
      (_$emptyStateComputed ??= Computed<bool>(() => super.emptyState,
              name: '_ReportParkingSlotsMobxCTRLBase.emptyState'))
          .value;
  Computed<bool>? _$showSkeletonComputed;

  @override
  bool get showSkeleton =>
      (_$showSkeletonComputed ??= Computed<bool>(() => super.showSkeleton,
              name: '_ReportParkingSlotsMobxCTRLBase.showSkeleton'))
          .value;

  late final _$parkinReportListAtom = Atom(
      name: '_ReportParkingSlotsMobxCTRLBase.parkinReportList',
      context: context);

  @override
  ObservableList<ParkingModel> get parkinReportList {
    _$parkinReportListAtom.reportRead();
    return super.parkinReportList;
  }

  @override
  set parkinReportList(ObservableList<ParkingModel> value) {
    _$parkinReportListAtom.reportWrite(value, super.parkinReportList, () {
      super.parkinReportList = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: '_ReportParkingSlotsMobxCTRLBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  @override
  String toString() {
    return '''
parkinReportList: ${parkinReportList},
isLoading: ${isLoading},
emptyState: ${emptyState},
showSkeleton: ${showSkeleton}
    ''';
  }
}
