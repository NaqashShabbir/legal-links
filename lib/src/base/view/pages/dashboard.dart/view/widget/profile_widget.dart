// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/lawyers_model.dart';
import 'package:sizer/sizer.dart';

import '../../../../../../../resources/resources.dart';
import '../../../../../../../utils/hights_widths.dart';

class ProfileWidget extends StatefulWidget {
  LawyersModel model;

  ProfileWidget({super.key, required this.model});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        visitProfileFn();
      },
      child: Container(
        margin: EdgeInsets.all(4.sp),
        width: 40.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: R.colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.20),
              offset: const Offset(-5, -2),
              blurRadius: 12,
            ),
            BoxShadow(
              color: Colors.grey.withOpacity(0.20),
              offset: const Offset(3, 3),
              blurRadius: 12,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.bottomCenter,
              children: [
                ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(12)),
                  child: SizedBox(
                    height: 16.h,
                    width: 40.w,
                    child: CachedNetworkImage(
                      imageUrl: widget.model.profileImageUrl ?? "",
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            h1,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.model.lawyerType ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: R.textStyles.poppinsMedium(fontSize: 11.sp),
                        ),
                        Text(
                          widget.model.location ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: R.textStyles.poppinsRegular(fontSize: 10.sp),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: visitProfileFn,
                    child: Container(
                      padding: EdgeInsets.all(4.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.0),
                        color: R.colors.primary,
                      ),
                      child: Text(
                        "Visit Profile",
                        style: R.textStyles.poppinsMedium(
                          fontSize: 7.sp,
                          color: R.colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            h1,
          ],
        ),
      ),
    );
  }

  void visitProfileFn() {
    //Get.toNamed(ProfileDetailScreen.route, arguments: {"model": widget.model});
  }
}
