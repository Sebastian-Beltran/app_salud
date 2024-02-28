import 'package:app_salud/core/constants/color_constats.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    this.bottom,
    super.key,
  });

  final PreferredSizeWidget? bottom;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              Icons.apps,
              color: ColorConstants.primary,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Image.network(
              'https://avatars.githubusercontent.com/u/68518930?v=4',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: ColorConstants.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Center(
                      child: Text(
                    "S",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorConstants.primary,
                      fontSize: 24,
                    ),
                  )),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize {
    if (bottom == null) {
      return const Size.fromHeight(56);
    }
    return Size.fromHeight(56.0 + bottom!.preferredSize.height);
  }
}
