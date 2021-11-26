import 'dart:async';

import 'package:rxdart/rxdart.dart';

class GroupItemBloc {
  bool _isSelected = false;

  final _streamSelected = BehaviorSubject<bool>();
  Stream<bool> get isSelected => _streamSelected.stream;

  void setSelection(bool value) {
    _isSelected = value;
    _streamSelected.add(_isSelected);
  }

  void changeSelection() {
    _isSelected = !_isSelected;
    _streamSelected.add(_isSelected);
  }
}
