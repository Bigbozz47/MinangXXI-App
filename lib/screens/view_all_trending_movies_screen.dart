import 'package:final_project/screens/details_screens.dart';
import 'package:flutter/material.dart';
import 'package:final_project/api/api.dart';
import 'package:final_project/models/movie.dart';

class ViewAllTrendingMoviesScreen extends StatefulWidget {
  const ViewAllTrendingMoviesScreen({super.key});

  @override
  State<ViewAllTrendingMoviesScreen> createState() =>
      _ViewAllTrendingMoviesScreenState();
}

class _ViewAllTrendingMoviesScreenState
    extends State<ViewAllTrendingMoviesScreen> {
  late Future<List<Movie>> trendingMovies;

  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trending Movies'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<List<Movie>>(
        future: trendingMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final movies = snapshot.data!;
            return ListView.builder(
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: movie.posterPath.isNotEmpty
                      ? Image.network(
                          'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                          width: 50,
                          fit: BoxFit.cover,
                        )
                      : const Icon(Icons.movie),
                  title: Text(movie.originalTitle),
                  subtitle: Text(movie.releaseDate),
                  onTap: () {
                    // Navigasi ke halaman detail
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreens(movie: snapshot.data![index]),
                      ),
                    );
                  },
                );
              },
            );
          } else {
            return const Center(
              child: Text('No movies found'),
            );
          }
        },
      ),
    );
  }
}
