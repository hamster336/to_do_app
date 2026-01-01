import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/bloc/task_bloc.dart';
import 'package:to_do_app/models/task.dart';
import 'package:to_do_app/models/task_filter_enum.dart';

class CustomWidgets {
  // priority popUpMenu
  static PopupMenuItem<String> priorityMenuItem(
    String value,
    String text,
    Priority currentPriority,
    Priority priority,
  ) {
    return PopupMenuItem(
      value: value,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: (currentPriority == priority) ? Colors.orange : null,
        ),
      ),
    );
  }

  // TaskSort popUpMenu
  static PopupMenuItem<String> sortMenuItem(
    String value,
    String text,
    TaskLoaded state,
    TaskSort sort,
  ) {
    final isThisSort = state.sort == sort;
    return PopupMenuItem(
      value: value,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: (isThisSort) ? Colors.orange : null,
        ),
      ),
    );
  }

  // filter buttons
  static ElevatedButton filterButtons({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required Size size,
  }) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 15),
        foregroundColor: isSelected
            ? const Color.fromARGB(255, 251, 140, 0)
            : null,
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: size.shortestSide * 0.035,
          fontFamily: 'Afacad',
          letterSpacing: 0.5,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  // show date picker
  static Future<DateTime?> pickDueDate(BuildContext context, Task? task) async {
    final date = await showDatePicker(
      context: context,
      initialDate: task?.dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return null;

    return date;
  }

  // show fromTo date picker
  static Future<void> showFromTo(BuildContext context) async {
    DateTime? fromDate;
    DateTime? toDate;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Select Date Range'),

              content: Column(
                mainAxisSize: .min,
                mainAxisAlignment: .center,
                children: [
                  // pick fromDate
                  dateField(
                    label: 'From',
                    date: fromDate,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        /* Initial Date is today if toDate is null 
                           else, if toDate is before today, initial day is toDate else is today */
                        initialDate: (toDate == null)
                            ? DateTime.now()
                            : (toDate!.isBefore(DateTime.now()))
                            ? DateTime(toDate!.year, toDate!.month, toDate!.day)
                            : DateTime.now(),
                        firstDate: DateTime(2000),
                        // LastDate is only upto toDate, not beyond toDate
                        lastDate: (toDate != null)
                            ? DateTime(toDate!.year, toDate!.month, toDate!.day)
                            : DateTime(2100),
                      );
                      if (picked != null) setState(() => fromDate = picked);
                    },
                  ),

                  const SizedBox(height: 20),

                  // pick toDate
                  dateField(
                    label: 'To',
                    date: toDate,
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        /* Initial Date is today if fromDate is null 
                           else, if fromDate is after today, initial day is fromDate else is today */
                        initialDate: (fromDate == null)
                            ? DateTime.now()
                            : (fromDate!.isAfter(DateTime.now()))
                            ? DateTime(
                                fromDate!.year,
                                fromDate!.month,
                                fromDate!.day,
                              )
                            : DateTime.now(),
                        // firstDate is after fromDate only, not before
                        firstDate: (fromDate != null)
                            ? DateTime(
                                fromDate!.year,
                                fromDate!.month,
                                fromDate!.day,
                              )
                            : DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (picked != null) setState(() => toDate = picked);
                    },
                  ),

                  const SizedBox(height: 20),
                ],
              ),

              // cancel or find the tasks within the selected range
              actions: [
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),

                ElevatedButton(
                  onPressed: () {
                    if (fromDate == null || toDate == null) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content: Text(
                            'Fields cannot be left empty!',
                            style: TextStyle(fontSize: 18),
                          ),
                          actions: [
                            ElevatedButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Ok'),
                            ),
                          ],
                        ),
                      );
                    } else {
                      context.read<TaskBloc>().add(
                        SortByDateRange(fromDate!, toDate!),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: const Text('Find'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // date field for from To
  static Widget dateField({
    required String label,
    DateTime? date,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        child: Text(
          (date == null)
              ? 'Select date'
              : DateFormat('dd MMM yyyy').format(date),
        ),
      ),
    );
  }
}
