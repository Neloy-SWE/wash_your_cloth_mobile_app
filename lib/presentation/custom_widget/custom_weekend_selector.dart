/* 
Created by Neloy on 10 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

class WeekendSelector extends StatefulWidget {
  final String initialSelectedDays; // Accept "Sunday,Friday" format
  final ValueChanged<String> onChanged;

  const WeekendSelector({
    super.key,
    required this.initialSelectedDays,
    required this.onChanged,
  });

  @override
  State<WeekendSelector> createState() => _WeekendSelectorState();
}

class _WeekendSelectorState extends State<WeekendSelector> {
  final List<String> _daysOfWeek = [
    'Saturday',
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
  ];

  final List<String> _selectedDays = [];

  @override
  void initState() {
    super.initState();
    _parseInitialDays();
  }

  void _parseInitialDays() {
    if (widget.initialSelectedDays.isNotEmpty) {
      _selectedDays.addAll(
        widget.initialSelectedDays
            .split(',')
            .where((day) => day.trim().isNotEmpty),
      );
    }
  }

  void _onDayToggled(bool? checked, String day) {
    setState(() {
      if (checked == true) {
        if (!_selectedDays.contains(day)) _selectedDays.add(day);
      } else {
        _selectedDays.remove(day);
      }
    });
    widget.onChanged(_selectedDays.join(','));
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: _daysOfWeek.map((day) {
        final isChecked = _selectedDays.contains(day);
        return FilterChip(
          label: Text(day),
          labelStyle: AppText.style.titleSmall!.copyWith(
            color: !isChecked ? Colors.black : AppColor.colorPrimary,
          ),
          backgroundColor: AppColor.colorPrimaryTextSelection,
          selected: isChecked,
          onSelected: (bool selected) => _onDayToggled(selected, day),
        );
      }).toList(),
    );
  }
}
