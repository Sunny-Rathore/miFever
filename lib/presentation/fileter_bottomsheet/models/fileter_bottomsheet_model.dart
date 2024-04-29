import '../../../core/app_export.dart';

/// This class defines the variables used in the [active_plan_bottomsheet],
import 'interestedinchipview_item_model.dart';

/// and is typically used to hold data that is passed between different parts of the application.
class ActivePlanModel {
  Rx<List<SelectionPopupModel>> dropdownItemList = Rx([
    SelectionPopupModel(
      id: 1,
      title: "Item One",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 2,
      title: "Item Two",
    ),
    SelectionPopupModel(
      id: 3,
      title: "Item Three",
    )
  ]);

  Rx<List<SelectionPopupModel>> dropdownItemList1 = Rx([
    SelectionPopupModel(
      id: 1,
      title: "Item One",
      isSelected: true,
    ),
    SelectionPopupModel(
      id: 2,
      title: "Item Two",
    ),
    SelectionPopupModel(
      id: 3,
      title: "Item Three",
    )
  ]);

  Rx<List<InterestedinchipviewItemModel>> interestedinchipviewItemList =
      Rx(List.generate(3, (index) => InterestedinchipviewItemModel()));
}
