import 'package:app_salud/core/constants/color_contats.dart';
import 'package:flutter/material.dart';

class CardHome extends StatelessWidget {
  const CardHome({
    this.coutner,
    this.goals,
    required this.colorCard,
    required this.title,
    required this.widget,
    required this.pathImg,
    this.count,
    super.key,
  });

  final int? coutner;
  final int? goals;
  final Color colorCard;
  final String title;
  final Widget widget;
  final String pathImg;
  final int? count;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: colorCard,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: ColorConstants.primary,
                    borderRadius: BorderRadius.circular(100),
                  ),
                  child: Transform.scale(
                    scale: 0.6,
                    child: Image.asset(
                      pathImg,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: ColorConstants.primary,
                      ),
                    ),
                    if (goals != null && coutner != null)
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '$coutner',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: ColorConstants.primary,
                              ),
                            ),
                            TextSpan(
                              text: ' / $goals',
                              style: TextStyle(
                                color: ColorConstants.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (count != null)
                      Text(
                        '$count',
                        style: TextStyle(
                          color: ColorConstants.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                  ],
                )
              ],
            ),
            const SizedBox(height: 10),
            widget,
          ],
        ),
      ),
    );
  }
}
