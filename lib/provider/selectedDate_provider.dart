import 'package:flutter/material.dart';
import 'package:flower_fall/database/database_manager.dart';
import 'package:flower_fall/model/period_model.dart';

class SelectedDateProvider with ChangeNotifier{
  SelectedDateProvider({required this.date});
  Dates date;

  Future<int> addSelectedDate()async{
    var database = DatabaseManager.instance;
    int addSelectedDate = await database.addSelectedDate(date, 'date');
    // date.id = addSelectedDate;
    notifyListeners();
    return addSelectedDate;
  }

  Future<List<DateTime>> readAllDateById({required int userId})async{
    var database = DatabaseManager.instance;
    List<DateTime> result = await database.readAllDateById(userId: userId);
    notifyListeners();
    return result;
  }

  void reset() {
    date = Dates();
    notifyListeners();
  }

}