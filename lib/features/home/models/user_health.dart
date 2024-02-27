import 'package:equatable/equatable.dart';

class UserHealth extends Equatable {
  const UserHealth({
    required this.name,
    required this.stepsCounter,
    required this.stepsGoal,
    required this.caloriesGoal,
    required this.caloriesCounter,
    required this.waterGoal,
    required this.waterCounter,
    required this.heartRate,
  });

  final String name;
  final int stepsCounter;
  final int stepsGoal;
  final int caloriesGoal;
  final int caloriesCounter;
  final int waterGoal;
  final int waterCounter;
  final int heartRate;

  factory UserHealth.fromJson(Map<String, dynamic> json) {
    return UserHealth(
      name: json['name'] as String,
      stepsCounter: json['stepsCounter'] as int,
      stepsGoal: json['stepsGoal'] as int,
      caloriesGoal: json['caloriesGoal'] as int,
      caloriesCounter: json['caloriesCounter'] as int,
      waterGoal: json['waterGoal'] as int,
      waterCounter: json['waterCounter'] as int,
      heartRate: json['heartRate'] as int,
    );
  }

  @override
  List<Object?> get props => [
        name,
        stepsCounter,
        stepsGoal,
        caloriesGoal,
        caloriesCounter,
        waterGoal,
        waterCounter,
        heartRate,
      ];
}
