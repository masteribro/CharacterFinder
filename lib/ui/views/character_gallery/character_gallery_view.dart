import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:stacked/stacked.dart';
import 'dart:io' show Platform, exit;
import '../../common/loader.dart';
import 'character_gallery_viewmodel.dart';

class CharacterGalleryView extends StackedView<CharacterGalleryViewModel> {
  const CharacterGalleryView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CharacterGalleryViewModel viewModel,
    Widget? child,
  ) {
    return GestureDetector(
      onTap: () {
        /// removes focus when you tap outside the text field
        viewModel.searchFocusNode.unfocus();
      },
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (bool didPop, Object? result) async {
          if (!didPop) {
            final shouldExit = await showDialog<bool>(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text("Exit App"),
                content: const Text("Are you sure you want to exit the app?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: const Text("Cancel"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("Exit"),
                  ),
                ],
              ),
            );

            if (shouldExit == true) {
              if (Platform.isAndroid) {
                SystemNavigator.pop();
              } else if (Platform.isIOS) {
                exit(0);
              }
            }
          }
          return Future.value();
        },
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text("Rick and Morty Characters"),
          ),
          body: viewModel.isLoading
              ? const Center(child: Loader())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Material(
                        elevation: 2,
                        borderRadius: BorderRadius.circular(12),
                        child: TextField(
                          focusNode: viewModel.searchFocusNode,
                          decoration: InputDecoration(
                            labelText: 'Search Characters',
                            prefixIcon: const Icon(Icons.search),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 14, horizontal: 16),
                          ),
                          onChanged: viewModel.filterCharacters,
                        ),
                      ),
                    ),
                    Expanded(
                      child: viewModel.filteredCharacters.isEmpty
                          ? const Center(
                              child: Text(
                                "No characters found.",
                                style:
                                    TextStyle(fontSize: 16, color: Colors.grey),
                              ),
                            )
                          : ListView.builder(
                              itemCount: viewModel.filteredCharacters.length,
                              itemBuilder: (context, index) {
                                final character =
                                    viewModel.filteredCharacters[index];
                                return ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(character.image),
                                  ),
                                  title: Text(character.name),
                                  subtitle: Text(character.species),
                                  onTap: () {
                                    viewModel.navigateToCharacterDetailPage(character.id);
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  @override
  CharacterGalleryViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CharacterGalleryViewModel();

  @override
  Future<void> onViewModelReady(CharacterGalleryViewModel viewModel) async {
    viewModel.runStartupLogic();
  }
}
