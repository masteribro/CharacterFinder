import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

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
        FocusScope.of(context).unfocus();
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
                    child: ListView.builder(
                      itemCount: viewModel.filteredCharacters.length,
                      itemBuilder: (context, index) {
                        final character = viewModel.filteredCharacters[index];
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(character.image),
                          ),
                          title: Text(character.name),
                          subtitle: Text(character.species),
                          onTap: () {
                            debugPrint(
                                "${viewModel.filteredCharacters[index]}");
                            viewModel
                                .navigateToCharacterDetailPage(character.id);
                          },
                        );
                      },
                    ),
                  ),
                ],
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
  void onViewModelReady(CharacterGalleryViewModel viewModel) =>
      SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic());
}
