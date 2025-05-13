import 'dart:convert';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import 'package:stacked_services/stacked_services.dart';
import '../../../model/characters_response_model.dart';
import '../../../network/api_constant.dart';

class CharacterDetailViewModel extends BaseViewModel {
  Character? character;
  bool isLoading = true;
  final SnackbarService _snackBar = SnackbarService();

  /// Initializes the view model by fetching the list of characters.
  /// This method is called when the view is ready to load initial data.
  Future runStartupLogic(characterId) async {
    fetchCharacter(characterId);
  }

  /// Fetches character details from the API and updates the UI.
  /// Shows a snackbar on error.
  Future<void> fetchCharacter(characterId) async {
    setBusy(true);
    try {
      final response = await http
          .get(Uri.parse('$kApiBaseUrl/api/character/$characterId'));
      if (response.statusCode == 200) {
          character = Character.fromJson(json.decode(response.body));
      } else {
        _snackBar.showSnackbar(message: "Failed to load characters");
      }
    } catch (e) {
      _snackBar.showSnackbar(message: "An error occurred: $e");

    }
    isLoading = false;
    notifyListeners();
  }


}
