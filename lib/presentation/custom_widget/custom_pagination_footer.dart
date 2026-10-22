/* 
Created by Neloy on 22 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';

import '../../utilities/app_size.dart';
import '../../utilities/app_text.dart';
import 'custom_titled_divider.dart';

class CustomPaginationFooter extends StatelessWidget {
  final bool isLoadingMore;
  final bool hasMore;
  final String textLoadMoreError;
  final VoidCallback onLoadMore;

  const CustomPaginationFooter({
    super.key,
    required this.isLoadingMore,
    required this.hasMore,
    required this.textLoadMoreError,
    required this.onLoadMore,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoadingMore) {
      return Center(child: SizedBox(
          height: 30,
          width: 30,
          child: CircularProgressIndicator(
            color: AppColor.colorPrimary,
            strokeWidth: 0.5,
          )));
    }
    if (hasMore || textLoadMoreError.isNotEmpty) {
      return Column(
        children: [
          if (textLoadMoreError.isNotEmpty) ...[
            Text(
              textLoadMoreError,
              style: AppText.style.bodySmall,
              textAlign: TextAlign.center,
            ),
            AppSize.gapH10,
          ],
          OutlinedButton.icon(
            onPressed: onLoadMore,
            icon: const Icon(Icons.expand_more_rounded),
            label: Text(
              textLoadMoreError.isEmpty ? AppText.loadMore : AppText.tryAgain,
              style: AppText.style.bodySmall!.copyWith(color: Colors.black),
            ),
          ),
        ],
      );
    }
    return CustomTitledDivider(title: AppText.finished);
  }
}
