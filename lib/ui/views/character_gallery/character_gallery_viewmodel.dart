import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import 'character_detail_page.dart';

class CharacterGalleryViewModel extends BaseViewModel {
  final _navigationService = locator<NavigationService>();
  List characters = [];
  List filteredCharacters = [];
  bool isLoading = true;
  String searchQuery = "";
  final SnackbarService _snackBar = SnackbarService();
  Future runStartupLogic() async {
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    try {
      final response = await http
          .get(Uri.parse('https://rickandmortyapi.com/api/character'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        characters = data['results'];
        filteredCharacters = characters;
        isLoading = false;
        notifyListeners();
      } else {
        _snackBar.showSnackbar(message:"Failed to load characters");
      }
    } catch (e) {
      _snackBar.showSnackbar(message: "An error occurred");
    }
  }


  void filterCharacters(String query) {
    final filtered = characters.where((character) {
      return character['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();

    searchQuery = query;
    filteredCharacters = filtered;
    notifyListeners();
  }

  void navigateToCharacterDetailPage(int character) {
    _navigationService
        .navigateToView(CharacterDetailView(characterId: character));
  }
}
