import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';

import '../../shared/components.dart';
import '../../shared/conestans.dart';
import '../../shared/schedule_tasks.dart';
import 'home_lay_out.dart';

class Date_Screen extends StatelessWidget {
  Date_Screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
            body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: 30, start: 20, end: 20, bottom: 20),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        NavTo(context, HomeScreen());
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        size: 13,
                      ),
                    ),
                    const Text(
                      'Schedule',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Devider(),
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: DatePicker(
                    DateTime.now(),
                    initialSelectedDate: DateTime.now(),
                    selectionColor: DefaultColor,
                    selectedTextColor: Colors.white,
                    controller: cubit.controllerDatePicker,
                    monthTextStyle: TextStyle(fontSize: 0),
                    width: 50,
                    height: 70,
                    onDateChange: (date) {
                      cubit.ChangeSelectedDate(date);
                      // setState(() {
                      //   _selectedValue = date;
                      // }
                      // );
                    },
                  ),
                ),
              ),
              Devider(),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    top: 20, start: 20, end: 20),
                child: Row(
                  children: [
                    Text(
                      '${DateFormat('EEEE').format(cubit.selectedValueDatePicker)}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Spacer(),
                    Text(
                      '${DateFormat.yMMMd().format(cubit.selectedValueDatePicker)}',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              ScheduleTasks()
            ],
          ),
        ));
      },
    );
  }
}
