import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';
import 'package:todo/pages/tabs/items/tabbar_item.dart';

import '../../shared/components.dart';
import '../tabs/items/tabbar_item.dart';
import 'creat_task.dart';
import 'date_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({String? payload, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                          top: 50, start: 20, end: 20, bottom: 30),
                      child: Row(
                        children: [
                          const Text(
                            'Board',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              NavTo(context, Date_Screen());
                            },
                            icon: Icon(
                              Icons.calendar_month,
                              color: Colors.grey[700],
                            ),
                          )
                        ],
                      ),
                    ),
                    const Devider(),
                    const SizedBox(height: 10),
                    const TabBarItem(),
                    const SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: BigButton(context,
                          text: 'Add a task', widget: CreatTaskScreen()),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
