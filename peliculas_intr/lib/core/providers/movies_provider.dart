import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tp4_dap/entities/movie.dart';

final moviesProvider = StateNotifierProvider<MoviesNotifier, List<Movie>>(
  (ref) => MoviesNotifier(),
);

class MoviesNotifier extends StateNotifier<List<Movie>> {
  MoviesNotifier()
      : super(
          const [
            Movie(
              id: '1',
              title: 'Oppenheimer',
              genre: 'Drama historico',
              year: 2023,
              duration: '3h 0m',
              rating: 8.6,
              description:
                  'Retrata el ascenso cientifico de J. Robert Oppenheimer y el costo moral de liderar el proyecto que cambio la guerra moderna.',
              posterUrl:
                  'https://upload.wikimedia.org/wikipedia/en/4/4a/Oppenheimer_%28film%29.jpg',
              director: 'Christopher Nolan',
              accentColor: Color(0xFF374151),
            ),
            Movie(
              id: '2',
              title: 'Interstellar',
              genre: 'Ciencia ficcion',
              year: 2014,
              duration: '2h 49m',
              rating: 8.7,
              description:
                  'Un grupo de exploradores viaja mas alla del sistema solar para encontrar un nuevo hogar para la humanidad.',
              posterUrl:
                  'https://upload.wikimedia.org/wikipedia/en/b/bc/Interstellar_film_poster.jpg',
              director: 'Christopher Nolan',
              accentColor: Color(0xFF1F3B73),
            ),
            Movie(
              id: '3',
              title: 'Transformers',
              genre: 'Accion y ciencia ficcion',
              year: 2007,
              duration: '2h 24m',
              rating: 7.0,
              description:
                  'La guerra entre Autobots y Decepticons llega a la Tierra y un adolescente queda en el centro del conflicto.',
              posterUrl:
                  'https://upload.wikimedia.org/wikipedia/en/6/66/Transformers07.jpg',
              director: 'Michael Bay',
              accentColor: Color(0xFF9C2C2C),
            ),
            Movie(
              id: '4',
              title: 'Transformers: Dark Of The Moon',
              genre: 'Accion y ciencia ficcion',
              year: 2011,
              duration: '2h 34m',
              rating: 6.2,
              description:
                  'Sam Witwicky descubre una conspiracion ligada a la carrera espacial y a un antiguo secreto de Cybertron.',
              posterUrl:
                  'https://upload.wikimedia.org/wikipedia/en/b/bf/Transformers_dark_of_the_moon_ver5.jpg',
              director: 'Michael Bay',
              accentColor: Color(0xFF4A5568),
            ),
            Movie(
              id: '5',
              title: 'Avatar',
              genre: 'Ciencia ficcion y aventura',
              year: 2009,
              duration: '2h 42m',
              rating: 7.9,
              description:
                  'En Pandora, un exmarine se integra al mundo na\'vi y debe elegir entre obedecer a su mision o proteger a un planeta vivo.',
              posterUrl:
                  'https://upload.wikimedia.org/wikipedia/en/d/d6/Avatar_%282009_film%29_poster.jpg',
              director: 'James Cameron',
              accentColor: Color(0xFF2A6F97),
            ),
            Movie(
              id: '6',
              title: 'Avatar: El camino del agua',
              genre: 'Ciencia ficcion y aventura',
              year: 2022,
              duration: '3h 12m',
              rating: 7.6,
              description:
                  'La familia de Jake y Neytiri busca refugio entre los clanes del agua mientras una amenaza regresa a Pandora.',
              posterUrl:
                  'https://upload.wikimedia.org/wikipedia/en/5/54/Avatar_The_Way_of_Water_poster.jpg',
              director: 'James Cameron',
              accentColor: Color(0xFF0F6E8C),
            ),
            Movie(
              id: '7',
              title: 'Avatar: Fire and Ash',
              genre: 'Ciencia ficcion y aventura',
              year: 2025,
              duration: '3h 17m',
              rating: 7.2,
              description:
                  'La siguiente etapa de la saga de Pandora promete llevar el conflicto a nuevas regiones y expandir el mundo de los na\'vi.',
              posterUrl:
                  'https://m.media-amazon.com/images/M/MV5BZDYxY2I1OGMtN2Y4MS00ZmU1LTgyNDAtODA0MzAyYjI0N2Y2XkEyXkFqcGc@._V1_.jpg',
              director: 'James Cameron',
              accentColor: Color(0xFF7F1D1D),
            ),
            Movie(
              id: '8',
              title: 'Project Hail Mary',
              genre: 'Ciencia ficcion',
              year: 2026,
              duration: '2h 36m',
              rating: 8.2,
              description:
                  'Un profesor despierta a bordo de una nave espacial sin recordar su mision y debe descubrir como salvar a la Tierra.',
              posterUrl:
                  'https://m.media-amazon.com/images/M/MV5BNTkwNzJiYTctNzI3NC00NjE1LTlhYjktY2Q5MTdmMWFmNzcxXkEyXkFqcGc@._V1_.jpg',
              director: 'Phil Lord y Christopher Miller',
              accentColor: Color(0xFF334155),
            ),
            Movie(
              id: '9',
              title: 'Nobody',
              genre: 'Accion y thriller',
              year: 2021,
              duration: '1h 32m',
              rating: 7.4,
              description:
                  'Un hombre aparentemente comun revela un pasado violento cuando un robo domestico desata una cadena de consecuencias.',
              posterUrl:
                  'https://upload.wikimedia.org/wikipedia/en/c/c7/Nobody_2021_Film_Poster.jpeg',
              director: 'Ilya Naishuller',
              accentColor: Color(0xFFB45309),
            ),
          ],
        );

  void addMovie(Movie movie) {
    final newMovie = Movie(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: movie.title,
      genre: movie.genre,
      year: movie.year,
      duration: movie.duration,
      rating: movie.rating,
      description: movie.description,
      posterUrl: movie.posterUrl,
      director: movie.director,
      accentColor: movie.accentColor,
    );
    state = [...state, newMovie];
  }

  void updateMovie(Movie updatedMovie) {
    state = state
        .map((movie) => movie.id == updatedMovie.id ? updatedMovie : movie)
        .toList();
  }

  void deleteMovie(String id) {
    state = state.where((movie) => movie.id != id).toList();
  }
}

