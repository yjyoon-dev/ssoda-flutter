import 'package:flash/flash.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hashchecker/api.dart';
import 'package:hashchecker/constants.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hashchecker/models/reward_category.dart';
import 'package:hashchecker/models/reward.dart';
import 'dart:io';

import 'components/input_help.dart';
import 'components/name_input.dart';
import 'components/price_and_count_input.dart';

class RewardEditScreen extends StatefulWidget {
  final Reward? reward;
  final int level;
  final int? prevCount;
  const RewardEditScreen(
      {Key? key,
      required this.reward,
      required this.level,
      required this.prevCount})
      : super(key: key);

  @override
  _RewardEditScreenState createState() => _RewardEditScreenState();
}

class _RewardEditScreenState extends State<RewardEditScreen> {
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _countController;
  String? _rewardImage;
  RewardCategory? _choosedCategory;

  Future _getImageFromGallery() async {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    File? croppedFile;
    if (image != null) {
      croppedFile = await _cropImage(image.path);
    }
    if (croppedFile != null) {
      setState(() {
        _rewardImage = '$kNewImagePrefix${croppedFile!.path}';
      });
    }
  }

  Future<File?> _cropImage(String imagePath) async {
    File? croppedFile = await ImageCropper.cropImage(
        maxHeight: 800,
        maxWidth: 800,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 75,
        sourcePath: imagePath,
        aspectRatioPresets: [CropAspectRatioPreset.square],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: '사진 편집',
            toolbarColor: kScaffoldBackgroundColor,
            toolbarWidgetColor: kDefaultFontColor,
            activeControlsWidgetColor: kThemeColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: true),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
          title: '사진 편집',
          doneButtonTitle: '완료',
          cancelButtonTitle: '취소',
          aspectRatioLockEnabled: true,
        ));
    return croppedFile;
  }

  @override
  void initState() {
    super.initState();
    if (widget.reward != null) {
      setState(() {
        _nameController = TextEditingController(text: widget.reward!.name);
        _priceController =
            TextEditingController(text: widget.reward!.price.toString());
        _countController =
            TextEditingController(text: widget.reward!.count.toString());
        _rewardImage = widget.reward!.imgPath;

        _choosedCategory = widget.reward!.category;
      });
    } else {
      _nameController = TextEditingController();
      _priceController = TextEditingController();
      _countController = TextEditingController();
      _choosedCategory = RewardCategory.DRINK;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _countController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _rewardImage == null
                        ? buildImageUploadButton()
                        : buildRewardImage(),
                    SizedBox(height: kDefaultPadding * 2),
                    buildCategorySelection(context),
                    SizedBox(height: kDefaultPadding / 3 * 2),
                    NameInput(nameController: _nameController),
                    SizedBox(height: kDefaultPadding / 3 * 4),
                    PriceAndCountInput(
                        priceController: _priceController,
                        countController: _countController),
                    SizedBox(height: kDefaultPadding),
                    InputHelp(),
                    SizedBox(height: kDefaultPadding),
                  ],
                ),
              ),
            ),
            buildAddRewardButton(context)
          ],
        ),
      ),
    );
  }

  SizedBox buildAddRewardButton(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: ElevatedButton(
        child: Text(
          widget.reward == null ? '상품 등록하기' : '상품 수정하기',
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          if (isValidReward()) {
            print(_rewardImage);
            Navigator.pop(
                context,
                Reward(
                    id: widget.reward == null ? null : widget.reward!.id,
                    name: _nameController.value.text.trim(),
                    imgPath: _rewardImage!,
                    price: int.parse(_priceController.value.text.trim()),
                    count: int.parse(_countController.value.text.trim()),
                    level: widget.level,
                    category: _choosedCategory!));
          }
        },
        style: ButtonStyle(
            shadowColor: MaterialStateProperty.all<Color>(kShadowColor),
            backgroundColor: MaterialStateProperty.all<Color>(kThemeColor),
            shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(27.0)))),
      ),
    );
  }

  SizedBox buildCategorySelection(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          categoryTileList.length,
          (index) => GestureDetector(
            child: Container(
              width: 80,
              height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    categoryTileList[index].icon,
                    color: categoryTileList[index].category == _choosedCategory
                        ? Colors.white
                        : kDefaultFontColor,
                  ),
                  SizedBox(height: 8),
                  Text(
                    categoryTileList[index].name,
                    style: TextStyle(
                      color:
                          categoryTileList[index].category == _choosedCategory
                              ? Colors.white
                              : kDefaultFontColor,
                    ),
                  )
                ],
              ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: categoryTileList[index].category == _choosedCategory
                    ? kThemeColor
                    : Colors.transparent,
              ),
            ),
            onTap: () {
              setState(() {
                _choosedCategory = categoryTileList[index].category;
              });
            },
          ),
        ),
      ),
    );
  }

  GestureDetector buildRewardImage() {
    return GestureDetector(
        onTap: _getImageFromGallery,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: _rewardImage!.startsWith(kNewImagePrefix)
                ? Image.file(
                    File(_rewardImage!.substring(kNewImagePrefix.length)),
                    fit: BoxFit.cover,
                    width: 150,
                    height: 150,
                  )
                : Image.network('$s3Url$_rewardImage',
                    fit: BoxFit.cover, width: 150, height: 150)));
  }

  SizedBox buildImageUploadButton() {
    return SizedBox(
        height: 150,
        width: 150,
        child: ElevatedButton(
          onPressed: _getImageFromGallery,
          child: Stack(children: [
            Center(
              child: Icon(
                Icons.add,
                color: kLiteFontColor,
                size: 50,
              ),
            ),
            Positioned(
                bottom: 10,
                left: 0,
                right: 0,
                child: Text('상품 이미지 등록하기',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: kLiteFontColor, fontSize: 10)))
          ]),
          style: ButtonStyle(
              side: MaterialStateProperty.all<BorderSide>(
                  BorderSide(color: kLiteFontColor)),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              backgroundColor:
                  MaterialStateProperty.all<Color>(kScaffoldBackgroundColor),
              overlayColor: MaterialStateProperty.all<Color>(kShadowColor),
              elevation: MaterialStateProperty.all<double>(0)),
        ));
  }

  void _showValidationErrorFlashBar(BuildContext context, String message) {
    context.showFlashBar(
        barType: FlashBarType.error,
        icon: const Icon(Icons.error_outline_rounded),
        duration: const Duration(seconds: 3),
        backgroundColor: Colors.white,
        content: Text(message,
            style: TextStyle(fontSize: 14, color: kDefaultFontColor)));
  }

  bool isValidReward() {
    if (_rewardImage == null)
      _showValidationErrorFlashBar(context, '상품 이미지를 등록해주세요!');
    else if (_nameController.value.text.trim() == "")
      _showValidationErrorFlashBar(context, '상품명을 입력해주세요!');
    else if (_priceController.value.text.trim() == "")
      _showValidationErrorFlashBar(context, '상품 가격을 입력해주세요!');
    else if (_countController.value.text.trim() == "" ||
        int.parse(_countController.value.text.trim()) == 0)
      _showValidationErrorFlashBar(context, '상품 수량을 입력해주세요!');
    else if (widget.prevCount != null &&
        int.parse(_countController.value.text.trim()) >= widget.prevCount!)
      _showValidationErrorFlashBar(context, '전 단계 상품보다 더 작은 수량으로 입력해주세요!');
    else
      return true;
    return false;
  }

  AppBar buildAppBar() {
    return AppBar(
        elevation: 0,
        backgroundColor: kScaffoldBackgroundColor,
        iconTheme: IconThemeData(color: kDefaultFontColor),
        title: Text(
          '상품 상세정보 등록',
          style:
              TextStyle(color: kDefaultFontColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true);
  }
}
