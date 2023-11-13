import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../utils/hights_widths.dart';
import '../../model/reviews_model.dart';

// ignore: must_be_immutable
class FeedbackWidget extends StatefulWidget {
  FeedBackModel model;
  FeedbackWidget({super.key, required this.model});

  @override
  State<FeedbackWidget> createState() => _FeedbackWidgetState();
}

class _FeedbackWidgetState extends State<FeedbackWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(4.sp),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: R.colors.grey)),
      width: 55.w,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Row(
              children: [
                Icon(
                  Icons.thumb_up,
                  color: R.colors.primary,
                ),
                w2,
                Text(
                  widget.model.name ?? '',
                  style: R.textStyles.poppinsMedium(),
                )
              ],
            ),
          ),
          h0P5,
          Padding(
            padding: EdgeInsets.all(8.sp),
            child: Text(
              widget.model.feedBack ?? '',
              style: R.textStyles.poppinsRegular(),
            ),
          ),
          h1,
          Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 171, 200, 226),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            padding: EdgeInsets.all(8.sp),
            height: 5.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.model.review ?? '',
                    style: R.textStyles.poppinsMedium()),
                RatingBar.builder(
                  initialRating: widget.model.initRaating ?? 2.0,
                  itemSize: 10.sp,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  //itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: R.colors.orange,
                  ),
                  onRatingUpdate: (rating) {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
