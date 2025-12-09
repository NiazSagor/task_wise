import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_wise/core/constants/utils.dart';

class DateSelector extends StatefulWidget {
  DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  DateSelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<DateSelector> createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  int weekOffset = 0;
  final ScrollController _scrollController = ScrollController();
  static const double _itemWidth = 78.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  @override
  void didUpdateWidget(covariant DateSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedDate != oldWidget.selectedDate) {
      _scrollToSelectedDate();
    }
  }

  void _scrollToSelectedDate() {
    if (!_scrollController.hasClients) return;

    final weekDates = generateWeekDays(weekOffset);

    final initialIndex = weekDates.indexWhere((date) {
      return date.day == widget.selectedDate.day &&
          date.month == widget.selectedDate.month &&
          date.year == widget.selectedDate.year;
    });

    if (initialIndex != -1) {
      double offset = initialIndex * _itemWidth;
      _scrollController.animateTo(
        offset,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    }
  }

  void _changeWeek(int delta) {
    setState(() {
      weekOffset += delta;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelectedDate();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final weekDates = generateWeekDays(weekOffset);
    String monthName = DateFormat("MMMM").format(weekDates[0]);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  _changeWeek(-1);
                },
                icon: Icon(Icons.arrow_back_ios),
              ),
              Text(
                monthName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              IconButton(
                onPressed: () {
                  _changeWeek(1);
                },
                icon: Icon(Icons.arrow_forward_ios),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SizedBox(
            height: 80,
            child: ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: weekDates.length,
              itemBuilder: (context, index) {
                final date = weekDates[index];
                bool isSelected =
                    DateFormat("d").format(widget.selectedDate) ==
                        DateFormat("d").format(date) &&
                    widget.selectedDate.month == date.month &&
                    widget.selectedDate.year == date.year;
                return GestureDetector(
                  onTap: () => widget.onDateSelected(date),
                  child: Container(
                    margin: EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? Colors.deepOrangeAccent : null,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isSelected
                            ? Colors.deepOrangeAccent
                            : Colors.grey.shade300,
                        width: 3,
                      ),
                    ),
                    width: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          DateFormat("d").format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          DateFormat("E").format(date),
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
