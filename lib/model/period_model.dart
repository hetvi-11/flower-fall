class PeriodFields {

  static final List<String> values = [
    id,
    userid,
    chosenDate,
    flow,
    flowImage,
    currentWeight,
    weightImage,
    sleep,
    sleepImage,
    mood,
    moodImage,
    symptoms,
    symptomsImage
  ];

  static final String id = 'id';
  static final String userid = 'userid';
  static final String chosenDate = 'chosenDate';
  static final String flow = 'flow';
  static final String flowImage = 'flowImage';
  static final String currentWeight = 'currentWeight';
  static final String weightImage = 'weightImage';
  static final String sleep = 'sleep';
  static final String sleepImage = 'sleepImage';
  static final String mood = 'mood';
  static final String moodImage = 'moodImage';
  static final String symptoms = 'symptoms';
  static final String symptomsImage = 'symptomsImage';
}

class Period {
  int? id;
  int? userid;
  DateTime? chosenDate;
  String? flow;
  String? flowImage;
  String? currentWeight;
  String? weightImage;
  String? sleep;
  String? sleepImage;
  String? mood;
  String? moodImage;
  String? symptoms;
  String? symptomsImage;

  Period({
    this.id,
    this.userid,
    this.chosenDate,
    this.flow,
    this.flowImage,
    this.currentWeight,
    this.weightImage,
    this.sleep,
    this.sleepImage,
    this.mood,
    this.moodImage,
    this.symptoms,
    this.symptomsImage
  });


  static Period fromJson(Map<String, Object?> json) => Period(
      id:  json[PeriodFields.id] as int?,
      userid: json[PeriodFields.userid] as int?,
      chosenDate: DateTime.parse(json[PeriodFields.chosenDate] as String),
      flow:  json[PeriodFields.flow] as String?,
      flowImage:  json[PeriodFields.flowImage] as String?,
      currentWeight:  json[PeriodFields.currentWeight] as String?,
      weightImage:  json[PeriodFields.weightImage] as String?,
      sleep:  json[PeriodFields.sleep] as String?,
      sleepImage:  json[PeriodFields.sleepImage] as String?,
      mood:  json[PeriodFields.mood] as String?,
      moodImage:  json[PeriodFields.moodImage] as String?,
      symptoms:  json[PeriodFields.symptoms] as String?,
      symptomsImage:  json[PeriodFields.symptomsImage] as String?
  );

  Map<String, Object?> toJson() => {
    PeriodFields.id: id,
    PeriodFields.userid: userid,
    PeriodFields.chosenDate: chosenDate == null ? "" : DateTime(chosenDate!.year, chosenDate!.month, chosenDate!.day).toIso8601String(),
    PeriodFields.flow: flow,
    PeriodFields.flowImage: flowImage,
    PeriodFields.currentWeight: currentWeight,
    PeriodFields.weightImage: weightImage,
    PeriodFields.sleep: sleep,
    PeriodFields.sleepImage: sleepImage,
    PeriodFields.mood: mood,
    PeriodFields.moodImage: moodImage,
    PeriodFields.symptoms: symptoms == null ? "" :symptoms!.toString().splitMapJoin(","),
    PeriodFields.symptomsImage: symptomsImage
  };

}

class DateFields{

  static final List<String> datevalues = [
    id,
    userid,
    date
  ];

  static final String id = 'id';
  static final String userid = 'userid';
  static final String date = 'date';
}

class Dates{
  int? id;
  int? userid;
  DateTime? date;

  Dates({
    this.id,
    this.userid,
    this.date,
});

  static Dates fromJson(Map<String, Object?> json) => Dates(
    id: json[DateFields.id] as int?,
    userid: json[DateFields.userid] as int?,
    date: DateTime.parse(json[DateFields.date] as String),
  );

  Map<String, Object?> toJson() =>{
    DateFields.id : id,
    DateFields.userid : userid,
    DateFields.date: date  == null ? null : DateTime(date!.year, date!.month, date!.day).toIso8601String(),
  };

}

class UserFields{

  static final List<String> uservalues = [
    id,
    email,
    name,
    image,
    dob,
    cycleLength,
    periodLength,
    selectedDate,
    weight
  ];

  static final String id = 'id';
  static late final String email = 'email';
  static final String name = 'name';
  static final String image = 'image';
  static final String dob = 'dob';
  static final String cycleLength = 'cycleLength';
  static final String periodLength = 'periodLength';
  static final String selectedDate = 'selectedDate';
  static final String weight = 'weight';
}

class PeriodUser {
  int? id;
  String? email;
  String? name;
  String? image;
  DateTime? dob;
  String? cycleLength;
  String? periodLength;
  DateTime? selectedDate;
  String? weight;

  PeriodUser({
    this.id,
    this.email,
    this.name,
    this.image,
    this.dob,
    this.cycleLength,
    this.periodLength,
    this.selectedDate,
    this.weight,
  });

  static PeriodUser fromJson(Map<String, Object?> json) => PeriodUser(
    id: json[UserFields.id] as int?,
    email:  json[UserFields.email] as String?,
    name:  json[UserFields.name] as String?,
    image: json[UserFields.image] as String?,
    dob: json[UserFields.dob] == null ? null: DateTime.parse(json[UserFields.dob] as String),
    cycleLength: json[UserFields.cycleLength] as String?,
    periodLength: json[UserFields.periodLength] as String?,
    selectedDate: json[UserFields.selectedDate] == null ? null: DateTime.parse(json[UserFields.selectedDate] as String),
    weight:  json[UserFields.weight] as String?,
  );
  //json[UserFields.dob].toString().isEmpty ? null : DateTime.parse(json[UserFields.dob].toString()),
  //json[UserFields.selectedDate].toString().isEmpty ? null : DateTime.parse(json[UserFields.selectedDate].toString()),

  Map<String, Object?> toJson() => {
    UserFields.id: id,
    UserFields.email: email,
    UserFields.name: name,
    UserFields.image: image,
    UserFields.dob: dob == null ? null : dob!.toIso8601String(),
    UserFields.cycleLength : cycleLength,
    UserFields.periodLength : periodLength,
    UserFields.selectedDate: selectedDate  == null ? null : DateTime(selectedDate!.year, selectedDate!.month, selectedDate!.day).toIso8601String(),
    UserFields.weight: weight,
  };

}

