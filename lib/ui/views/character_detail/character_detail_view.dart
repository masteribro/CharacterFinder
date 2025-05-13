import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:stacked/stacked.dart';

import '../../common/loader.dart';
import '../character_gallery/widget/character_row.dart';
import 'character_detail_viewmodel.dart';

class CharacterDetailView extends StackedView<CharacterDetailViewModel> {
  final int characterId;
  const CharacterDetailView(this.characterId, {Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    CharacterDetailViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: Text(viewModel.character?.name ?? 'Loading...'),
        centerTitle: true,
      ),
      body: viewModel.isLoading
          ? const Center(child: Loader())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          viewModel.character?.image ?? "No image",
                          height: 220,
                          width: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  CharacterRow(
                      title: "Name", value: viewModel.character?.name ?? ""),
                  CharacterRow(
                      title: "Status",
                      value: viewModel.character?.status ?? ""),
                  CharacterRow(
                      title: "Species",
                      value: viewModel.character?.species ?? ""),
                  CharacterRow(
                      title: "Gender",
                      value: viewModel.character?.gender ?? ""),
                  CharacterRow(
                      title: "Origin",
                      value: viewModel.character?.origin.name ?? ""),
                  CharacterRow(
                      title: "Location",
                      value: viewModel.character?.location.name ?? ""),
                ],
              ),
            ),
    );
  }

  @override
  CharacterDetailViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CharacterDetailViewModel();
  @override
  void onViewModelReady(CharacterDetailViewModel viewModel) =>
      SchedulerBinding.instance
          .addPostFrameCallback((timeStamp) => viewModel.runStartupLogic(characterId));
}
