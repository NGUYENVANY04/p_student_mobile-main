import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeVM extends ChangeNotifier{
  String getFormattedDate() {
  DateTime now = DateTime.now();
  String formattedDate = DateFormat('dd/MM/yyyy').format(now);
  return formattedDate;
}
}