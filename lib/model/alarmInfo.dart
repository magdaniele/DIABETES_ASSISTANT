// ignore_for_file: file_names
class AlarmInfo {
  String? alarmId;
  DateTime? alarmDateTime;
  String? title;
  bool? isActive = false;
  int? gradientColorIndex;

  AlarmInfo(
      {this.alarmId,
      this.title,
      this.alarmDateTime,
      this.isActive,
      this.gradientColorIndex});

  factory AlarmInfo.fromMap(map) {
    return AlarmInfo(
        alarmId: map['alarmId'],
        alarmDateTime: map['alarmDateTime'],
        title: map['tittle'],
        isActive: map['isActive'],
        gradientColorIndex: map['gradientColorIndex']);
  }
  //send data
  Map<String, dynamic> toMap() {
    return {
      'alarmId': alarmId,
      'alarmDateTime': alarmDateTime,
      'title': title,
      'isActive': isActive,
      'gradientColorIndex': gradientColorIndex
    };
  }
}
