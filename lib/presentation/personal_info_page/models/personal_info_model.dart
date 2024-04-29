import '../../../core/app_export.dart';
import 'available_location_model.dart';

/// This class defines the variables used in the [proflie_details_personal_info_page],
import 'your_interest_model.dart';

/// and is typically used to hold data that is passed between different parts of the application.
class PersonalInfoModel {
  Rx<List<YourInterestModel>> yourInterestList =
      Rx(List.generate(3, (index) => YourInterestModel()));

  Rx<List<AvailableLocationModel>> availableLocationList =
      Rx(List.generate(2, (index) => AvailableLocationModel()));
}
