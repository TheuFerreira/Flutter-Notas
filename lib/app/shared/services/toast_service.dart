import 'package:fluttertoast/fluttertoast.dart';

class ToastService {
  static void showToast(String message) {
    Fluttertoast.showToast(msg: message);
  }
}
