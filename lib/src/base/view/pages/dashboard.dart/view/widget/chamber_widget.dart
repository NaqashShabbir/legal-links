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
    return Column(
      children: [
        Container(
          margin: EdgeInsets.all(4.sp),
          width: 25.w,
          height: 25.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
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
          child: ClipRRect(
            borderRadius: BorderRadius.circular(60),
            child: CachedNetworkImage(
              imageUrl: widget.model.chamberImage ?? "",
              fit: BoxFit.cover,
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
    );
  }
}
