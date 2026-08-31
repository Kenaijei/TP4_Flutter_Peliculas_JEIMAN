import 'package:flutter/material.dart';

class Movie {
  final String id;
  final String title;
  final String genre;
  final int year;
  final String duration;
  final double rating;
  final String description;
  final String posterUrl;
  final String director;
  final Color accentColor;

  const Movie({
    required this.id,
    required this.title,
    required this.genre,
    required this.year,
    required this.duration,
    required this.rating,
    required this.description,
    required this.posterUrl,
    required this.director,
    required this.accentColor,
  });
}
