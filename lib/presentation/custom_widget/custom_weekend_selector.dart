/* 
Created by Neloy on 10 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_size.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_text.dart';

class CustomWeekendSelector extends StatefulWidget {
  final String initialSelectedDays; // Accept "Sunday,Friday" format
  final ValueChanged<String>? onChanged;

  const CustomWeekendSelector({
    super.key,
    required this.initialSelectedDays,
    this.onChanged,
  });

  @override
  State<CustomWeekendSelector> createState() => _CustomWeekendSelectorState();
}

class _CustomWeekendSelectorState extends State<CustomWeekendSelector> {
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
    if (widget.onChanged != null) {
      setState(() {
        if (checked == true) {
          if (!_selectedDays.contains(day)) _selectedDays.add(day);
        } else {
          _selectedDays.remove(day);
        }
      });
      widget.onChanged?.call(_selectedDays.join(','));
    }
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
            color: !isChecked ? Colors.black : AppColor.colorDanger,
          ),
          backgroundColor: AppColor.colorPrimaryTextSelection,
          selected: isChecked,
          color: WidgetStateColor.resolveWith((state) {
            return Colors.white;
          }),
          shape: RoundedRectangleBorder(
            borderRadius: AppSize.borderRadiusAll8,
            side: BorderSide(
              color: isChecked ? AppColor.colorPrimary : Colors.black,
              width: isChecked ? 1 : 0.5,
            ),
          ),
          onSelected: (bool selected) => _onDayToggled(selected, day),
        );
      }).toList(),
    );
  }
}
