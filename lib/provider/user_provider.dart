import 'package:flower_fall/database/database_manager.dart';
import 'package:flower_fall/model/period_model.dart';
import 'package:flutter/material.dart';

class UserProvider with ChangeNotifier {
  UserProvider({required this.user});
  PeriodUser user;

  Future<int> addUser() async {
    var database = DatabaseManager.instance;
    if (database != null) {
      print("in if");
      int readUser = await database.addUser(user, 'user');
      user.id = readUser;
      print(readUser);
      notifyListeners();
      return readUser;
    }
    return 0;
  }

  Future<bool> isExists(String email) async {
    var database = DatabaseManager.instance;
    var dbexists = await database.userExists(email);
    print(dbexists);
    if (dbexists > 0) {
      return true;
    }
    return false;
  }

  void updateCycle(
      {required String? cycleLength, required String? periodLength}) async {
    var database = DatabaseManager.instance;
    var updateCycle = await database.updateCycle(
        id: user.id, cycleLength: cycleLength, periodLength: periodLength);
    print(user.toJson());
    print(updateCycle);
    notifyListeners();
  }

  void updateUserBasic() async {
    print(user.toJson());
    var database = DatabaseManager.instance;
    var update = await database.updateUserBasic(
        id: user.id,
        image: user.image,
        name: user.name,
        dob: user.dob,
        weight: user.weight);
    print(update);
    notifyListeners();
  }

  void updateUserCycle() async {
    print(user.toJson());
    var database = DatabaseManager.instance;
    var update = await database.updateUserCycle(
        id: user.id,
        cycleLength: user.cycleLength,
        periodLength: user.periodLength);
    print(update);
    notifyListeners();
  }

  void updateUserSelectedDate() async {
    print(user.toJson());
    var database = DatabaseManager.instance;
    var update = await database.updateUserSelectedDate(
        id: user.id, selectedDate: user.selectedDate);
    print(update);
    notifyListeners();
  }

  Future<PeriodUser> readUserByEmail() async {
    var database = DatabaseManager.instance;
    var read = await database.readUserByEmail(email: user.email!);
    user = read;
    notifyListeners();
    return read;
  }

  Future<String> readPeriodLength() async {
    var database = DatabaseManager.instance;
    var read = await database.readPeriodLength(user.id!);
    notifyListeners();
    return read;
  }

  Future<String> readCycleLength() async {
    var database = DatabaseManager.instance;
    var read = await database.readCycleLength(user.id!);
    notifyListeners();
    return read;
  }

  Future<String> readImage() async {
    var database = DatabaseManager.instance;
    var read = await database.readImage(user.id!);
    notifyListeners();
    return read;
  }

  Future<PeriodUser> readUserById({required int userid}) async {
    var database = DatabaseManager.instance;
    var read = await database.readUser(id: userid);
    print(read);
    user = read;
    notifyListeners();
    return read;
  }

  void reset(
      {bool clearCycle = true,
      bool clearEmail = true,
      bool clearName = true,
      bool clearDOB = true,
      bool clearWeight = true}) {
    user = PeriodUser(
        cycleLength: clearCycle ? null : user.cycleLength,
        periodLength: clearCycle ? null : user.periodLength,
        name: clearName ? null : user.name,
        email: clearEmail ? null : user.email,
        dob: clearDOB ? null : user.dob,
        weight: clearWeight ? null : user.weight);
    notifyListeners();
  }
}
