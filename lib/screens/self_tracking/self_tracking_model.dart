class SelfTrackingModel {
  final String feeling;
  final String urgeFrequency;
  final DateTime date;

  SelfTrackingModel({
    required this.feeling,
    required this.urgeFrequency,
    required this.date,
  });

  // Convert the model to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'feeling': feeling,
      'urgeFrequency': urgeFrequency,
      'date': date.toIso8601String(), // Convert DateTime to String
    };
  }

  // Create an instance from a JSON object
  factory SelfTrackingModel.fromJson(Map<String, dynamic> json) {
    return SelfTrackingModel(
      feeling: json['feeling'],
      urgeFrequency: json['urgeFrequency'],
      date: DateTime.parse(json['date']), // Convert String back to DateTime
    );
  }
}
