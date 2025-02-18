class UsersModel {
  final int? userId;
  final String username;
  final String mobileNo;
  final String? createdDate;

  UsersModel({
    this.userId,
    required this.username,
    required this.mobileNo,
    this.createdDate,
  });

  // Convert User object to a Map (for database insertion)
  Map<String, dynamic> toMap() {
    return {
      'UserId': userId,
      'Username': username,
      'MobileNo': mobileNo,
      'CreatedDate': createdDate,
    };
  }

  // Convert a Map to a User object (for retrieving data)
  factory UsersModel.fromMap(Map<String, dynamic> map) {
    return UsersModel(
      userId: map['UserId'],
      username: map['Username'],
      mobileNo: map['MobileNo'],
      createdDate: map['CreatedDate'],
    );
  }
}
