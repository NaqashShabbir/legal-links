import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:legal_links_app/src/base/view/pages/settings/view/widgets/reviews_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../../../../../../resources/resources.dart';
import '../../../../../../utils/common-widgets/global_widget.dart';
import '../../../../../../utils/hights_widths.dart';
import '../vm/settings_vm.dart';

class RatingAndReviewsScreen extends StatelessWidget {
  static String route = '/ratingandreviews';
  const RatingAndReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalWidgets.appBar('Rating and Reviews'),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.sp, vertical: 10.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  'Rating and reviews are verified and they are from who the same type of device that you use',
                  style: R.textStyles.poppinsRegular()),
              h3,
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      '3.4',
                      style: R.textStyles.poppinsSemiBold(fontSize: 20.sp),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        customLinearProgressIndecator('5', 1.0),
                        customLinearProgressIndecator('4', 0.8),
                        customLinearProgressIndecator('3', 0.6),
                        customLinearProgressIndecator('2', 0.4),
                        customLinearProgressIndecator('1', 0.2),
                      ],
                    ),
                  ),
                ],
              ),
              h2,
              customRatingIcons(3.0),
              h2,
              ...List.generate(
                context.read<SettingsVM>().reviewsList.length,
                (index) => ReviewsWidget(
                  model: context.read<SettingsVM>().reviewsList[index],
                ),
              ),
              h1,
              // Container(
              //   padding: EdgeInsets.all(7.sp),
              //   decoration: BoxDecoration(
              //       color: R.colors.grey,
              //       borderRadius: BorderRadius.circular(8)),
              //   child: Column(
              //     children: [
              //       Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         children: [
              //           Text(
              //             'John Doe',
              //             style: R.textStyles.poppinsSemiBold(),
              //           ),
              //           Text(
              //             DateFormat('dd-MM-yyyy  ').format(DateTime.now()),
              //             style: R.textStyles.poppinsRegular(),
              //           ),
              //         ],
              //       ),
              //       h1,
              //       ReadMoreText(
              //         'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS and Android apps with the unified codebase.',
              //         trimLines: 2,
              //         colorClickableText: Colors.pink,
              //         trimMode: TrimMode.Line,
              //         trimCollapsedText: 'Show more',
              //         trimExpandedText: 'Show less',
              //         moreStyle: R.textStyles.poppinsRegular(),
              //       ),
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }

  Widget customLinearProgressIndecator(String text, var valueOfRating) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.sp),
      child: Row(
        children: [
          Expanded(flex: 1, child: Text(text)),
          Expanded(
              flex: 9,
              child: SizedBox(
                width: double.infinity,
                child: LinearProgressIndicator(
                  value: valueOfRating,
                  minHeight: 11,
                  backgroundColor: R.colors.grey,
                  borderRadius: BorderRadius.circular(7),
                  valueColor: AlwaysStoppedAnimation(R.colors.primary),
                ),
              )),
        ],
      ),
    );
  }

  Widget customRatingIcons(var rating) {
    return RatingBar.builder(
      initialRating: rating,
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
    );
  }
}
