import 'package:equatable/equatable.dart';

class Steps extends Equatable {
  const Steps({
    required this.counter,
    required this.goal,
    required this.title,
  });

  final int counter;
  final int goal;
  final String title;

  @override
  List<Object?> get props => [counter, goal, title];
}
