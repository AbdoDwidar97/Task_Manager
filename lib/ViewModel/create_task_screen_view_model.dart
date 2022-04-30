import 'package:flutter/material.dart';

class CreateTaskScreenViewModel with ChangeNotifier
{
  DateTime? dateFrom, dateTo;

  void setDateTimeFrom(DateTime from)
  {
    dateFrom = from;
    notifyListeners();
  }

  void setDateTimeTo(DateTime to)
  {
    dateTo = to;
    notifyListeners();
  }

}