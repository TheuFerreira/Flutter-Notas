import 'dart:async';

class NoteItemBloc {
  bool _isSelected = false;

  final StreamController<bool> _streamController = StreamController<bool>();
  Stream<bool> get isSelected => _streamController.stream;

  void changeSelection() {
    _isSelected = !_isSelected;
    _streamController.add(_isSelected);
  }
}
