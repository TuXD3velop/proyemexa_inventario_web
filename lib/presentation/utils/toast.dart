/*
██╗   ██╗████████╗██╗██╗     ██╗██████╗  █████╗ ██████╗ ███████╗███████╗    ████████╗ ██████╗  █████╗ ███████╗████████╗
██║   ██║╚══██╔══╝██║██║     ██║██╔══██╗██╔══██╗██╔══██╗██╔════╝██╔════╝    ╚══██╔══╝██╔═══██╗██╔══██╗██╔════╝╚══██╔══╝
██║   ██║   ██║   ██║██║     ██║██║  ██║███████║██║  ██║█████╗  ███████╗       ██║   ██║   ██║███████║███████╗   ██║
██║   ██║   ██║   ██║██║     ██║██║  ██║██╔══██║██║  ██║██╔══╝  ╚════██║       ██║   ██║   ██║██╔══██║╚════██║   ██║
╚██████╔╝   ██║   ██║███████╗██║██████╔╝██║  ██║██████╔╝███████╗███████║       ██║   ╚██████╔╝██║  ██║███████║   ██║
 ╚═════╝    ╚═╝   ╚═╝╚══════╝╚═╝╚═════╝ ╚═╝  ╚═╝╚═════╝ ╚══════╝╚══════╝       ╚═╝    ╚═════╝ ╚═╝  ╚═╝╚══════╝   ╚═╝

*/

//Toast success
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void toastSuccess(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 2,
    webPosition: 'center',
    webBgColor: "linear-gradient(to right, #28a745, #28a745)",
    textColor: Colors.white,
    fontSize: 20.0,
  );
}

//Toast Warning

void toastWarning(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 3,
    webPosition: 'center',
    webBgColor: "linear-gradient(to right, #ffc107, #ffc107)",
    textColor: Colors.white,
    fontSize: 20.0,
  );
}

//Toast Error
void toastError(String msg) {
  Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 3,
    webPosition: 'center',
    webBgColor: "linear-gradient(to right, #dc3545, #dc3545)",
    textColor: Colors.white,
    fontSize: 20.0,
  );
}
