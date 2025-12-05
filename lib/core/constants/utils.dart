import 'package:flutter/material.dart';

Color strengthenColor(Color color, double factor) {
  int r = (color.red * factor).clamp(0, 255).toInt();
  int g = (color.green * factor).clamp(0, 255).toInt();
  int b = (color.blue * factor).clamp(0, 255).toInt();
  return Color.fromARGB(color.alpha, r, g, b);
}

List<DateTime> generateWeekDays(int weekOffset) {
  final today = DateTime.now();
  DateTime startOfWeek = today.subtract(Duration(days: today.weekday - 1));
  startOfWeek = startOfWeek.add(Duration(days: weekOffset * 7));
  List<DateTime> weekDays = [];
  for (int i = 0; i < 7; i++) {
    weekDays.add(startOfWeek.add(Duration(days: i)));
  }
  return weekDays;
}
