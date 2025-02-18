class AttendanceModel {
  final int? taskId;
  final int userId;
  final String createdDate;
  final String? inTime;
  final String? outTime;
  final String? userName;
  final String? mobileNo;
  final String? absentDesc;
//{TaskId: 1, CreatedDate: 2025-02-18T07:41:45.786343, InTime: 07:41:00, OutTime: 11:41:00, Username: iiii, MobileNo: 3663666666}
  AttendanceModel(
      {this.taskId,
      required this.userId,
      required this.createdDate,
      required this.inTime,
      required this.outTime,
      this.userName,
      this.mobileNo,
      this.absentDesc});

  // Convert Attendance object to Map (for database)
  Map<String, dynamic> toMap() {
    return {
      'TaskId': taskId,
      'UserId': userId,
      'CreatedDate': createdDate,
      'InTime': inTime,
      'OutTime': outTime,
      'Username': userName,
      'MobileNo': mobileNo,
      'AbsentDesc': absentDesc
    };
  }

  // Convert Map to Attendance object (for retrieving data)
  factory AttendanceModel.fromMap(Map<String, dynamic> map) {
    return AttendanceModel(
        taskId: map['TaskId'],
        userId: map['UserId'],
        createdDate: map['CreatedDate'],
        inTime: map['InTime'],
        outTime: map['OutTime'],
        userName: map['Username'],
        mobileNo: map['MobileNo'],
        absentDesc: map['AbsentDesc']);
  }
}
