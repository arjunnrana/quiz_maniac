import 'dart:convert';

class QuestionModel {
  int status;
  List<Datum> data;

  QuestionModel({
    required this.status,
    required this.data,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int? sno;
  Course? course;
  int? unit;
  String? questionEnglish;
  String? optionAEnglish;
  String? optionBEnglish;
  String? optionCEnglish;
  String? optionDEnglish;
  String? questionHindi;
  String? optionAHindi;
  String? optionBHindi;
  String? optionCHindi;
  String? optionDHindi;
  Answer? answer;
  Level? level;

  Datum({
    required this.sno,
    required this.course,
    required this.unit,
    required this.questionEnglish,
    required this.optionAEnglish,
    required this.optionBEnglish,
    required this.optionCEnglish,
    required this.optionDEnglish,
    required this.questionHindi,
    required this.optionAHindi,
    required this.optionBHindi,
    required this.optionCHindi,
    required this.optionDHindi,
    required this.answer,
    required this.level,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        sno: json["SNO"],
        course: courseValues.map[json["COURSE"]],
        unit: json["UNIT"],
        questionEnglish: json["QUESTION (ENGLISH)"],
        optionAEnglish: json["OPTION A (ENGLISH)"],
        optionBEnglish: json["OPTION B (ENGLISH)"],
        optionCEnglish: json["OPTION C (ENGLISH)"],
        optionDEnglish: json["OPTION D (ENGLISH)"],
        questionHindi: json["QUESTION (HINDI)"],
        optionAHindi: json["OPTION A (HINDI)"],
        optionBHindi: json["OPTION B (HINDI)"],
        optionCHindi: json["OPTION C (HINDI)"],
        optionDHindi: json["OPTION D (HINDI)"],
        answer: answerValues.map[json["ANSWER"]],
        level: levelValues.map[json["LEVEL"]],
      );

  Map<String, dynamic> toJson() => {
        "SNO": sno,
        "COURSE": courseValues.reverse[course],
        "UNIT": unit,
        "QUESTION (ENGLISH)": questionEnglish,
        "OPTION A (ENGLISH)": optionAEnglish,
        "OPTION B (ENGLISH)": optionBEnglish,
        "OPTION C (ENGLISH)": optionCEnglish,
        "OPTION D (ENGLISH)": optionDEnglish,
        "QUESTION (HINDI)": questionHindi,
        "OPTION A (HINDI)": optionAHindi,
        "OPTION B (HINDI)": optionBHindi,
        "OPTION C (HINDI)": optionCHindi,
        "OPTION D (HINDI)": optionDHindi,
        "ANSWER": answerValues.reverse[answer],
        "LEVEL": levelValues.reverse[level],
      };
}

enum Answer { A, B, C, D }

enum Course { RESEARCH_METHODOLOGY }

enum Level { EASY, HARD, MEDIUM }

final answerValues = EnumValues({
  "A": Answer.A,
  "B": Answer.B,
  "C": Answer.C,
  "D": Answer.D,
});

final courseValues = EnumValues({
  "Research Methodology": Course.RESEARCH_METHODOLOGY,
});

final levelValues = EnumValues({
  "Easy": Level.EASY,
  "Hard": Level.HARD,
  "Medium": Level.MEDIUM,
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map.map((k, v) => MapEntry(v, k));
    return reverseMap!;
  }
}
