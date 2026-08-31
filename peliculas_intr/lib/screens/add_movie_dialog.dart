import 'package:flutter/material.dart';
import 'package:tp4_dap/entities/movie.dart';

class AddMovieDialog extends StatefulWidget {
  final Movie? movie;

  const AddMovieDialog({super.key, this.movie});

  @override
  State<AddMovieDialog> createState() => _AddMovieDialogState();
}

class _AddMovieDialogState extends State<AddMovieDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _genreController;
  late final TextEditingController _yearController;
  late final TextEditingController _durationController;
  late final TextEditingController _ratingController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _posterUrlController;
  late final TextEditingController _directorController;

  final List<Color> _accentColors = [
    const Color(0xFF374151),
    const Color(0xFF1F3B73),
    const Color(0xFF9C2C2C),
    const Color(0xFF4A5568),
    const Color(0xFF2A6F97),
    const Color(0xFF0F6E8C),
    const Color(0xFF7F1D1D),
    const Color(0xFF334155),
    const Color(0xFFB45309),
  ];

  late int _selectedColorIndex;

  @override
  void initState() {
    super.initState();
    final movie = widget.movie;
    _titleController = TextEditingController(text: movie?.title ?? '');
    _genreController = TextEditingController(text: movie?.genre ?? '');
    _yearController = TextEditingController(text: movie?.year.toString() ?? '');
    _durationController = TextEditingController(text: movie?.duration ?? '');
    _ratingController = TextEditingController(text: movie?.rating.toString() ?? '');
    _descriptionController = TextEditingController(text: movie?.description ?? '');
    _posterUrlController = TextEditingController(text: movie?.posterUrl ?? '');
    _directorController = TextEditingController(text: movie?.director ?? '');
    _selectedColorIndex = movie != null
        ? _accentColors.indexOf(movie.accentColor)
        : 0;
    if (_selectedColorIndex < 0 || _selectedColorIndex >= _accentColors.length) {
      _selectedColorIndex = 0;
    }
  }

  void _addMovie() {
    if (_titleController.text.isEmpty ||
        _genreController.text.isEmpty ||
        _yearController.text.isEmpty ||
        _durationController.text.isEmpty ||
        _ratingController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _posterUrlController.text.isEmpty ||
        _directorController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, completa todos los campos')),
      );
      return;
    }

    try {
      final year = int.parse(_yearController.text);
      final rating = double.parse(_ratingController.text);

      if (rating < 0 || rating > 10) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('La calificacion debe estar entre 0 y 10')),
        );
        return;
      }

      final movie = Movie(
        id: widget.movie?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        genre: _genreController.text,
        year: year,
        duration: _durationController.text,
        rating: rating,
        description: _descriptionController.text,
        posterUrl: _posterUrlController.text,
        director: _directorController.text,
        accentColor: _accentColors[_selectedColorIndex],
      );

      Navigator.of(context).pop(movie);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error: verifica que ano y calificacion sean numeros')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _genreController.dispose();
    _yearController.dispose();
    _durationController.dispose();
    _ratingController.dispose();
    _descriptionController.dispose();
    _posterUrlController.dispose();
    _directorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.movie != null;

    return Dialog(
      insetPadding: const EdgeInsets.all(16),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isEditing ? 'Editar pelicula' : 'Agregar nueva pelicula',
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Titulo',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _genreController,
                decoration: const InputDecoration(
                  labelText: 'Genero',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _yearController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Ano',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: _ratingController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: 'Rating (0-10)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _durationController,
                decoration: const InputDecoration(
                  labelText: 'Duracion (ej: 2h 30m)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _directorController,
                decoration: const InputDecoration(
                  labelText: 'Director',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _posterUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL del Poster',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Descripcion',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Color Acento:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 8,
                children: List.generate(_accentColors.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedColorIndex = index;
                      });
                    },
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _accentColors[index],
                        border: _selectedColorIndex == index
                            ? Border.all(
                                color: Colors.black,
                                width: 3,
                              )
                            : null,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancelar'),
                  ),
                  const SizedBox(width: 12),
                  ElevatedButton(
                    onPressed: _addMovie,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0F172A),
                      foregroundColor: Colors.white,
                    ),
                    child: Text(widget.movie != null ? 'Actualizar' : 'Agregar'),
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
