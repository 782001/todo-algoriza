import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/cubit.dart';
import 'package:todo/pages/tabs/items/task_item.dart';

import '../../cubit/states.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        BuildTaskItem(cubit.favorite[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemCount: cubit.favorite.length),
              ),
            ],
          ),
        );
      },
    );
  }
}
