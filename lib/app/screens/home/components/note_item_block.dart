import 'package:intl/intl.dart';

class NoteItemBloc {
  late String lastModify;

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
}
