/* 
Created by Neloy on 24 August, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';

import '../../utilities/app_color.dart';
import '../../utilities/app_size.dart';
import '../../utilities/app_text.dart';
import 'custom_card.dart';

class CustomDetailsItem extends StatelessWidget {
  final String title;
  final String value;

  const CustomDetailsItem({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: AppText.style.bodyMedium?.copyWith(
                color: AppColor.colorHint,
              ),
            ),
          ),
          AppSize.gapW05,
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppText.style.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomDetailsItemWithCard extends StatelessWidget {
  final String title;
  final String value;

  const CustomDetailsItemWithCard({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.all(15),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              textAlign: TextAlign.start,
              style: AppText.style.titleSmall,
            ),
          ),
          AppSize.gapW05,
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: AppText.style.titleSmall,
            ),
          ),
        ],
      ),
    );
  }
}

class CustomResultItem extends StatelessWidget {
  final String title;
  final String value;

  const CustomResultItem({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSize.paddingAll10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppSize.borderRadiusAll8,
        border: Border.all(color: AppColor.colorPrimary, width: 1),
      ),
      child: Row(
        mainAxisAlignment: .spaceBetween,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),

          Text(value, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    );
  }
}
