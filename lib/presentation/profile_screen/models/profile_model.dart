import '../../../core/app_export.dart';

/// This class defines the variables used in the [profile_screen],
import 'carousel_item_model.dart';
import 'frametwentythree2_item_model.dart';
import 'frametwentythree_item_model.dart';

/// and is typically used to hold data that is passed between different parts of the application.
class ProfileModel {
  Rx<List<CarouselItemModel>> wayAlbumList =
      Rx(List.generate(3, (index) => CarouselItemModel()));

  Rx<List<FrametwentythreeItemModel>> frametwentythreeItemList =
      Rx(List.generate(3, (index) => FrametwentythreeItemModel()));

  Rx<List<Frametwentythree2ItemModel>> frametwentythree2ItemList =
      Rx(List.generate(2, (index) => Frametwentythree2ItemModel()));
}
