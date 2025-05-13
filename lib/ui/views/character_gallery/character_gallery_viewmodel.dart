import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../model/characters_response_model.dart';
import '../../../network/api_constant.dart';
import 'character_detail_page.dart';

class CharacterGalleryViewModel extends BaseViewModel {

  /// Locates and assigns the navigation service for handling app navigation.
  final _navigationService = locator<NavigationService>();
  List<Character> characters = [];
  List<Character> filteredCharacters = [];
  Character? character;
  bool isLoading = true;
  String searchQuery = "";
  final SnackbarService _snackBar = SnackbarService();
  // Create a FocusNode to manage TextField focus
  final FocusNode searchFocusNode = FocusNode();


  /// Initializes the view model by fetching the list of characters.
  /// This method is called when the view is ready to load initial data.
  Future runStartupLogic() async {
    fetchCharacters();
  }

  /// Fetches characters from the API and updates the UI.
  /// Shows a snackbar on error.
  Future<void> fetchCharacters() async {
    try {
      final response = await http.get(Uri.parse('$kApiBaseUrl/api/character'));
      if (response.statusCode == 200) {
        final data = CharacterResponse.fromJson(json.decode(response.body));
        characters = data.results;
        filteredCharacters = characters;
        isLoading = false;
        notifyListeners();
      } else {
        _snackBar.showSnackbar(message: "Failed to load characters");
      }
    } catch (e) {
      _snackBar.showSnackbar(message: "An error occurred");
    }
  }

  /// Filters characters based on the search query.
  void filterCharacters(String query) {
    final filtered = characters.where((character) {
      return character.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    searchQuery = query;
    filteredCharacters = filtered;
    notifyListeners();
  }

  /// Navigates to the character detail screen.
  void navigateToCharacterDetailPage(int characterId) {
    _navigationService
        .navigateToView(CharacterDetailView(characterId: characterId));
    searchFocusNode.unfocus();
  }
}
