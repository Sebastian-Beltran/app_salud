import 'package:app_salud/core/states/custom_state.dart';
import 'package:app_salud/features/home/provider/home_state.dart';
import 'package:app_salud/features/home/services/home_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>(HomeNotifier.fromRef);

class HomeNotifier extends StateNotifier<HomeState> {
  HomeNotifier({
    required this.homeService,
    required this.ref,
  }) : super(HomeState.initial());

  factory HomeNotifier.fromRef(Ref ref) {
    return HomeNotifier(
      homeService: ref.read(homeServiceProvider),
      ref: ref,
    );
  }
  final HomeService homeService;
  final Ref ref;

  void resetState() => state = HomeState.initial();

  Future<void> getInformationUser({required int userId}) async {
    state = state.copyWith(userHealth: const CustomState.loading());
    final res = await homeService.getInformationHealth(userId);
    state = res.fold(
      (left) => state.copyWith(userHealth: CustomState.failure(left)),
      (right) => state.copyWith(
        userHealth: CustomState.data(right),
      ),
    );
  }
}
