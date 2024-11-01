import 'package:flutter/material.dart';
import 'package:my_flex_school/common/app_colors.dart';

class DetailTile extends StatelessWidget {
  const DetailTile({super.key, required this.title, required this.iconData});
  final String title;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                iconData,
                color: AppColors.greenColor,
                size: 30,
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              height: 0.5,
              color: AppColors.mainColor,
            ),
          )
        ],
      ),
    );
  }
}
