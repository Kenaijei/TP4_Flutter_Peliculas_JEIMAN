import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tp4_dap/entities/movie.dart';
import 'package:tp4_dap/screens/add_movie_dialog.dart';
import 'package:tp4_dap/core/providers/movies_provider.dart';

class HomeScreen extends ConsumerWidget {
  final String? username;

  const HomeScreen({super.key, this.username});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(moviesProvider);
    final usernameText = username ?? 'Usuario';

    void openMovie(Movie movie) {
      context.push('/movie-detail', extra: movie);
    }

    void showAddMovieDialog() {
      showDialog<Movie>(
        context: context,
        builder: (context) => const AddMovieDialog(),
      ).then((movie) {
        if (movie != null) {
          ref.read(moviesProvider.notifier).addMovie(movie);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Pelicula agregada correctamente!')),
          );
        }
      });
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EA),
      appBar: AppBar(
        title: Text('Hola, $usernameText'),
        backgroundColor: const Color(0xFFF4F1EA),
        elevation: 0,
        foregroundColor: Colors.black87,
        automaticallyImplyLeading: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Tooltip(
              message: 'Agregar pelicula',
              child: IconButton(
                onPressed: showAddMovieDialog,
                icon: const Icon(Icons.add_circle_outline),
                iconSize: 28,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Peliculas destacadas',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Toca una pelicula para ver informacion completa y sinopsis.',
                style: TextStyle(fontSize: 15, color: Colors.grey[700]),
              ),
              const SizedBox(height: 18),
              Expanded(
                child: ListView.separated(
                  itemCount: movies.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final movie = movies[index];

                    return InkWell(
                      borderRadius: BorderRadius.circular(24),
                      onTap: () => openMovie(movie),
                      child: Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: Colors.black12),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x14000000),
                              blurRadius: 20,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(18),
                              child: SizedBox(
                                width: 74,
                                height: 110,
                                child: Image.network(
                                  movie.posterUrl,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: movie.accentColor,
                                      child: const Icon(
                                        Icons.local_movies,
                                        color: Colors.white,
                                        size: 36,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    movie.title,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    '${movie.genre} - ${movie.year} - ${movie.duration}',
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontSize: 13,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    movie.description,
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      height: 1.35,
                                    ),
                                  ),
                                  const SizedBox(height: 14),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.star_rounded,
                                        color: Colors.amber[700],
                                        size: 20,
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        movie.rating.toStringAsFixed(1),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const Spacer(),
                                      IconButton(
                                        onPressed: () async {
                                          final confirmed = await showDialog<bool>(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: const Text('Eliminar pelicula'),
                                              content: Text('Eliminar ${movie.title}?'),
                                              actions: [
                                                TextButton(
                                                  onPressed: () => Navigator.of(context).pop(false),
                                                  child: const Text('Cancelar'),
                                                ),
                                                TextButton(
                                                  onPressed: () => Navigator.of(context).pop(true),
                                                  child: const Text('Eliminar'),
                                                ),
                                              ],
                                            ),
                                          );
                                          if (confirmed == true) {
                                            ref.read(moviesProvider.notifier).deleteMovie(movie.id);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              const SnackBar(content: Text('Pelicula eliminada')),
                                            );
                                          }
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.redAccent,
                                          size: 22,
                                        ),
                                        tooltip: 'Eliminar pelicula',
                                      ),
                                      const SizedBox(width: 4),
                                      const Icon(
                                        Icons.chevron_right_rounded,
                                        color: Colors.black54,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
}

