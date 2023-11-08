import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../../resources/app_images.dart';
import '../../../../../../../resources/resources.dart';
import '../../../../../../../utils/hights_widths.dart';
import '../../model/review_model.dart';

class ReviewsWidget extends StatelessWidget {
  final ReviewModel model;

  ReviewsWidget({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CachedNetworkImage(
                imageUrl: model?.img ?? AppImages.dummyImage,
                imageBuilder: (context, imageProvider) => Container(
                  height: 13.w,
                  width: 13.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: R.colors.primary, width: 1),
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                fit: BoxFit.cover,
                errorWidget: (context, url, e) => SizedBox(
                    height: 13.w, width: 13.w, child: const Icon(Icons.error)),
                placeholder: (context, url) {
                  return Center(
                      child: SizedBox(
                    height: 13.w,
                    width: 13.w,
                    child: CircularProgressIndicator.adaptive(
                        backgroundColor: R.colors.primary),
                  ));
                },
              ),
            ),
            w3,
            Text(
              model?.userName ?? "",
              style: R.textStyles.poppinsSemiBold(),
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        h1,
        Row(
          children: [
            RatingBar.builder(
              initialRating: 2.0,
              itemSize: 15.sp,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 3.0),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: R.colors.primary,
              ),
              onRatingUpdate: (rating) {},
            ),
            w3,
            Text(
              DateFormat('dd-MM-yyyy  ').format(DateTime.now()),
              style: R.textStyles.poppinsRegular(),
            ),
          ],
        ),
        h1,
        Text(model?.review ?? "", style: R.textStyles.poppinsRegular()),
        h1
      ],
    );
  }
}
