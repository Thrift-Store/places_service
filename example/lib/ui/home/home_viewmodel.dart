import 'package:places_example/app/app.locator.dart';
import 'package:places_service/places_service.dart';
import 'package:stacked/stacked.dart';

import 'home_view.form.dart';

class HomeViewModel extends FormViewModel {
  final _placesService = locator<PlacesService>();

  List<PlacesAutoCompleteResult> _autoCompleteResults = [];

  List<PlacesAutoCompleteResult> get autoCompleteResults =>
      _autoCompleteResults;

  bool get hasAutoCompleteResults => _autoCompleteResults.isNotEmpty;

  void initialise() {
    _placesService.initialize(
      apiKey: 'AIzaSyAEmr2Nut0QSVtTbO2SHQKcLSDpM4rlM_8',
    );
  }

  @override
  void setFormStatus() {
    // Fire and forget since debounce will take care of the cancelling
    _getAutoCompleteResults();
  }

  Future<void> _getAutoCompleteResults() async {
    if (addressValue != null) {
      if (addressValue == '') {
        _autoCompleteResults = [];
      } else {
        List<PlacesAutoCompleteResult> placesResults =
            await runBusyFuture(_placesService.getAutoComplete(addressValue!));
        _autoCompleteResults = placesResults;
      }

      notifyListeners();
    }
  }
}
