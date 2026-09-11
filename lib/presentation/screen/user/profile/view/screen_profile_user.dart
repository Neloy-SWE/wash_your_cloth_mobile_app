/* 
Created by Neloy on 13 July, 2026.
Email: taufiqneloy.swe@gmail.com
*/

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_color.dart';
import 'package:wash_your_cloth_mobile_app/utilities/app_helper.dart';

import '../../../../../utilities/app_size.dart';
import '../../../../../utilities/app_text.dart';
import '../../../../custom_widget/custom_button.dart';
import '../../../../custom_widget/custom_card.dart';
import '../../../../custom_widget/custom_dialogue.dart';
import '../../../../custom_widget/custom_not_found.dart';
import '../../../../custom_widget/custom_title.dart';
import 'bloc/profile_view_user_bloc.dart';

class ScreenProfileUser extends StatelessWidget {
  const ScreenProfileUser({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileViewUserBloc, ProfileViewUserState>(
      listener: (context, state) {
        if (state is ProfileViewUserStateLoading) {
          CallDialogue.showLoader(context);
        } else if (state is ProfileViewUserStateFetch) {
          CallDialogue.hideLoader(context);
        } else if (state is ProfileViewUserStateResult) {
          CallDialogue.hideLoader(context);
          CallDialogue.showResult(
            context: context,
            message: state.message,
            onOk: () {
              CallDialogue.hideLoader(context);
            },
          );
        }
      },
      builder: (context, state) {
        if (state is ProfileViewUserStateFetch) {
          final profile = state.profileViewUser;
          return SingleChildScrollView(
            padding: AppSize.paddingAll25,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 80,
                            width: 80,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColor.colorBackgroundCard,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.person,
                              color: AppColor.colorPrimary,
                              size: 40,
                            ),
                          ),
                          AppSize.gapH05,
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text:
                                      "${profile.firstName} ${profile.lastName} ",
                                  style: AppText.style.titleMedium,
                                ),
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.top,
                                  child: Icon(
                                    profile.verified
                                        ? Icons.verified
                                        : Icons.error,
                                    color: profile.verified
                                        ? AppColor.colorPrimary
                                        : AppColor.colorDanger,
                                    size: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSize.gapW05,
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_note),
                    ),
                  ],
                ),
                AppSize.gapH35,
                CustomCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: CustomTitleWithIconValue(
                              iconData: Icons.phone,
                              title: AppText.phone,
                              value: hidePhoneOrEmail(
                                phoneOrEmail: profile.phone,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.edit,
                              color: AppColor.colorPrimary,
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                      CustomTitleWithIconValue(
                        iconData: Icons.location_on,
                        title: AppText.address,
                        value: profile.address,
                      ),
                    ],
                  ),
                ),

                AppSize.gapH150,
                CustomButton(
                  onPressed: () {
                    // context.push(AppRouter.screenProfileUpdatePassword);
                  },
                  buttonText: AppText.updatePassword,
                ),
                AppSize.gapH20,
                CustomButton(
                  onPressed: () {
                    // context.go(AppRouter.screenAuthLogin);
                  },
                  buttonText: AppText.logout,
                  textColor: AppColor.colorDanger,
                  colorButton: Colors.white,
                  colorBorder: AppColor.colorDanger,
                ),
                AppSize.gapH35,
              ],
            ),
          );
        } else {
          return CustomNotFound();
        }
      },
    );
  }
}
