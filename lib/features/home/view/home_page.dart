import 'package:flutter/material.dart';
import 'package:my_flex_school/common/app_colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Container(
            height: height * 0.3,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(
                    width: double.infinity,
                  ),
                  const Text(
                    'MYFLEXSCHOOL',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'REACH',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.secColor,
                        ),
                      ),
                      const Text(
                        'CONNECT',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: AppColors.secColor,
                        ),
                      ),
                      const Text(
                        'ENGAGE',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                FeaturesWidget(
                    title: 'FLEX SCHOOLS',
                    subTitle: 'Find Flex Schools',
                    iconData: Icons.school_outlined),
                FeaturesWidget(
                    title: 'RESOURCES',
                    subTitle: 'Find Resources',
                    iconData: Icons.miscellaneous_services_outlined),
                FeaturesWidget(
                    title: 'SERVICES',
                    subTitle: 'Find Services',
                    iconData: Icons.design_services_outlined)
              ],
            ),
          )
        ],
      )),
    );
  }
}

class FeaturesWidget extends StatelessWidget {
  const FeaturesWidget(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.iconData});
  final String title;
  final String subTitle;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      height: 100,
      decoration: BoxDecoration(
          color: AppColors.mainColor.withOpacity(0.6),
          borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.w500),
              ),
              Text(
                subTitle,
                style: const TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Icon(
              iconData,
              color: Colors.white,
              size: 50,
            ),
          )
        ],
      ),
    );
  }
}
