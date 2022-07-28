// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

void NavTo(context, Widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => Widget));

void NavAndFinish(context, Widget) => Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context) => Widget), (route) => false);

class Devider extends StatelessWidget {
  const Devider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.5,
      width: double.infinity,
      color: Colors.grey,
    );
  }
}

class DeviderSizedBox extends StatelessWidget {
  const DeviderSizedBox({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 15,
    );
  }
}

Widget SmallButton(
  context, {
  @required String? text,
  @required Widget? widget,
}) =>
    MaterialButton(
      onPressed: () {
        NavTo(context, widget);
      },
      child: Text(
        text!,
        style: const TextStyle(
          color: Colors.teal,
          fontSize: 16,
        ),
      ),
    );

Widget BigButton(
  context, {
  @required String? text,
  required Widget widget,
}) =>
    Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xff25c06d),
      ),
      child: MaterialButton(
        onPressed: () {
          NavTo(context, widget);
        },
        child: Text(
          text!,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

Widget DefaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onchange,
  validate,
  required String hint,
  IconData? suffix,
  Function? suffixPressed,
  Function? tapPressed,
}) =>
    Container(
      decoration: BoxDecoration(
        color: Color(0xfff9f9f9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        validator: validate,
        controller: controller,
        keyboardType: type,
        onTap: () {
          tapPressed!();
        },
        onChanged: (value) {
          onchange;
        },
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.grey, textBaseline: TextBaseline.alphabetic),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xfff9f9f9),
            ),
            gapPadding: 5,
            borderRadius: BorderRadius.circular(15),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.transparent,
            ),
          ),
          suffixIcon: IconButton(
            onPressed: () {
              suffixPressed!();
            },
            icon: Icon(
              suffix,
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
