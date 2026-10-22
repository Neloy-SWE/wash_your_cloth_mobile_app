/*
Created by Neloy on 20 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_card.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_icon_frame.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_not_found.dart';
import 'package:wash_your_cloth_mobile_app/presentation/custom_widget/custom_snack_bar.dart';

import '../../../../data/model/model_notification_list.dart';
import '../../../../presentation/bloc_global/global_bloc.dart';
import '../../../../presentation/screen/notification/bloc/notification_status_bloc.dart';
import '../../../../router/app_router.dart';
import '../../../../utilities/app_color.dart';
import '../../../../utilities/app_constant.dart';
import '../../../../utilities/app_size.dart';
import '../../../../utilities/app_text.dart';
import '../../../custom_widget/custom_pagination_footer.dart';
import 'bloc/notification_list_bloc.dart';

class ScreenNotificationList extends StatelessWidget {
  const ScreenNotificationList({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<NotificationStatusBloc, NotificationStatusState>(
          listenWhen: (previous, current) =>
              previous.latestNotification?.id !=
                  current.latestNotification?.id &&
              current.latestNotification != null,
          listener: (context, state) {
            context.read<NotificationListBloc>().add(
              NotificationListEventNewNotification(
                notification: state.latestNotification!,
              ),
            );
          },
        ),
        BlocListener<NotificationListBloc, NotificationListState>(
          listenWhen: (previous, current) =>
              previous.lastReadNotificationId !=
                  current.lastReadNotificationId &&
              current.lastReadNotificationId != null,
          listener: (context, state) {
            context.read<NotificationStatusBloc>().add(
              const NotificationStatusEventRefresh(),
            );
          },
        ),
        BlocListener<NotificationListBloc, NotificationListState>(
          listenWhen: (previous, current) =>
              previous.actionError != current.actionError &&
              current.actionError.isNotEmpty,
          listener: (context, state) {
            if (state.actionError.isNotEmpty) {
              CustomSnackBar.primary(
                context: context,
                contentText: state.actionError,
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppText.notifications),
          actions: [
            IconButton(
              onPressed: () => context.read<NotificationListBloc>().add(
                NotificationListEventFetch(),
              ),
              icon: const Icon(Icons.refresh),
            ),
            AppSize.gapW15,
          ],
        ),
        body: SafeArea(
          child: BlocBuilder<NotificationListBloc, NotificationListState>(
            builder: (context, state) {
              if (state.isLoading && state.notifications.isEmpty) {
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColor.colorPrimary,
                  ),
                );
              }
              if (state.error.isNotEmpty && state.notifications.isEmpty) {
                return CustomNotFound();
              }

              return RefreshIndicator(
                color: AppColor.colorPrimary,
                onRefresh: () async {
                  final bloc = context.read<NotificationListBloc>();
                  if (bloc.state.isLoading) return;
                  final fetchStarted = bloc.stream.firstWhere(
                    (next) => next.isLoading,
                  );
                  bloc.add(NotificationListEventFetch());
                  await fetchStarted;
                  await bloc.stream.firstWhere((next) => !next.isLoading);
                },
                child: SingleChildScrollView(
                  padding: AppSize.paddingAll25,
                  child: Column(
                    children: [
                      notificationHeader(totalCount: state.totalItem),
                      AppSize.gapH35,
                      if (state.notifications.isEmpty) ...[
                        emptyView(),
                      ] else ...[
                        ListView.separated(
                          itemCount: state.notifications.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) => notificationCard(
                            notification: state.notifications[index],
                            context: context,
                          ),
                          separatorBuilder: (context, index) => AppSize.gapH15,
                        ),
                      ],
                      if (state.notifications.isNotEmpty) ...[
                        AppSize.gapH20,
                        CustomPaginationFooter(
                          hasMore: state.hasMore,
                          isLoadingMore: state.isLoadingMore,
                          textLoadMoreError: state.loadMoreError,
                          onLoadMore: () => context
                              .read<NotificationListBloc>()
                              .add(NotificationListEventLoadMore()),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget notificationHeader({required int totalCount}) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColor.colorPrimary, AppColor.colorBackgroundIconTop],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: AppSize.borderRadiusAll10,
        boxShadow: [
          BoxShadow(
            color: AppColor.colorPrimaryTextSelection,
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CustomIconFrame(
            size: 52,
            iconData: Icons.notifications_active_outlined,
          ),
          AppSize.gapW15,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppText.stayInTheLoop,
                  style: AppText.style.titleMedium!.copyWith(
                    color: Colors.white,
                  ),
                ),
                AppSize.gapH03,
                Text(
                  totalCount == 0
                      ? AppText.noNewNotification
                      : "$totalCount ${AppText.updatesForYou}",
                  style: AppText.style.bodyMedium!.copyWith(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          AppSize.gapW05,
          BlocBuilder<NotificationStatusBloc, NotificationStatusState>(
            builder: (context, state) {
              if (state.unreadCount == 0) return AppSize.noGap;
              return CustomCard(
                child: Text(
                  "${state.unreadCount} ${AppText.unread}",
                  style: AppText.style.bodySmall!.copyWith(
                    color: AppColor.colorPrimary,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget notificationCard({
    required BuildContext context,
    required NotificationItem notification,
  }) {
    final unread = !notification.isRead;
    return CustomCardWithAction(
      onTap: () =>
          _onNotificationTap(context: context, notification: notification),
      colorBackground: unread ? AppColor.colorBackgroundUnread : Colors.white,
      colorBorder: unread
          ? AppColor.colorBoarderUnread
          : AppColor.colorBorderCard,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomIconFrame(
            size: 46,
            sizeIcon: 25,
            iconData: Icons.local_laundry_service_outlined,
            colorBackground: unread
                ? AppColor.colorPrimaryTextSelection
                : AppColor.colorBackgroundInactive,
            colorIcon: unread ? AppColor.colorPrimary : AppColor.colorHint,
          ),
          AppSize.gapW10,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        notification.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppText.style.titleSmall,
                      ),
                    ),
                    if (unread) ...[
                      AppSize.gapW05,
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColor.colorPrimary,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ],
                ),
                AppSize.gapH05,
                Text(
                  notification.message,
                  style: AppText.style.bodyMedium!.copyWith(
                    color: AppColor.colorHint,
                    fontSize: 13,
                  ),
                ),
                AppSize.gapH10,
                Row(
                  children: [
                    const Icon(
                      Icons.schedule_rounded,
                      size: 14,
                      color: AppColor.colorHint,
                    ),
                    AppSize.gapW05,
                    Text(
                      DateFormat(
                        "MMM d, yyyy · h:mm a",
                      ).format(notification.createdAt.toLocal()),
                      style: AppText.style.bodySmall!.copyWith(
                        color: AppColor.colorHint,
                        fontSize: 11,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_forward_rounded,
                      size: 14,
                      color: AppColor.colorPrimary,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget emptyView() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 36),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: const BoxDecoration(
                color: AppColor.colorPrimaryTextSelection,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.notifications_none_rounded,
                size: 42,
                color: AppColor.colorPrimary,
              ),
            ),
            AppSize.gapH20,
            Text(
              AppText.emptyNotificationTitle,
              textAlign: TextAlign.center,
              style: AppText.style.titleMedium,
            ),
            AppSize.gapH10,
            Text(
              AppText.emptyNotificationSubtitle,
              textAlign: TextAlign.center,
              style: AppText.style.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }

  void _onNotificationTap({
    required BuildContext context,
    required NotificationItem notification,
  }) {
    if (!notification.isRead) {
      context.read<NotificationListBloc>().add(
        NotificationListEventMarkRead(notificationId: notification.id),
      );
    }

    if (notification.navigation == AppConstant.orderDetails &&
        notification.metaData.isNotEmpty) {
      final role = context.read<GlobalBloc>().state.role;
      final path = role == Role.shop
          ? AppRouter.screenOrderDetailsShop
          : AppRouter.screenOrderDetailsUser;
      context.push(path, extra: notification.metaData);
    }
  }
}
