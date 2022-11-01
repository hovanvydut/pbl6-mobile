import 'package:fluttertoast/fluttertoast.dart';

class ToastHelper {
  static void showToast(String message) {
    Fluttertoast.cancel();
    Fluttertoast.showToast(msg: message);
  }
}
