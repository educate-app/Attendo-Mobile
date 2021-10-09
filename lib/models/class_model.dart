typedef Map<String, dynamic> StudentDetails(params);

class ClassModel {
  bool live = false;
  final String name;
  final DateTime createdOn;
  final Map<String, StudentDetails> attendees;
  ClassModel({
    required this.live,
    required this.name,
    required this.createdOn,
    required this.attendees,
  });

  ClassModel copyWith({
    bool? live,
    String? name,
    DateTime? createdOn,
    Map<String, StudentDetails>? attendees,
  }) {
    return ClassModel(
      live: live ?? this.live,
      name: name ?? this.name,
      createdOn: createdOn ?? this.createdOn,
      attendees: attendees ?? this.attendees,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'live': live,
      'name': name,
      'createdOn': createdOn.millisecondsSinceEpoch,
      'attendees': attendees,
    };
  }

  factory ClassModel.fromMap(Map<String, dynamic> map) {
    return ClassModel(
      live: map['live'],
      name: map['name'],
      createdOn: DateTime.parse(map['createdOn']),
      attendees: Map<String, StudentDetails>.from(map['attendees']),
    );
  }
}
