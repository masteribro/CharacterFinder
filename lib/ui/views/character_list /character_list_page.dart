import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'character_detail_page.dart';

class CharacterListPage extends StatefulWidget {
  const CharacterListPage({super.key});

  @override
  State<CharacterListPage> createState() => _CharacterListPageState();
}

class _CharacterListPageState extends State<CharacterListPage> {
  List characters = [];
  List filteredCharacters = [];
  bool isLoading = true;
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchCharacters();
  }

  Future<void> fetchCharacters() async {
    try {
      final response = await http
          .get(Uri.parse('https://rickandmortyapi.com/api/character'));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          characters = data['results'];
          filteredCharacters = characters;
          isLoading = false;
        });
      } else {
        showError('Failed to load characters');
      }
    } catch (e) {
      showError('An error occurred');
    }
  }

  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void filterCharacters(String query) {
    final filtered = characters.where((character) {
      return character['name'].toLowerCase().contains(query.toLowerCase());
    }).toList();
    setState(() {
      searchQuery = query;
      filteredCharacters = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Rick and Morty Characters")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Search Characters',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: filterCharacters,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCharacters.length,
              itemBuilder: (context, index) {
                final character = filteredCharacters[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(character['image']),
                  ),
                  title: Text(character['name']),
                  subtitle: Text(character['species']),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CharacterDetailPage(
                            characterId: character['id']),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
