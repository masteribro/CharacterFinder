import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CharacterDetailPage extends StatefulWidget {
  final int characterId;
  const CharacterDetailPage({super.key, required this.characterId});

  @override
  State<CharacterDetailPage> createState() => _CharacterDetailPageState();
}

class _CharacterDetailPageState extends State<CharacterDetailPage> {
  Map character = {};
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
          character = json.decode(response.body);
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
      appBar: AppBar(title: Text(character['name'] ?? 'Loading...')),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.network(
                      character['image'],
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("Name: ${character['name']}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Status: ${character['status']}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Species: ${character['species']}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Gender: ${character['gender']}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Origin: ${character['origin']['name']}",
                      style: const TextStyle(fontSize: 18)),
                  Text("Location: ${character['location']['name']}",
                      style: const TextStyle(fontSize: 18)),
                ],
              ),
            ),
    );
  }
}
