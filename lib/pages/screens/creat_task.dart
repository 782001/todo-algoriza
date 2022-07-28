import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/cubit/states.dart';
import 'package:todo/shared/components.dart';

import 'home_lay_out.dart';

class CreatTaskScreen extends StatelessWidget {
  CreatTaskScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        // var Date = DateFormat.jm().parse(cubit.StartTimeController.text);
        // var MyTime = DateFormat("hh:mm:ss").format(Date);

        var FormKey = GlobalKey<FormState>();
        var startTimeInetial = TimeOfDay.now();
        var endTimeInetial = TimeOfDay.now();
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Form(
              key: FormKey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                            'Add task',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const Devider(),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Title',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          DeviderSizedBox(),
                          DefaultFormField(
                            controller: cubit.TitleController,
                            hint: 'Design team meeting',
                            type: TextInputType.text,
                            validate: (String? value) {
                              if (value!.isEmpty) {
                                return 'please enter title';
                              }
                            },
                            tapPressed: () {},
                          ),
                          DeviderSizedBox(),
                          const Text(
                            'Date',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          DeviderSizedBox(),
                          DefaultFormField(
                              controller: cubit.DateController,
                              hint: DateFormat('yyyy-MM-dd')
                                  .format(cubit.selectedDate),
                              type: TextInputType.datetime,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'please enter date';
                                }
                              },
                              tapPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.parse('1900-08-07'),
                                  lastDate: DateTime.parse('3022-08-07'),
                                ).then((value) {
                                  cubit.DateController.text =
                                      DateFormat('yyyy-MM-dd').format(value!);
                                });
                              },
                              suffixPressed: () {},
                              suffix: Icons.keyboard_arrow_down),
                          DeviderSizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'StartTime',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    DeviderSizedBox(),
                                    DefaultFormField(
                                        tapPressed: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: startTimeInetial,
                                          ).then((value) {
                                            cubit.StartTimeController.text =
                                                // MyTime;
                                                // DateFormat('HH:mm:ss').format(value).toString();
                                                value!
                                                    .format(context)
                                                    .toString();
                                          });
                                        },
                                        controller: cubit.StartTimeController,
                                        hint: cubit.startTime,
                                        type: TextInputType.datetime,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'please enter Start time';
                                          }
                                        },
                                        suffixPressed: () {},
                                        suffix: Icons.watch_later_outlined),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'End time',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const DeviderSizedBox(),
                                    DefaultFormField(
                                        tapPressed: () {
                                          showTimePicker(
                                            context: context,
                                            initialTime: endTimeInetial,
                                          ).then((value) {
                                            cubit.EndTimeController.text =
                                                value!
                                                    .format(context)
                                                    .toString();
                                          });
                                        },
                                        controller: cubit.EndTimeController,
                                        hint: cubit.endTime,
                                        type: TextInputType.datetime,
                                        validate: (String? value) {
                                          if (value!.isEmpty) {
                                            return 'please enter End time';
                                          }
                                        },
                                        suffixPressed: () {},
                                        suffix: Icons.watch_later_outlined),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const DeviderSizedBox(),
                          const Text(
                            'Remind',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          DeviderSizedBox(),
                          Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              DefaultFormField(
                                  controller: cubit.RemindController,
                                  hint: '${cubit.selectedRemind} minutes early',
                                  type: TextInputType.text,
                                  // validate: (String? value) {
                                  //   if (value!.isEmpty) {
                                  //     return 'please enter Remiding';
                                  //   }
                                  // },
                                  suffixPressed: () {},
                                  tapPressed: () {},
                                  onchange: (value) {
                                    cubit.RemindController.text =
                                        cubit.selectedRemind as String;
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  dropdownColor: Color(0xff25c06d),
                                  items: cubit.remindList
                                      .map<DropdownMenuItem<String>>(
                                          (int? value) =>
                                              DropdownMenuItem<String>(
                                                  value: value.toString(),
                                                  child: Text(
                                                    '$value',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )))
                                      .toList(),
                                  onChanged: (String? NewValue) {
                                    cubit.ChangeRemidTime(
                                      int.parse(NewValue!),
                                    );
                                  },
                                  underline: Container(
                                    height: 0,
                                  ),
                                  icon: Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Colors.grey,
                                  ),
                                  elevation: 4,
                                ),
                              )
                            ],
                          ),
                          DeviderSizedBox(),
                          const Text(
                            'Repeat',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          DeviderSizedBox(),
                          Stack(
                            alignment: AlignmentDirectional.centerEnd,
                            children: [
                              DefaultFormField(
                                  tapPressed: () {},
                                  controller: cubit.RepeatController,
                                  hint: '${cubit.selectedRepeat}',
                                  type: TextInputType.text,
                                  // validate: (String? value) {
                                  // //   if (value!.isEmpty) {
                                  // //     return 'please enter Repeating';
                                  // //   }
                                  // // },
                                  suffixPressed: () {},
                                  onchange: (value) {
                                    value = cubit.selectedRepeat;
                                  }),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: DropdownButton(
                                  underline: Container(
                                    height: 0,
                                  ),
                                  dropdownColor: Color(0xff25c06d),
                                  items: cubit.repeatList
                                      .map<DropdownMenuItem<String>>(
                                          (String? Value) =>
                                              DropdownMenuItem<String>(
                                                  value: Value.toString(),
                                                  child: Text(
                                                    '$Value',
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )))
                                      .toList(),
                                  onChanged: (String? NewValue) {
                                    cubit.ChangeRepeatTime(NewValue!);
                                  },
                                  icon: const Icon(
                                    Icons.keyboard_arrow_down_sharp,
                                    color: Colors.grey,
                                  ),
                                  elevation: 4,
                                ),
                              ),
                            ],
                          ),
                          DeviderSizedBox(),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          width: double.infinity,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: const Color(0xff25c06d),
                          ),
                          child: MaterialButton(
                            onPressed: () {
                              if (FormKey.currentState!.validate()) {
                                NavTo(context, HomeScreen());
                                cubit.insertIntoDatabase(
                                  Title: cubit.TitleController.text,
                                  Date: cubit.DateController.text,
                                  StartTime: cubit.StartTimeController.text,
                                  EndTime: cubit.EndTimeController.text,
                                  RemindTime: cubit.RemindController.text,
                                  RepeatTime: cubit.RepeatController.text,
                                );
                              }
                            },
                            child: const Text(
                              'Create a task',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ))
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
