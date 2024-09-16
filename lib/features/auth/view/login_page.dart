import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:my_flex_school/common/app_colors.dart';
import 'package:my_flex_school/features/auth/controller/login_controller.dart';
import 'package:my_flex_school/features/auth/widgets/login_widget.dart';
import 'package:my_flex_school/features/auth/widgets/signup_widget.dart';
import 'package:my_flex_school/widgets/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController = TabController(length: 2, vsync: this);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: SafeArea(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: height * 0.2,
                      ),
                      const Text(
                        'MYFLEXSCHOOL',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                      const Text(
                        'THE APP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        height: height * 0.45,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10))),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Column(
                              children: [
                                TabBar(
                                  controller: tabController,
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  //indicatorColor: AppColors.mainColor,
                                  tabs: const [
                                    Tab(child: Text('Login')),
                                    Tab(child: Text('Sign Up')),
                                  ],
                                ),
                                Expanded(
                                  child: TabBarView(
                                      controller: tabController,
                                      children: [
                                        LoginWidget(width: width),
                                        SignupWidget(width: width)
                                      ]),
                                )
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
