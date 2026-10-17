/* 
Created by Neloy on 10 October, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wash_your_cloth_mobile_app/data/model/model_service_list.dart';

import '../../../../../../router/app_router.dart';
import '../../../../../../utilities/app_color.dart';
import '../../../../../../utilities/app_constant.dart';
import '../../../../../../utilities/app_size.dart';
import '../../../../../../utilities/app_text.dart';
import '../../../../../../utilities/app_validator.dart';
import '../../../../../custom_widget/custom_card.dart';
import '../../../../../custom_widget/custom_dialogue.dart';
import '../../../../../custom_widget/custom_list_header.dart';
import '../../../../../custom_widget/custom_not_found.dart';
import '../../../../../custom_widget/custom_snack_bar.dart';
import 'bloc/service_list_bloc.dart';

class ScreenServiceList extends StatefulWidget {
  const ScreenServiceList({super.key});

  @override
  State<ScreenServiceList> createState() => _ScreenServiceListState();
}

class _ScreenServiceListState extends State<ScreenServiceList> {
  bool isUpdate = false;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) return;
        context.pop(isUpdate);
      },
      child: Scaffold(
        appBar: AppBar(title: Text(AppText.serviceList)),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: AppSize.paddingAll25,
            child: Column(
              children: [
                CustomListHeader(
                  textListName: AppText.serviceList,
                  onTap: () => navigateToAddService(context: context),
                  textAddNewListName: AppText.addNewService,
                ),
                AppSize.gapH20,

                BlocConsumer<ServiceListBloc, ServiceListState>(
                  listener: (context, state) {
                    if (state is ServiceListStateLoading) {
                      CallDialogue.showLoader(context);
                    } else if (state is ServiceListStateFetch) {
                      if (!state.isActivating && !state.isUpdating) {
                        CallDialogue.hideLoader(context);
                      }
                    } else if (state is ServiceListStateError) {
                      CallDialogue.hideLoader(context);
                      CallDialogue.showResult(
                        context: context,
                        message: state.message,
                        onOk: () => CallDialogue.hideLoader(context),
                      );
                    } else if (state is ServiceListStateActionResult) {
                      CustomSnackBar.primary(
                        context: context,
                        contentText: state.message,
                        backgroundColor: state.isSuccess
                            ? AppColor.colorPrimary
                            : Colors.redAccent,
                      );
                    }
                  },
                  builder: (context, state) {
                    if (state is ServiceListStateFetch) {
                      if (state.serviceList.isEmpty) {
                        return const CustomNotFound();
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.serviceList.length,
                        separatorBuilder: (context, index) => AppSize.gapH20,
                        itemBuilder: (context, index) {
                          final service = state.serviceList[index];
                          return CustomCard(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 10,
                            ),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        service.serviceName,
                                        style: AppText.style.titleMedium,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            Transform.scale(
                                              scale: 0.5,
                                              child: CupertinoSwitch(
                                                value: service.isActive,
                                                activeTrackColor:
                                                    AppColor.colorPrimary,
                                                onChanged: state.isActivating
                                                    ? null // Disable during pending request
                                                    : (value) {
                                                        _handleServiceActivation(
                                                          context: context,
                                                          serviceId: service.id,
                                                        );
                                                      },
                                              ),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              child: Text(
                                                service.isActive
                                                    ? AppText.active
                                                    : AppText.inactive,
                                                style: AppText.style.bodyLarge!
                                                    .copyWith(fontSize: 8),
                                              ),
                                            ),
                                          ],
                                        ),
                                        IconButton(
                                          onPressed: () =>
                                              navigateToUpdateService(
                                                context: context,
                                                service: service,
                                              ),
                                          icon: Icon(Icons.edit, size: 16),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const Divider(),
                                ExpansionTile(
                                  tilePadding: EdgeInsets.zero,
                                  childrenPadding: EdgeInsets.zero,
                                  splashColor: Colors.transparent,
                                  title: Text(
                                    AppText.description,
                                    style: AppText.style.titleSmall,
                                  ),
                                  children: [
                                    ListTile(
                                      contentPadding: EdgeInsets.zero,
                                      title: Text(
                                        service.description,
                                        style: AppText.style.bodyMedium,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    } else if (state is ServiceListStateLoading ||
                        state is ServiceListStateInitial) {
                      return AppSize.noGap;
                    } else {
                      return const CustomNotFound();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleServiceActivation({
    required BuildContext context,
    required String serviceId,
  }) {
    CallDialogue.showResult(
      context: context,
      message: AppText.serviceActivationAlertMessage,
      onOk: () {
        CallDialogue.hideLoader(context); // Close confirmation alert first
        context.read<ServiceListBloc>().add(
          ServiceListEventActivation(serviceId: serviceId),
        );
        CallDialogue.showLoader(context);
      },
    );
  }

  Future<void> navigateToUpdateService({
    required BuildContext context,
    required ModelServiceList service,
  }) async {
    try {
      final Map? result = await context.push(
        AppRouter.screenServiceUpdate,
        extra: {
          AppConstant.serviceName: service.serviceName,
          AppConstant.description: service.description,
          AppConstant.serviceId: service.id,
        },
      );

      if (result != null && context.mounted) {
        context.read<ServiceListBloc>().add(
          ServiceListEventUpdate(
            description: result[AppConstant.description],
            serviceName: result[AppConstant.serviceName],
            serviceId: service.id,
          ),
        );
        isUpdate = true;
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.primary(
          context: context,
          contentText: AppValidator.validatorServiceUpdateFail,
        );
      }
    }
  }

  Future<void> navigateToAddService({required BuildContext context}) async {
    try {
      final bool? result = await context.push(AppRouter.screenServiceAdd);

      if (result != null && result && context.mounted) {
        context.read<ServiceListBloc>().add(ServiceListEventFetch());
      }
    } catch (e) {
      if (context.mounted) {
        CustomSnackBar.primary(
          context: context,
          contentText: AppValidator.validatorServiceAddFail,
        );
      }
    }
  }
}
