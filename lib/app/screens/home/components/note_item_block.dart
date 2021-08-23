import 'dart:async';

import 'package:intl/intl.dart';

class NoteItemBloc {
  bool _isSelected = false;
  late String lastModify;

  final StreamController<bool> _streamController = StreamController<bool>();
  Stream<bool> get isSelected => _streamController.stream;

  NoteItemBloc(DateTime date) {
    DateFormat df = DateFormat('dd/MM/yyyy');
    String now = df.format(DateTime.now());
    String yesterday = df.format(DateTime.now().subtract(Duration(days: 1)));
    String dateNote = df.format(date);
    if (now == dateNote) {
      lastModify = 'Hoje';
    } else if (yesterday == dateNote) {
      lastModify = 'Ontem';
    } else {
      lastModify = dateNote;
    }
  }

  void changeSelection() {
    _isSelected = !_isSelected;
    _streamController.add(_isSelected);
  }
}
