import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../../model/characters_response_model.dart';
import '../../common/loader.dart';

class CharacterDetailView extends StatefulWidget {
  final int characterId;
  const CharacterDetailView({super.key, required this.characterId});

  @override
  State<CharacterDetailView> createState() => _CharacterDetailViewState();
}

class _CharacterDetailViewState extends State<CharacterDetailView> {
  Character? character;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchCharacter();
  }

  Future<void> fetchCharacter() async {
    try {
      final response = await http.get(Uri.parse(
          'https://rickandmortyapi.com/api/character/${widget.characterId}'));
      if (response.statusCode == 200) {
        setState(() {
          character = Character.fromJson(json.decode(response.body));
          isLoading = false;
        });
      } else {
        showError('Failed to load character');
      }
    } catch (e) {
      showError('An error occurred');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(character?.name ?? 'Loading...'),
        centerTitle: true,
      ),
      body: isLoading
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
                          character?.image ?? "No image",
                          height: 220,
                          width: 220,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildDetailRow("Name", character?.name ?? ""),
                  _buildDetailRow("Status", character?.status ?? ""),
                  _buildDetailRow("Species", character?.species ?? ""),
                  _buildDetailRow("Gender", character?.gender ?? ""),
                  _buildDetailRow("Origin", character?.origin.name ?? ""),
                  _buildDetailRow("Location", character?.location.name ?? ""),
                ],
              ),
            ),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 18, color: Colors.black),
          children: [
            TextSpan(
                text: "$title: ",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }
}
