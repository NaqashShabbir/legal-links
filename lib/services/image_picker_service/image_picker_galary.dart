import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:legal_links_app/resources/resources.dart';
import 'image_picker_services.dart';

class ImagePickerGalary extends StatefulWidget {
  final ValueChanged<File?>? uploadImage;
  final VoidCallback? removeImageFn;
  final bool? isOptionEnable;
  final bool? isPhotoPicked;
  const ImagePickerGalary({
    this.uploadImage,
    this.isPhotoPicked,
    this.removeImageFn,
    Key? key,
    this.isOptionEnable = false,
  }) : super(key: key);

  @override
  ImagePickerGalaryState createState() => ImagePickerGalaryState();
}

class ImagePickerGalaryState extends State<ImagePickerGalary> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: EdgeInsets.only(
                    bottom: Get.height * .05,
                    left: Get.width * .08,
                    right: Get.width * .08),
                padding: EdgeInsets.only(
                    bottom: Get.height * .05,
                    top: Get.height * .02,
                    left: Get.width * .08,
                    right: Get.width * .08),
                width: Get.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        ImagePickerServices.getProfileImage(
                                isSizeOptional: widget.isOptionEnable,
                                isCamera: false,
                                context: context)
                            .then((value) async {
                          if (ImagePickerServices.profileImage != null) {
                            widget
                                .uploadImage!(ImagePickerServices.profileImage);
                          }
                        }).whenComplete(
                                () => ImagePickerServices.profileImage = null);
                        setState(() {});

                        Navigator.pop(context);
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.image,
                            size: 20,
                          ),
                          SizedBox(
                            width: Get.width * .03,
                          ),
                          Text("Gallery",
                              style: R.textStyles.poppinsMedium(
                                  fontWeight: FontWeight.normal)),
                        ],
                      ),
                    ),
                    const Divider(color: Colors.grey),
                    if (widget.isPhotoPicked ?? false)
                      const Divider(color: Colors.grey),
                    if (widget.isPhotoPicked ?? false)
                      InkWell(
                        onTap: widget.removeImageFn,
                        child: Row(children: [
                          const Icon(Icons.delete, size: 20, color: Colors.red),
                          SizedBox(width: Get.width * .03),
                          Text("Remove Photo",
                              style: R.textStyles.poppinsMedium(
                                  fontWeight: FontWeight.normal,
                                  color: Colors.red))
                        ]),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
