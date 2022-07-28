import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../cubit/cubit.dart';
import '../../../cubit/states.dart';
import '../../../shared/components.dart';

Widget BuildScheduleItem(Map model) => BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);

        List<Color> itemColor = [
          Color(0xff5147),
          Color(0xff9d42),
          Color(0xf9c50a),
          Colors.blue,
        ];

        return BlocConsumer<AppCubit, AppStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            return Padding(
              padding:
                  const EdgeInsetsDirectional.only(top: 10, start: 30, end: 30),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 90,
                    decoration: BoxDecoration(
                      color:
                          Colors.primaries[Random().nextInt(itemColor.length)],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '${model['StartTime']}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                              const DeviderSizedBox(),
                              Text(
                                '${model['Title']}',
                                style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () {
                              cubit.changeChexBox(model);
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: model['status'] == "Completed"
                                        ? Colors.white
                                        : Colors.white,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: model['status'] == "Completed"
                                        ? const Icon(
                                            Icons.check,
                                            size: 13.0,
                                            color: Colors.black,
                                          )
                                        : Icon(
                                            Icons.check_box_outline_blank,
                                            size: 13.0,
                                            color:
                                                model['status'] == "Completed"
                                                    ? const Color(0xffff5147)
                                                    : Colors.white,
                                          ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
// Widget BuildScheduleItem() => BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         var cubit = AppCubit.get(context);
//
//         return Column(children: [
//           Row(
//             children: [
//               InkWell(
//                 onTap: () {
//                   cubit.changeChexBox();
//                 },
//                 child: Container(
//                   height: 43,
//                   width: 43,
//                   decoration: BoxDecoration(
//                       shape: BoxShape.rectangle,
//                       color: Color(0xffff5147),
//                       borderRadius: BorderRadius.circular(10)),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Container(
//                         height: 40,
//                         width: 40,
//                         decoration: BoxDecoration(
//                             shape: BoxShape.rectangle,
//                             color:
//                                 cubit.value ? Color(0xffff5147) : Colors.white,
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Padding(
//                           padding: const EdgeInsets.all(10.0),
//                           child: cubit.value
//                               ? const Icon(
//                                   Icons.check,
//                                   size: 20.0,
//                                   color: Colors.white,
//                                 )
//                               : Icon(
//                                   Icons.check_box_outline_blank,
//                                   size: 20.0,
//                                   color: cubit.value
//                                       ? const Color(0xffff5147)
//                                       : Colors.white,
//                                 ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 width: 15,
//               ),
//               Text(
//                 '{model[' 'Title' ']}',
//                 style: const TextStyle(
//                   fontSize: 20,
//                   color: Colors.black,
//                 ),
//               ),
//               const Spacer(),
//               PopupMenuButton(
//                   onSelected: (value) {
//                     // if (value == MenuItem.Completed) {}
//                     // if (value == MenuItem.UnCompleted) {}
//                     // if (value == MenuItem.Favorite) {}
//                   },
//                   itemBuilder: (context) => [
//                         const PopupMenuItem(
//                           child: Text('Completed'),
//                           value: MenuItem.Completed,
//                         ),
//                         const PopupMenuItem(
//                           child: Text('UnCompleted'),
//                           value: MenuItem.UnCompleted,
//                         ),
//                         const PopupMenuItem(
//                           child: Text('Favorite'),
//                           value: MenuItem.Favorite,
//                         ),
//                       ])
//             ],
//           ),
//         ]);
//       },
//     );
