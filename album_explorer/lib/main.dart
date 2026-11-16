import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'album.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Album Explorer',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const AlbumPage(),
    );
  }
}

class AlbumPage extends StatefulWidget {
  const AlbumPage({super.key});

  @override
  State<AlbumPage> createState() => _AlbumPageState();
}

class _AlbumPageState extends State<AlbumPage> {
  late Future<List<Album>> albums;
  Album? selectedAlbum;

  @override
  void initState() {
    super.initState();
    albums = fetchAlbums();
  }

  Future<List<Album>> fetchAlbums() async {
    final response = await http.get(
      Uri.parse('https://jsonplaceholder.typicode.com/albums'),
    );

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load albums');
    }
  }

  Future<void> deleteAlbum() async {
    if (selectedAlbum == null) return;

    final response = await http.delete(
      Uri.parse(
        'https://jsonplaceholder.typicode.com/albums/${selectedAlbum!.id}',
      ),
    );

    if (response.statusCode == 200) {
      setState(() {
        selectedAlbum = null;
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Album deleted successfully')),
      );
    } else {
      throw Exception('Failed to delete album');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Album Explorer'),
      ),
      body: Column(
        children: [
          Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: selectedAlbum == null
                  ? const Text('No Album Selected')
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedAlbum!.title,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 8),
                        Text('Album ID: ${selectedAlbum!.id}'),
                        Text('User ID: ${selectedAlbum!.userId}'),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: deleteAlbum,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                          ),
                          child: const Text('Delete Album'),
                        ),
                      ],
                    ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Album>>(
              future: albums,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final albumList = snapshot.data!;

                return ListView.builder(
                  itemCount: albumList.length,
                  itemBuilder: (context, index) {
                    final album = albumList[index];

                    return ListTile(
                      title: Text(album.title),
                      subtitle: Text('Album ID: ${album.id}'),
                      onTap: () {
                        setState(() {
                          selectedAlbum = album;
                        });
                      },
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
