class MoodTrackingModel {
  final List<String> feeling;
  final String reason;
  final List<String> selfCare;
  final String voiceNotePath;
  final DateTime date;

  MoodTrackingModel({
    required this.feeling,
    required this.reason,
    required this.selfCare,
    required this.voiceNotePath,
    required this.date,
  });

  // Convert the model to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'feeling': feeling,
      'reason': reason,
      'selfCare': selfCare,
      'voiceNotePath': voiceNotePath,
      'date': date.toIso8601String(), // Convert DateTime to String for JSON
    };
  }

  // Create an instance from a JSON object
  factory MoodTrackingModel.fromJson(Map<String, dynamic> json) {
    return MoodTrackingModel(
      feeling: List<String>.from(json['feeling']), // Parse list from JSON
      reason: json['reason'],
      selfCare: List<String>.from(json['selfCare']), // Parse list from JSON
      voiceNotePath: json['voiceNotePath'],
      date: DateTime.parse(json['date']), // Convert String to DateTime
    );
  }
}
