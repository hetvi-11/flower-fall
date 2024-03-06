import 'dart:developer';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flower_fall/model/period_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseManager {
  static final table = 'period';
  static final usertable = 'user';
  static final dateTable = 'date';
  static final _dbName = "Database1.db";
  // Use this class as a singleton
  DatabaseManager._privateConstructor();
  static final DatabaseManager instance = DatabaseManager._privateConstructor();
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Creates and opens the database.
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Creates the database structure
  Future _onCreate(
    Database db,
    int version,
  ) async {
    await db.execute('''
    CREATE TABLE $usertable(
    ${UserFields.id} INTEGER PRIMARY KEY AUTOINCREMENT,
    ${UserFields.email} TEXT UNIQUE,
    ${UserFields.name} TEXT,
    ${UserFields.image} TEXT,
    ${UserFields.dob} DATETIME,
    ${UserFields.cycleLength} TEXT,
    ${UserFields.periodLength} TEXT,
    ${UserFields.selectedDate} DATETIME,
    ${UserFields.weight} TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE $table(
    ${PeriodFields.id} INTEGER PRIMARY KEY,
    ${PeriodFields.userid} INTEGER,
    ${PeriodFields.chosenDate} DATETIME,
    ${PeriodFields.flow} TEXT,
    ${PeriodFields.flowImage} TEXT,
    ${PeriodFields.currentWeight} TEXT,
    ${PeriodFields.weightImage} TEXT,
    ${PeriodFields.sleep} TEXT,
    ${PeriodFields.sleepImage} TEXT,
    ${PeriodFields.mood} TEXT,
    ${PeriodFields.moodImage} TEXT,
    ${PeriodFields.symptoms} TEXT,
    ${PeriodFields.symptomsImage} TEXT
    )
    ''');
    await db.execute('''
    CREATE TABLE $dateTable(
    ${DateFields.id} INTEGER PRIMARY KEY,
    ${DateFields.userid} INTEGER,
    ${DateFields.date} DATETIME
    )''');
  }

  Future<int> addUser(PeriodUser user, String tableName) async {
    await instance.database;
    Database database = _database!;
    int i = await database.insert(
      '$tableName',
      user.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return i;
  }

  Future<int> addSelectedDate(Dates date, String tableName) async {
    await instance.database;
    Database database = _database!;
    int i = await database.insert(
      '$tableName',
      date.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return i;
  }

  Future<int> userExists(String email) async {
    final db = await instance.database;
    var user = await db.rawQuery(
        'SELECT *, COUNT(*) AS RESULT FROM user WHERE ${UserFields.email} = ?',
        [email]);
    if (user[0]['id'] != null) {
      var id = int.parse(user[0]['id'].toString());
      return int.parse(user[0]['RESULT'].toString()) > 0 ? id : 0;
    } else {
      return 0;
    }
  }

  Future<String> readImage(int id) async {
    final db = await instance.database;
    var read = await db.query(usertable,
        columns: UserFields.uservalues,
        where: '${UserFields.id} = ?',
        whereArgs: [id]);
    return read[0]['image'].toString();
  }

  Future<String> readPeriodLength(int id) async {
    final db = await instance.database;
    var read = await db.query(usertable,
        columns: UserFields.uservalues,
        where: '${UserFields.id} = ?',
        whereArgs: [id]);
    return read[0]['periodLength'].toString();
  }

  Future<String> readCycleLength(int id) async {
    final db = await instance.database;
    var read = await db.query(usertable,
        columns: UserFields.uservalues,
        where: '${UserFields.id} = ?',
        whereArgs: [id]);

    return read[0]['cycleLength'].toString();
  }

  Future<int> updatePeriodData(
      {required int userId,
      DateTime? chosenDate,
      String? flow,
      String? flowImage,
      String? currentWeight,
      String? weightImage,
      String? sleep,
      String? sleepImage,
      String? mood,
      String? moodImage,
      String? symptoms,
      String? symptomsImage}) async {
    var date = chosenDate!.toIso8601String();
    final db = await instance.database;
    var updatedPeriod = await db.rawUpdate(
        'UPDATE period SET ${PeriodFields.flow} = ?,'
        '${PeriodFields.flowImage} = ?,'
        '${PeriodFields.currentWeight} = ?,'
        '${PeriodFields.weightImage} = ?,'
        '${PeriodFields.sleep} = ?,'
        '${PeriodFields.sleepImage} = ?,'
        '${PeriodFields.mood} = ?,'
        '${PeriodFields.moodImage} = ?,'
        '${PeriodFields.symptoms} = ?, '
        '${PeriodFields.symptomsImage} =?'
        'WHERE ${PeriodFields.userid} = ? AND ${PeriodFields.chosenDate} = ?',
        [
          flow,
          flowImage,
          currentWeight,
          weightImage,
          sleep,
          sleepImage,
          mood,
          moodImage,
          symptoms,
          symptomsImage,
          userId,
          date
        ]);
    return updatedPeriod;
  }

  Future<int> updateUserBasic({
    int? id,
    String? name,
    String? image,
    DateTime? dob,
    String? weight,
  }) async {
    var bday = dob!.toIso8601String();
    final db = await instance.database;
    var updatedProfile = await db.rawUpdate(
        'UPDATE user SET ${UserFields.name} = ?, ${UserFields.image} = ?,  ${UserFields.dob} = ?, ${UserFields.weight} = ?  WHERE ${UserFields.id} = ?',
        [name, image, bday, weight, id]);
    return updatedProfile;
  }

  Future<int> updateUserCycle(
      {int? id, String? cycleLength, String? periodLength}) async {
    final db = await instance.database;
    var updatedProfile = await db.rawUpdate(
        'UPDATE user SET ${UserFields.cycleLength} = ?, ${UserFields.periodLength} = ?  WHERE ${UserFields.id} = ?',
        [cycleLength, periodLength, id]);
    return updatedProfile;
  }

  Future<int> updateUserSelectedDate({int? id, DateTime? selectedDate}) async {
    var date = selectedDate!.toIso8601String();
    final db = await instance.database;
    var updatedProfile = await db.rawUpdate(
        'UPDATE user SET ${UserFields.selectedDate} = ?  WHERE ${UserFields.id} = ?',
        [date, id]);
    return updatedProfile;
  }

  Future<int> updateCycle(
      {int? id, String? cycleLength, String? periodLength}) async {
    final db = await instance.database;

    var updatedLength = await db.rawUpdate(
        'UPDATE user SET ${UserFields.cycleLength} = ?, ${UserFields.periodLength} = ?  WHERE ${UserFields.id} = ?',
        [cycleLength, periodLength, id]);
    return updatedLength;
  }

  Future<int> addPeriod(Period period, String tableName) async {
    await instance.database;
    Database database = _database!;
    int i = await database.insert(
      '$tableName',
      period.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return i;
  }

  Future<Period> readPeriod(int id, DateTime? d) async {
    var date = d!.toIso8601String();
    // var selected = selectedDate!.toIso8601String();
    final db = await instance.database;

    var maps = await db.query(
      table,
      columns: PeriodFields.values,
      where: '${PeriodFields.userid} = ? AND ${PeriodFields.chosenDate} = ?',
      whereArgs: [id, date],
    );

    if (maps.isNotEmpty) {
      return Period.fromJson(maps.first);
    } else {
      throw Exception('$id not found');
    }
  }

  Future<bool> existsChosenDetails({int? id, DateTime? chosenDate}) async {
    var date = chosenDate!.toIso8601String();
    final db = await instance.database;

    var maps = await db.query(
      table,
      columns: PeriodFields.values,
      where: '${PeriodFields.userid} = ? AND ${PeriodFields.chosenDate} = ?',
      whereArgs: [id, date],
    );

    if (maps.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  Future<PeriodUser> readUserByEmail({required String email}) async {
    final db = await instance.database;
    var maps = await db.query(
      usertable,
      columns: UserFields.uservalues,
      where: '${UserFields.email} = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return PeriodUser.fromJson(maps.first);
    } else {
      throw Exception('$email not found');
    }
  }

  Future<PeriodUser> readUser({int? id}) async {
    final db = await instance.database;
    var maps = await db.query(
      usertable,
      columns: UserFields.uservalues,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return PeriodUser.fromJson(maps.first);
    } else {
      throw Exception('$id not found');
    }
  }

  Future<Period> readPeriodById({int? id}) async {
    final db = await instance.database;
    var maps = await db.query(
      table,
      columns: PeriodFields.values,
      where: '${PeriodFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return Period.fromJson(maps.first);
    } else {
      throw Exception('$id not found');
    }
  }

  ///READ ALL USER BY NO FLOW
  Future<List<DateTime>> readAllByNoFLow(
      {required String flow, required int userId}) async {
    try {
      final db = await instance.database;
      final response = await db.query(
        table,
        columns: PeriodFields.values,
        where: '${PeriodFields.flow} = ? AND ${PeriodFields.userid} = ?',
        whereArgs: [flow, userId],
      );

      List<DateTime> dates = [];
      response.forEach((e) {
        Period period = Period.fromJson(e);

        dates.add(period.chosenDate!);
      });
      log(response.toString());
      return dates;
    } catch (e) {
      print(e);
      return [];
    }
  }

  ///READ ALL USER BY FLOW
  Future<List<DateTime>> readAllByFLow(
      {required String flow, required int userId}) async {
    try {
      final db = await instance.database;
      final response = await db.query(
        table,
        columns: PeriodFields.values,
        where: '${PeriodFields.flow} != ? AND ${PeriodFields.userid} = ?',
        whereArgs: [flow, userId],
      );

      List<DateTime> dates = [];
      response.forEach((e) {
        Period period = Period.fromJson(e);

        dates.add(period.chosenDate!);
      });
      log(response.toString());
      return dates;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Map<String, dynamic>>> readAll() async {
    final db = await instance.database;
    return await db.query(table);
  }

  Future<List<DateTime>> readAllDateById({required int userId}) async {
    try {
      final db = await instance.database;
      final response = await db.query(
        dateTable,
        columns: DateFields.datevalues,
        where: '${DateFields.userid} = ?',
        whereArgs: [userId],
      );

      List<DateTime> dates = [];
      response.forEach((e) {
        Dates date = Dates.fromJson(e);

        dates.add(date.date!);
      });
      log(response.toString());
      return dates;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db
        .delete(table, where: '${PeriodFields.id}= ?', whereArgs: [id]);
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
