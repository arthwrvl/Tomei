import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendario extends StatefulWidget {
  @override
  _CalendarioState createState() => _CalendarioState();
}

class _CalendarioState extends State<Calendario> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  TextEditingController _eventController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            TableCalendar(
              locale: Intl.canonicalizedLocale(Platform.localeName),
              calendarController: _controller,
              events: _events,
              weekendDays: [7],
              rowHeight: 40,
              calendarStyle: buildCalendarStyle(),
              headerStyle: buildHeaderStyle(),
              builders: CalendarBuilders(
                markersBuilder: (context, date, events, holidays) {
                  final children = <Widget>[];

                  if (events.isNotEmpty) {
                    children.add(
                      Positioned(
                        bottom: 5,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _controller.isSelected(date)
                                ? Color(0xFFECF0F1)
                                : _controller.isToday(date)
                                    ? Color(0xFFECF0F1)
                                    : Color(0xFFE74C3C),
                          ),
                          width: 6,
                          height: 6,
                        ),
                      ),
                    );
                  }
                  return children;
                },
              ),
            ),
          ],
        ),
      ),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: _showAddDialog,
      ),*/
    );
  }

  _showAddDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: _eventController,
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if (_eventController.text.isEmpty) return;
              _eventController.clear();
              Navigator.pop(context);
              setState(() {
                print(_eventController.text);
                if (_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay].add(_eventController.text);
                } else {
                  _events[_controller.selectedDay] = [_eventController.text];
                }
              });
            },
            child: Text("save"),
          ),
        ],
      ),
    );
  }
}

CalendarStyle buildCalendarStyle() {
  return CalendarStyle(
    contentPadding: EdgeInsets.all(15),
    markersPositionBottom: 5,
    markersMaxAmount: 1,
    eventDayStyle: TextStyle(
        color: Color(0xFFE74C3C), fontSize: 16, fontWeight: FontWeight.w900),
    canEventMarkersOverflow: false,
    markersColor: Colors.white,
    weekdayStyle: TextStyle(
        color: Color(0xFF828282), fontSize: 15, fontWeight: FontWeight.w800),
    weekendStyle: TextStyle(
        color: Color(0xFF828282), fontSize: 15, fontWeight: FontWeight.w800),
    outsideWeekendStyle: TextStyle(color: Color(0x44828282)),
    todayColor: Color(0x22E74C3C),
    outsideStyle: TextStyle(color: Color(0x44828282)),
    todayStyle: TextStyle(
        color: Color(0xFF828282), fontSize: 15, fontWeight: FontWeight.bold),
    selectedColor: Color(0xFFE74C3C),
    selectedStyle: TextStyle(
        color: Color(0xFFECF0F1), fontSize: 15, fontWeight: FontWeight.w900),
    cellMargin: EdgeInsets.all(6),
  );
}

HeaderStyle buildHeaderStyle() {
  return HeaderStyle(
    formatButtonVisible: false,
    headerPadding: EdgeInsets.fromLTRB(0, 5, 0, 5),
    titleTextBuilder: (date, locale) =>
        capitalize(DateFormat.MMMM(locale).format(date)) +
        ', ' +
        DateFormat.y(locale).format(date),
    titleTextStyle: TextStyle(
        color: Color(0xFF828282), fontSize: 18, fontWeight: FontWeight.w700),
    rightChevronIcon:
        Icon(Icons.arrow_forward_ios, size: 18, color: Color(0xFF828282)),
    leftChevronIcon:
        Icon(Icons.arrow_back_ios, size: 18, color: Color(0xFF828282)),
    leftChevronPadding: EdgeInsets.fromLTRB(11, 0, 0, 0),
  );
}

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
