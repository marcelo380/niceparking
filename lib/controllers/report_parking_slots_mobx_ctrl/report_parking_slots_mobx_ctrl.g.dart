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
  Computed<bool>? _$noResultsComputed;

  @override
  bool get noResults =>
      (_$noResultsComputed ??= Computed<bool>(() => super.noResults,
              name: '_ReportParkingSlotsMobxCTRLBase.noResults'))
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

  late final _$_noResultsAtom = Atom(
      name: '_ReportParkingSlotsMobxCTRLBase._noResults', context: context);

  @override
  bool get _noResults {
    _$_noResultsAtom.reportRead();
    return super._noResults;
  }

  @override
  set _noResults(bool value) {
    _$_noResultsAtom.reportWrite(value, super._noResults, () {
      super._noResults = value;
    });
  }

  late final _$_ReportParkingSlotsMobxCTRLBaseActionController =
      ActionController(
          name: '_ReportParkingSlotsMobxCTRLBase', context: context);

  @override
  void setNoResults(bool value) {
    final _$actionInfo = _$_ReportParkingSlotsMobxCTRLBaseActionController
        .startAction(name: '_ReportParkingSlotsMobxCTRLBase.setNoResults');
    try {
      return super.setNoResults(value);
    } finally {
      _$_ReportParkingSlotsMobxCTRLBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
parkinReportList: ${parkinReportList},
emptyState: ${emptyState},
noResults: ${noResults}
    ''';
  }
}
