import 'package:flutter/material.dart';
import 'package:global_template/global_template.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import './card_calendar.dart';

class CalendarHorizontal extends StatefulWidget {
  @override
  _CalendarHorizontalState createState() => _CalendarHorizontalState();
}

class _CalendarHorizontalState extends State<CalendarHorizontal> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();
  DateTime now;
  @override
  void initState() {
    now = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(now.day);
    return Stack(
      children: [
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  globalF.formatYearMonth(now),
                  style: appTheme.headline6(context),
                  textAlign: TextAlign.left,
                ),
              ),
              const SizedBox(height: 10),
              Container(
                height: sizes.height(context) / 8,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                child: ScrollablePositionedList.builder(
                  initialScrollIndex: now.day,
                  initialAlignment: .6,
                  itemCount: globalF.totalDaysOfMonth(
                    now.year,
                    now.month,
                  ),
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return CardCalendar(now: now, index: index);
                  },
                ),
              ),
              SizedBox(height: 10),
            ],
            crossAxisAlignment: CrossAxisAlignment.stretch,
          ),
        ),
        Positioned(
          child: Row(
            children: [
              InkWell(
                  child: const Icon(FontAwesomeIcons.angleLeft, size: 18), onTap: () => print('')),
              const SizedBox(width: 20),
              InkWell(child: const Icon(FontAwesomeIcons.angleRight, size: 18)),
              const SizedBox(width: 20),
              InkWell(
                child: const Icon(FontAwesomeIcons.calendar, size: 18),
                onTap: () => itemScrollController.scrollTo(
                  index: now.day,
                  alignment: .6,
                  duration: Duration(seconds: 2),
                ),
              ),
            ],
          ),
          top: 10,
          right: 30,
        )
      ],
    );
  }
}
