// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'parking.controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ParkingController on ParkingControllerBase, Store {
  final _$selectedFloorAtom = Atom(name: 'ParkingControllerBase.selectedFloor');

  @override
  String get selectedFloor {
    _$selectedFloorAtom.reportRead();
    return super.selectedFloor;
  }

  @override
  set selectedFloor(String value) {
    _$selectedFloorAtom.reportWrite(value, super.selectedFloor, () {
      super.selectedFloor = value;
    });
  }

  final _$selectedLetterAtom =
      Atom(name: 'ParkingControllerBase.selectedLetter');

  @override
  String get selectedLetter {
    _$selectedLetterAtom.reportRead();
    return super.selectedLetter;
  }

  @override
  set selectedLetter(String value) {
    _$selectedLetterAtom.reportWrite(value, super.selectedLetter, () {
      super.selectedLetter = value;
    });
  }

  final _$selectedNumberAtom =
      Atom(name: 'ParkingControllerBase.selectedNumber');

  @override
  String get selectedNumber {
    _$selectedNumberAtom.reportRead();
    return super.selectedNumber;
  }

  @override
  set selectedNumber(String value) {
    _$selectedNumberAtom.reportWrite(value, super.selectedNumber, () {
      super.selectedNumber = value;
    });
  }

  final _$codeAtom = Atom(name: 'ParkingControllerBase.code');

  @override
  String get code {
    _$codeAtom.reportRead();
    return super.code;
  }

  @override
  set code(String value) {
    _$codeAtom.reportWrite(value, super.code, () {
      super.code = value;
    });
  }

  final _$timeStampAtom = Atom(name: 'ParkingControllerBase.timeStamp');

  @override
  String get timeStamp {
    _$timeStampAtom.reportRead();
    return super.timeStamp;
  }

  @override
  set timeStamp(String value) {
    _$timeStampAtom.reportWrite(value, super.timeStamp, () {
      super.timeStamp = value;
    });
  }

  final _$showSaveButtonAtom =
      Atom(name: 'ParkingControllerBase.showSaveButton');

  @override
  bool get showSaveButton {
    _$showSaveButtonAtom.reportRead();
    return super.showSaveButton;
  }

  @override
  set showSaveButton(bool value) {
    _$showSaveButtonAtom.reportWrite(value, super.showSaveButton, () {
      super.showSaveButton = value;
    });
  }

  final _$ParkingControllerBaseActionController =
      ActionController(name: 'ParkingControllerBase');

  @override
  void setCode(String value) {
    final _$actionInfo = _$ParkingControllerBaseActionController.startAction(
        name: 'ParkingControllerBase.setCode');
    try {
      return super.setCode(value);
    } finally {
      _$ParkingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTimeStamp(String value) {
    final _$actionInfo = _$ParkingControllerBaseActionController.startAction(
        name: 'ParkingControllerBase.setTimeStamp');
    try {
      return super.setTimeStamp(value);
    } finally {
      _$ParkingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowSaveButton(bool value) {
    final _$actionInfo = _$ParkingControllerBaseActionController.startAction(
        name: 'ParkingControllerBase.setShowSaveButton');
    try {
      return super.setShowSaveButton(value);
    } finally {
      _$ParkingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFloor(String value) {
    final _$actionInfo = _$ParkingControllerBaseActionController.startAction(
        name: 'ParkingControllerBase.setFloor');
    try {
      return super.setFloor(value);
    } finally {
      _$ParkingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setLetter(String value) {
    final _$actionInfo = _$ParkingControllerBaseActionController.startAction(
        name: 'ParkingControllerBase.setLetter');
    try {
      return super.setLetter(value);
    } finally {
      _$ParkingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setNumber(String value) {
    final _$actionInfo = _$ParkingControllerBaseActionController.startAction(
        name: 'ParkingControllerBase.setNumber');
    try {
      return super.setNumber(value);
    } finally {
      _$ParkingControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
selectedFloor: ${selectedFloor},
selectedLetter: ${selectedLetter},
selectedNumber: ${selectedNumber},
code: ${code},
timeStamp: ${timeStamp},
showSaveButton: ${showSaveButton}
    ''';
  }
}
