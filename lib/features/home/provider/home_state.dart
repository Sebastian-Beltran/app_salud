import 'package:app_salud/core/states/custom_state.dart';
import 'package:app_salud/features/home/models/user_health.dart';
import 'package:equatable/equatable.dart';

class HomeState extends Equatable {
  const HomeState({
    required this.userHealth,
  });
  final CustomState<UserHealth> userHealth;

  factory HomeState.initial() => const HomeState(userHealth: CustomState.initial());

  @override
  List<Object?> get props => [userHealth];

  HomeState copyWith({CustomState<UserHealth>? userHealth}) {
    return HomeState(
      userHealth: userHealth ?? this.userHealth,
    );
  }
}
