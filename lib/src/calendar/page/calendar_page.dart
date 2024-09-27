import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:turizm_uz/core/common/widgets/buttons.dart';
import 'package:turizm_uz/core/common/widgets/text_widgets.dart';
import 'package:turizm_uz/core/res/const_colors.dart';
import 'package:turizm_uz/core/utils/core_utils.dart';

import '../../../core/res/const_icons.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key, this.startDate, this.endDate});

  final DateTime? startDate;
  final DateTime? endDate;

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime? startDate;
  DateTime? endDate;

  final DateTime currentDate = DateTime.now();
  final DateFormat formatter = DateFormat('MM.dd.yyyy');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBackground,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: CircleAvatar(
            radius: 20,
            backgroundColor: colorPrimary,
            child: Icon(
              Icons.arrow_back_ios_new,
              color: colorWhite,
              size: 20,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        title: text16Poppins("Kalendar"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(color: colorWhite, border: Border.all(color: colorGreyF2, width: 1), borderRadius: BorderRadius.circular(16)),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        text12Poppins('dan'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ConstIcons.calendar,
                              height: 24,
                            ),
                            const Gap(8),
                            text16Poppins(formatDate(startDate ?? DateTime.now()), color: colorPrimary),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    color: colorGreyF2,
                    width: 1,
                    height: 50,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        text12Poppins('gacha'),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              ConstIcons.calendar,
                              height: 24,
                            ),
                            const Gap(8),
                            text16Poppins(formatDate(endDate ?? startDate ?? DateTime.now()), color: colorPrimary),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: colorWhite, border: Border.all(color: colorGreyF2, width: 1), borderRadius: BorderRadius.circular(16)),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  _calendarWidget(),
                  const SizedBox(height: 20),
                  defSecondaryButton('Davom etish', () {}),
                  const Gap(8),
                  ghostSecondaryButton('Tozalash', () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _calendarWidget() {
    return SfDateRangePicker(
      view: DateRangePickerView.month,
      selectionMode: DateRangePickerSelectionMode.range,
      backgroundColor: colorWhite,
      navigationDirection: DateRangePickerNavigationDirection.vertical,
      startRangeSelectionColor: colorPrimary,
      endRangeSelectionColor: colorPrimary,
      selectionTextStyle: TextStyle(color: colorWhite, fontSize: 14, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      selectionShape: DateRangePickerSelectionShape.rectangle,
      navigationMode: DateRangePickerNavigationMode.snap,
      headerStyle: DateRangePickerHeaderStyle(
        backgroundColor: colorWhite,
        textAlign: TextAlign.center,
        textStyle: TextStyle(color: colorDefTex, fontSize: 16, fontWeight: FontWeight.w500, fontFamily: 'Poppins'),
      ),
      initialSelectedRange: PickerDateRange(widget.startDate, widget.endDate),
      initialDisplayDate: widget.startDate ?? DateTime.now(),
      todayHighlightColor: colorPrimary,
      onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
        if (args.value is PickerDateRange) {
          startDate = args.value.startDate;
          endDate = args.value.endDate;
          setState(() {});
        }
      },
    );
  }
}
