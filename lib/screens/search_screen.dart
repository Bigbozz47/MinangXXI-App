import 'package:final_project/api/api.dart';
import 'package:final_project/models/movie.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final Api _api = Api();
  List<Movie> mainMoviesList = [];
  List<Movie> displayList = [];

  bool _isLoading = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    setState(() {
      _isLoading = true;
    });

    try {
      // Example: Fetch trending movies. You can change this to other endpoints if needed.
      final movies = await _api.getTrendingMovies();
      setState(() {
        mainMoviesList = movies;
        displayList = movies;
        _hasError = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
      });
      print('Error fetching movies: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateList(String query) {
    final filteredMovies = mainMoviesList
        .where((movie) =>
            movie.originalTitle.toLowerCase().contains(query.toLowerCase()))
        .toList();
    setState(() {
      displayList = filteredMovies;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Movie'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Search for Movies',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 20),
            if (_isLoading) ...[
              const Center(child: CircularProgressIndicator()),
            ] else if (_hasError) ...[
              const Center(child: Text('Failed to load movies')),
            ] else ...[
              Expanded(
                child: ListView.builder(
                  itemCount: displayList.length,
                  itemBuilder: (context, index) {
                    final movie = displayList[index];
                    return ListTile(
                      leading: movie.posterPath.isNotEmpty
                          ? Image.network(
                              'https://image.tmdb.org/t/p/w500${movie.posterPath}')
                          : null,
                      title: Text(
                        movie.originalTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        // Handle movie tap if needed
                      },
                    );
                  },
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class MovieSearchDelegate {}
