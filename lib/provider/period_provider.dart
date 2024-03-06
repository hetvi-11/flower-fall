import 'package:flower_fall/database/database_manager.dart';
import 'package:flower_fall/model/period_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PeriodProvider with ChangeNotifier {
  PeriodProvider({required this.period});
  Period period;

  void addPeriod() async {
    var database = DatabaseManager.instance;
    var add = await database.addPeriod(period, 'period');
    if (add != 0) {
      period.id = add;
      addPeriodIntToSF() async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setInt('intPeriodValue', period.id!);
      }
      print('stored user id from sf is ${addPeriodIntToSF()}');
    }
    print(add);
    notifyListeners();
  }

  /// GET ALL PERIOD BY NO FLOW
  Future<List<DateTime>> getAllPeriodByNoFlow({required String flow, required int userId})async{
    var database = DatabaseManager.instance;
    var get = await database.readAllByNoFLow(flow: flow, userId: userId);
    return get;
  }
  ///GET ALL PERIOD BY FLOW
  Future<List<DateTime>> getAllPeriodByFlow({required String flow, required int userId})async{
    var database = DatabaseManager.instance;
    var get = await database.readAllByFLow(flow: flow, userId: userId);
    return get;
  }

  Future<bool> existsChosenDetails({required int userId, required DateTime chosen}) async{
    var database = DatabaseManager.instance;
    var exists = await database.existsChosenDetails(id: userId, chosenDate: chosen);
    return exists;
  }

  Future<Period> readPeriod(
      {required int userId, required DateTime chosenDate}) async {
    print('read period by userid and chosenDate');
    var database = DatabaseManager.instance;
    var read = await database.readPeriod(userId, chosenDate);
    period = read;
    print(read);
    return read;
  }

  Future<Period> readPeriodById({required int id}) async {
    var database = DatabaseManager.instance;
    var read = await database.readPeriodById(id: id);
    print(read);
    period = read;
    notifyListeners();
    return read;
  }

  void readAll() async {
    var database = DatabaseManager.instance;
    var read = await database.readAll();
    print(read);
  }

  Future<int> updatePeriodData({
    required int userId,
    required DateTime chosenDate,
    String? flow,
    String? flowImage,
    String? currentWeight,
    String? weightImage,
    String? sleep,
    String? sleepImage,
    String? mood,
    String? moodImage,
    String? symptoms,
    String? symptomImage,
  }) async {
    var database = DatabaseManager.instance;
    var update = await database.updatePeriodData(
        userId: userId,
        chosenDate: chosenDate,
        flow: flow,
        flowImage: flowImage,
        currentWeight: currentWeight,
        weightImage: weightImage,
        sleep: sleep,
        sleepImage: sleepImage,
        mood: mood,
        moodImage: moodImage,
        symptoms: symptoms,
        symptomsImage: symptomImage);
    print('...........provider update $update');
    if(update != 0){
      period.userid = userId;
      period.chosenDate = chosenDate;
      period.flow = flow;
      period.flowImage = flowImage;
      period.currentWeight = currentWeight;
      period.weightImage = weightImage;
      period.sleep = sleep;
      period.sleepImage = sleepImage;
      period.mood = mood;
      period.moodImage = moodImage;
      period.symptoms = symptoms;
      period.symptomsImage = symptomImage;
      notifyListeners();
    }
    return update;
  }

  void reset() {
    period = Period();
    notifyListeners();
  }
}
