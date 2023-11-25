import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:legal_links_app/src/base/view/pages/dashboard.dart/model/chamber_model.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../utils/hights_widths.dart';

class ChamberWidget extends StatefulWidget {
  ChamberModel model;
  ChamberWidget({super.key, required this.model});

  @override
  State<ChamberWidget> createState() => _ChamberWidgetState();
}

class _ChamberWidgetState extends State<ChamberWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 25.w,
      // margin: EdgeInsets.symmetric(vertical: 4.sp),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.all(4.sp),
            height: 20.w,
            width: 20.w,
            decoration: R.decoration.decoration(radius: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: CachedNetworkImage(
                imageUrl: widget.model.image ?? "",
                fit: BoxFit.cover,
                height: 20.w,
                width: 20.w,
                errorWidget: (context, url, error) {
                  return SizedBox(
                    height: 20.w,
                    width: 20.w,
                    child: const Icon(Icons.error_rounded),
                  );
                },
              ),
            ),
          ),
          h1,
          Text(
            widget.model.name ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: R.textStyles.poppinsMedium(fontSize: 11.sp),
          )
        ],
      ),
    );
  }
}
