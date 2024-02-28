import 'package:app_salud/core/constants/color_constats.dart';
import 'package:app_salud/core/constants/constants.dart';
import 'package:app_salud/core/states/custom_state.dart';
import 'package:app_salud/features/home/provider/home_provider.dart';
import 'package:app_salud/features/home/ui/widgets/app_bar.dart';
import 'package:app_salud/features/home/ui/widgets/cards.dart';
import 'package:app_salud/features/home/models/steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeProvider.notifier).getInformationUser(userId: Constants.userId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeProvider);
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: state.userHealth.whenDataOrFailure(
              failure: (e) => SizedBox(
                child: Text(e),
              ),
              data: (userHealth) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  Text.rich(
                    TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Hi, ',
                            style: TextStyle(
                              fontSize: 24,
                            )),
                        TextSpan(
                          text: userHealth.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    'Your goal is on its way to you!',
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(height: 30),
                  CardHome(
                    onPress: () => onPressed(
                      context: context,
                      goal: userHealth.stepsGoal,
                      counter: userHealth.stepsCounter,
                      title: 'Steps',
                      colorCard: ColorConstants.yellow,
                      imgPath: 'assets/img/steps_counter.png',
                    ),
                    coutner: userHealth.stepsCounter,
                    goals: userHealth.stepsGoal,
                    title: 'Steps',
                    colorCard: ColorConstants.yellow,
                    widget: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 80,
                      animation: true,
                      lineHeight: 15.0,
                      animationDuration: 2000,
                      percent: userHealth.stepsCounter / userHealth.stepsGoal,
                      barRadius: const Radius.circular(20),
                      progressColor: ColorConstants.primary,
                    ),
                    pathImg: 'assets/img/steps_counter.png',
                  ),
                  const SizedBox(height: 10),
                  CardHome(
                    coutner: userHealth.caloriesCounter,
                    goals: userHealth.caloriesGoal,
                    title: 'Calories',
                    colorCard: ColorConstants.green,
                    widget: LinearPercentIndicator(
                      width: MediaQuery.of(context).size.width - 80,
                      animation: true,
                      lineHeight: 15.0,
                      animationDuration: 2000,
                      percent: userHealth.caloriesCounter / userHealth.caloriesGoal,
                      barRadius: const Radius.circular(20),
                      progressColor: ColorConstants.primary,
                    ),
                    pathImg: 'assets/img/calories.png',
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: CardHome(
                          coutner: userHealth.waterCounter,
                          goals: userHealth.waterGoal,
                          title: 'Water',
                          colorCard: ColorConstants.red,
                          widget: CircularPercentIndicator(
                            animation: true,
                            radius: 50,
                            lineWidth: 15.0,
                            animationDuration: 2000,
                            percent: userHealth.waterCounter / 10,
                            center: Text(
                              "${((userHealth.waterCounter / userHealth.waterGoal) * 100).round()}%",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.primary,
                              ),
                            ),
                            progressColor: ColorConstants.primary,
                          ),
                          pathImg: 'assets/img/water_glass.png',
                        ),
                      ),
                      const SizedBox(width: 5),
                      Expanded(
                        child: CardHome(
                          count: userHealth.heartRate,
                          title: 'Heart rate',
                          colorCard: ColorConstants.red,
                          widget: Container(
                            width: 95,
                            height: 95,
                            decoration: BoxDecoration(
                                color: Colors.white.withOpacity(1),
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                  width: 20,
                                  color: Colors.red.withOpacity(0.2),
                                )),
                            child: Transform.scale(
                              scale: 0.4,
                              child: Image.asset(
                                'assets/img/heart_color.png',
                                width: 40,
                                height: 40,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          pathImg: 'assets/img/heart_outline.png',
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  void onPressed({
    required BuildContext context,
    required int counter,
    required int goal,
    required String title,
    required Color colorCard,
    required String imgPath,
  }) {
    Navigator.pushNamed(context, '/detail',
        arguments: Steps(
          counter: counter,
          goal: goal,
          title: title,
          colorCard: colorCard,
          pathImg: imgPath,
        ));
  }
}
