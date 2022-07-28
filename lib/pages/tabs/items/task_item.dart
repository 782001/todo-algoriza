import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/popup_menu_value.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';

Widget BuildTaskItem(Map model) => BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        return Column(children: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  cubit.changeChexBox(model);
                },
                child: Container(
                  height: 43,
                  width: 43,
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xffff5147),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: model['status'] == "Completed"
                                ? Color(0xffff5147)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: model['status'] == "Completed"
                              ? const Icon(
                                  Icons.check,
                                  size: 20.0,
                                  color: Colors.white,
                                )
                              : Icon(
                                  Icons.check_box_outline_blank,
                                  size: 20.0,
                                  color: model['status'] == "Completed"
                                      ? const Color(0xffff5147)
                                      : Colors.white,
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Container(
                width: 210,
                child: Text(
                  '${model['Title']}',
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 1,
                ),
              ),
              const Spacer(),
              PopupMenuButton(
                  onSelected: (value) {
                    if (value == MenuItem.Completed) {
                      cubit.UbdateDataFromDataBase(
                          id: model['id'], status: 'Completed');
                    }
                    if (value == MenuItem.UnCompleted) {
                      cubit.UbdateDataFromDataBase(
                          id: model['id'], status: 'UnCompleted');
                    }
                    if (value == MenuItem.Favorite) {
                      cubit.UbdateDataFromDataBase(
                          id: model['id'], status: 'Favorite');
                    }
                    if (value == MenuItem.Delete) {
                      cubit.DeleteDataFromDataBase(id: model['id']);
                    }
                  },
                  itemBuilder: (context) => [
                        const PopupMenuItem(
                          child: Text('Completed'),
                          value: MenuItem.Completed,
                        ),
                        const PopupMenuItem(
                          child: Text('UnCompleted'),
                          value: MenuItem.UnCompleted,
                        ),
                        const PopupMenuItem(
                          child: Text('Favorite'),
                          value: MenuItem.Favorite,
                        ),
                        const PopupMenuItem(
                          child: Text('Delete'),
                          value: MenuItem.Delete,
                        )
                      ])
            ],
          ),
        ]);
      },
    );
