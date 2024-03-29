import 'package:app_salud/core/constants/color_constats.dart';
import 'package:app_salud/features/home/ui/widgets/app_bar.dart';
import 'package:app_salud/features/home/ui/widgets/cards.dart';
import 'package:app_salud/features/home/models/steps.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailsScreen extends StatelessWidget {
  DetailsScreen({super.key});

  final _stepController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Steps args = ModalRoute.of(context)!.settings.arguments as Steps;
    return Scaffold(
        appBar: const CustomAppBar(),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(children: [
                CardHome(
                  coutner: args.counter,
                  goals: args.goal,
                  title: args.title,
                  colorCard: args.colorCard,
                  widget: LinearPercentIndicator(
                    width: MediaQuery.of(context).size.width - 80,
                    animation: true,
                    lineHeight: 15.0,
                    animationDuration: 2000,
                    percent: args.counter / args.goal,
                    barRadius: const Radius.circular(20),
                    progressColor: ColorConstants.primary,
                  ),
                  pathImg: args.pathImg,
                ),
                TextFormField(
                  controller: _stepController,
                  onChanged: (value) {},
                ),
                ElevatedButton(
                  onPressed: onPress,
                  child: const Text('Actualizar pasos'),
                )
              ]),
            ),
          ),
        ));
  }

  void onPress() {}
}
