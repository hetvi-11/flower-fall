import 'package:flutter/material.dart';

class DateProvider with ChangeNotifier{
 List<DateTime> _blackoutDates = [];
 List<DateTime> _selectedListDates = [];

  void getBlackDateList(List<DateTime> blackOutDates){
    _blackoutDates = blackOutDates;
    notifyListeners();
  }

 void getSelectedDateList(List<DateTime> selectedDatesList){
   _selectedListDates = selectedDatesList;
   notifyListeners();
 }

 List<DateTime> setSelectedDateList(){
   return _selectedListDates;
 }

 List<DateTime>  setBlackDateList(){
   return _blackoutDates;
 }

}