import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';
import 'package:todo/pages/tabs/items/schedule_task_item.dart';

import '../pages/tabs/items/schedule_task_item.dart';

class ScheduleTasks extends StatelessWidget {
  const ScheduleTasks({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Expanded(
          child: ListView.separated(
              itemBuilder: (context, index) =>
                  BuildScheduleItem(cubit.CalenderList[index]),
              separatorBuilder: (context, index) => const SizedBox(
                    height: 10,
                  ),
              itemCount: cubit.CalenderList.length),
        );
      },
    );
  }
}
