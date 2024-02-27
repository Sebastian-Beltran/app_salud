import 'package:app_salud/core/constants/color_contats.dart';
import 'package:app_salud/features/home/ui/widgets/app_bar.dart';
import 'package:app_salud/features/home/ui/widgets/cards.dart';
import 'package:app_salud/features/steps/models/steps.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

class StepsScreen extends ConsumerStatefulWidget {
  const StepsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StepsScreenState();
}

class _StepsScreenState extends ConsumerState<StepsScreen> {
  @override
  Widget build(BuildContext context) {
    final Steps args = ModalRoute.of(context)!.settings.arguments as Steps;
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(children: [
              CardHome(
                coutner: args.counter,
                goals: args.goal,
                title: 'Steps',
                colorCard: ColorConstants.yellow,
                widget: LinearPercentIndicator(
                  width: MediaQuery.of(context).size.width - 80,
                  animation: true,
                  lineHeight: 15.0,
                  animationDuration: 2000,
                  percent: args.counter / args.goal,
                  barRadius: const Radius.circular(20),
                  progressColor: ColorConstants.primary,
                ),
                pathImg: 'assets/img/steps_counter.png',
              ),
            ]),
          ),
        ));
  }
}
