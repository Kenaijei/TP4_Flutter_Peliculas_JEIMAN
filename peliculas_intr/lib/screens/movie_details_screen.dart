import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tp4_dap/core/providers/movies_provider.dart';
import 'package:tp4_dap/entities/movie.dart';
import 'package:tp4_dap/screens/add_movie_dialog.dart';

class MovieDetailsScreen extends ConsumerWidget {
  final Movie movie;

  const MovieDetailsScreen({super.key, required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final movies = ref.watch(moviesProvider);
    final currentMovie = movies.firstWhere(
      (m) => m.id == movie.id,
      orElse: () => movie,
    );
    final isEditing = currentMovie.id == movie.id;

    Widget buildInfoChip(IconData icon, String text) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.14),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: Colors.white.withOpacity(0.16)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: Colors.white),
            const SizedBox(width: 6),
            Text(
              text,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF4F1EA),
      appBar: AppBar(
        title: const Text('Detalle de pelicula'),
        backgroundColor: const Color(0xFFF4F1EA),
        elevation: 0,
        foregroundColor: Colors.black87,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      currentMovie.accentColor,
                      currentMovie.accentColor.withOpacity(0.7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x24000000),
                      blurRadius: 24,
                      offset: Offset(0, 14),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(22),
                      child: SizedBox(
                        width: 92,
                        height: 132,
                        child: Image.network(
                          currentMovie.posterUrl,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.white.withOpacity(0.16),
                              child: const Icon(
                                Icons.local_movies_rounded,
                                size: 46,
                                color: Colors.white,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      currentMovie.title,
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      currentMovie.description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        height: 1.45,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        buildInfoChip(Icons.category_rounded, currentMovie.genre),
                        buildInfoChip(
                          Icons.calendar_month_rounded,
                          '${currentMovie.year}',
                        ),
                        buildInfoChip(Icons.schedule_rounded, currentMovie.duration),
                        buildInfoChip(
                          Icons.star_rounded,
                          currentMovie.rating.toStringAsFixed(1),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: Colors.black12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informacion',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _DetailRow(label: 'Director', value: currentMovie.director),
                    const SizedBox(height: 12),
                    _DetailRow(label: 'Genero', value: currentMovie.genre),
                    const SizedBox(height: 12),
                    _DetailRow(label: 'Descripcion', value: currentMovie.description),
                    const SizedBox(height: 12),
                    _DetailRow(label: 'Portada', value: currentMovie.posterUrl),
                    const SizedBox(height: 12),
                    _DetailRow(label: 'Duracion', value: currentMovie.duration),
                    const SizedBox(height: 12),
                    _DetailRow(label: 'Ano', value: '${currentMovie.year}'),
                    const SizedBox(height: 12),
                    _DetailRow(
                      label: 'Puntuacion',
                      value: currentMovie.rating.toStringAsFixed(1),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final updatedMovie = await showDialog<Movie>(
                          context: context,
                          builder: (context) => AddMovieDialog(movie: currentMovie),
                        );

                        if (updatedMovie != null) {
                          ref.read(moviesProvider.notifier).updateMovie(updatedMovie);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Película actualizada correctamente'),
                            ),
                          );
                        }
                      },
                      icon: const Icon(Icons.edit_rounded),
                      label: const Text('Editar pelicula'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.black87,
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () => context.pop(),
                      icon: const Icon(Icons.arrow_back_rounded),
                      label: const Text('Volver a la lista'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        backgroundColor: Colors.grey[800],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;

  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
