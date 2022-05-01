import 'package:flutter/material.dart';

class CreateTaskScreenViewModel with ChangeNotifier
{
  DateTime? dateFrom, dateTo;
  final List<String> _tags = ["CRM", "Dynamics 365", "Figma", "Flutter"];
  final List<String> _myTags = [];

  String? _selectedTag;

  List<String> get tags => _tags;
  List<String> get myTags => _myTags;

  String? get selectedTag => _selectedTag;

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

  void setMyTag(String tag)
  {
    _myTags.add(tag);
    _selectedTag = tag;
    notifyListeners();
  }

  void addNewTag(String tag)
  {
    _myTags.add(tag);
    notifyListeners();
  }

  void removeTag(String tag)
  {
    _myTags.remove(tag);
    notifyListeners();
  }
}