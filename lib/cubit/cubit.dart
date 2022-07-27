// ignore_for_file: non_constant_identifier_names

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:bloc/bloc.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/cubit/states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());
  static AppCubit get(context) => BlocProvider.of(context);

  var TitleController = TextEditingController();
  var DateController = TextEditingController();
  var StartTimeController = TextEditingController();
  var EndTimeController = TextEditingController();
  var RemindController = TextEditingController();
  var RepeatController = TextEditingController();

  DateTime selectedDate = DateTime.now().toUtc();
  String startTime = DateFormat('HH:mm:ss').format(DateTime.now()).toString();
  String endTime = DateFormat('HH:mm:ss')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int selectedRemind = 10;
  List<int> remindList = [5, 10, 15, 20];
  String selectedRepeat = 'Daily';
  List<String> repeatList = ["None", "Daily", "Weekly", 'Monthly'];

  void ChangeRemidTime(int NewValue) {
    selectedRemind = NewValue;
    emit(ChangeRemidState());
  }

  void ChangeRepeatTime(String NewValue) {
    selectedRepeat = NewValue;
    emit(ChangeRepeatState());
  }

  DatePickerController controllerDatePicker = DatePickerController();

  DateTime selectedValueDatePicker = DateTime.now();
  String StringselectedDate =
      DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();

  void ChangeSelectedDate(value) {
    selectedValueDatePicker = value;
    GetCalenderList(database);

    emit(ChangeSelectedDateState());
  }

  bool value = false;

  void changeChexBox(model) {
    value = !value;
    if (value) {
      UbdateDataFromDataBase(id: model['id'], status: 'Completed');
    } else {
      UbdateDataFromDataBase(id: model['id'], status: 'UnCompleted');
    }
    list.forEach((element) {
      if (element['status'] == 'Completed')
        completed.add(element);
      else if (element['status'] == 'UnCompleted') uncompleted.add(element);
    });
    emit(ChangeChekBoxState());
  }

  Database? database;

  void CreatDataBase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              // productsName TEXT,quantum INTEGER,price1 REAL,date TEXT,
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY ,'
              'Title TEXT ,Date TEXT ,StartTime TEXT ,'
              'EndTime TEXT ,RemindTime TEXT ,RepeatTime TEXT ,status TEXT )')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('error when creating table ${error.toString()}');
      });
    }, onOpen: (database) {
      GetDataFromDataBase(database);
      // GetCalenderList(database);
      print('database opened');
    }).then((value) {
      database = value;
      emit(CreateDataBaseState());
    });
  }

  insertIntoDatabase({
    required String Title,
    required String Date,
    required String StartTime,
    required String EndTime,
    required String RemindTime,
    required String RepeatTime,
  }) async {
    await database!.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks(Title,Date,StartTime,EndTime,RemindTime,RepeatTime,status)'
              'VALUES("$Title","$Date","$StartTime","$EndTime","$RemindTime","$RepeatTime","NEW")')
          .then((value) {
        print('$value insert successfullllllllllllllllly');
        createNotifaction(Title);
        emit(InsertDataBaseState());
        GetDataFromDataBase(database);
      }).catchError((error) {
        print('error when inserting ${error.toString()}');
      });
      return null;
    });
  }

  void createNotifaction(String title) async {
    await AwesomeNotifications().createNotification(
        content: NotificationContent(
            id: 10,
            channelKey: 'basic_channel',
            title: 'Reminder',
            body: title),
        schedule: NotificationCalendar.fromDate(
            date: DateTime.parse(DateController.text + " " + startTime)));
    // "2022-07-27 20:30:04"

    //  AwesomeNotifications().cancel(1);
    //
  }

  List<Map> list = [];
  List<Map> completed = [];
  List<Map> uncompleted = [];
  List<Map> favorite = [];
  List<Map> CalenderList = [];
  void GetDataFromDataBase(database) {
    database.rawQuery('SELECT * FROM tasks').then((value) {
      // list = [];
      completed = [];
      uncompleted = [];
      favorite = [];
      value.forEach((element) {
        if (element['status'] == 'Completed')
          completed.add(element);
        else if (element['status'] == 'UnCompleted')
          uncompleted.add(element);
        else
          favorite.add(element);
      });
      list = value;
      // CalenderList = [];
      // value.forEach(
      //   (element) {
      //     if (element["Date"].contains(StringselectedDate)) {
      //       CalenderList.add(element);
      //     }
      //   },
      // );

      // value.forEach(
      //   (element) {
      //     if (element["Date"].contains(StringselectedDate)) {
      //       tasksInDate.add(value);
      //     }
      //   },
      // );
      // GetCalenderList(database);
      print('list=' '${list}');
      print('list===========================>' '${CalenderList}');

      emit(GetDataBaseState());
    });
  }

  void GetCalenderList(database) {
    CalenderList = [];
    database.rawQuery('SELECT * FROM tasks WHERE Date = ? ',
        [StringselectedDate]).then((value) {
      CalenderList = value;

      // for (var element in list) {
      //   if (element["Date"].contains(StringselectedDate)) {
      //     CalenderList.add(element);
      //   }
      // }
      // value.forEach(
      //   (element) {
      //     if (value == StringselectedDate) {
      //       CalenderList.add(element);
      //       GetDataFromDataBase(database);
      //     }
      //   },
      // );
      print('list===========================>' '${CalenderList}');

      emit(GetCalenderListState());
    });
  }

  void UbdateDataFromDataBase({required String status, required int id}) {
    database!.rawUpdate('UPDATE tasks SET status= ? WHERE id = ?',
        ['$status', id]).then((value) {
      print('UUUUUUbdated');
      emit(UbdateDataBaseState());
      GetDataFromDataBase(database);
    });
  }

  void DeleteDataFromDataBase({required int id}) {
    database!.rawDelete('DELETE FROM tasks WHERE id = ?', [id]).then((value) {
      print('deleted');
      emit(DeleteDataBaseState());
      GetDataFromDataBase(database);
    });
  }

  // selectEndTime(BuildContext context) async {
  //   final TimeOfDay? timeOfDay = await showTimePicker(
  //     context: context,
  //     initialTime: startTime,
  //     initialEntryMode: TimePickerEntryMode.dial,
  //   );
  //   if (timeOfDay != null && timeOfDay != selectedTime) {
  //     StartTimeController.text = timeOfDay.format(context);
  //   }
  // }
}
