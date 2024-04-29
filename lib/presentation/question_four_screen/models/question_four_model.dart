import '../../../core/app_export.dart';

/// This class defines the variables used in the [question_four_screen],
import 'chipview_item_model.dart';

/// and is typically used to hold data that is passed between different parts of the application.
class QuestionFourModel {
  static List palyList = [
    'Movie',
    'Gaming',
    'Nature',
    'Photography',
    'Gym & Fitness',
    'Sports',
    'Design',
    'Dancing',
    'Reading',
    'Music',
    'Writing',
    'Cooking',
    'Animals',
  ];

  static List palyListImg = [
    ImageConstant.imgPlaylist,
    ImageConstant.imgGamecontroller03,
    ImageConstant.imgSailboatoffshore,
    ImageConstant.imgCamera01,
    ImageConstant.imgDumbbell02,
    ImageConstant.imgBasketball01,
    ImageConstant.imgMaximize,
    ImageConstant.imgMdihumanfemaledance,
    ImageConstant.imgNotebook,
    ImageConstant.imgMusicnote03,
    ImageConstant.imgUser,
    ImageConstant.imgDish01,
    ImageConstant.imgTelevision,
  ];
  Rx<List<ChipviewItemModel>> chipviewItemList = Rx(List.generate(
    palyList.length,
    (index) => ChipviewItemModel()
      ..playlistImg = Rx(palyListImg[index])
      ..playlist = Rx(palyList[index])
      ..isSelected = Rx(false),
  ));
}
