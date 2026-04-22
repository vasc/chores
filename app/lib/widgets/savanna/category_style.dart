import 'package:flutter/material.dart';

class CategoryStyle {
  const CategoryStyle({required this.bg, required this.chip, required this.ink});
  final Color bg;
  final Color chip;
  final Color ink;
}

const _defaultStyle = CategoryStyle(
  bg: Color(0xFFF0E5D0),
  chip: Color(0x143C2814),
  ink: Color(0xFF5B4530),
);

const _styles = <String, CategoryStyle>{
  'Room':    CategoryStyle(bg: Color(0xFFFFE5D0), chip: Color(0x26F46A4E), ink: Color(0xFF8C3B1E)),
  'Kitchen': CategoryStyle(bg: Color(0xFFE0F0D8), chip: Color(0x262F6F4E), ink: Color(0xFF1E4A32)),
  'Pets':    CategoryStyle(bg: Color(0xFFE6DCF0), chip: Color(0x267850A0), ink: Color(0xFF4A2E6B)),
  'School':  CategoryStyle(bg: Color(0xFFD6E8EF), chip: Color(0x26467896), ink: Color(0xFF1E4A66)),
  'Self':    CategoryStyle(bg: Color(0xFFFFEDB8), chip: Color(0x33F4B942), ink: Color(0xFF8C6618)),
};

CategoryStyle categoryStyle(String? category) {
  if (category == null) return _defaultStyle;
  // Accept either display label ("Room") or the tag a chore title suggests.
  for (final entry in _styles.entries) {
    if (entry.key.toLowerCase() == category.toLowerCase()) return entry.value;
  }
  return _defaultStyle;
}

/// Guess a category from a chore title — used when the backend doesn't have
/// a category field yet. Matches the savanna design's categories.
String guessCategory(String title) {
  final t = title.toLowerCase();
  if (t.contains('bed') || t.contains('room') || t.contains('laundry') || t.contains('toy')) return 'Room';
  if (t.contains('dish') || t.contains('kitchen') || t.contains('trash') || t.contains('table')) return 'Kitchen';
  if (t.contains('dog') || t.contains('cat') || t.contains('fish') || t.contains('pet') || t.contains('feed')) return 'Pets';
  if (t.contains('read') || t.contains('homework') || t.contains('study') || t.contains('school') || t.contains('practice')) return 'School';
  if (t.contains('teeth') || t.contains('bath') || t.contains('shower') || t.contains('hair') || t.contains('brush')) return 'Self';
  return 'Room';
}

/// Picks an emoji for a chore title if none is provided by the backend.
String guessChoreEmoji(String title) {
  final t = title.toLowerCase();
  if (t.contains('bed')) return '🛏️';
  if (t.contains('laundry') || t.contains('clothes')) return '👕';
  if (t.contains('fish')) return '🐠';
  if (t.contains('dog')) return '🐕';
  if (t.contains('cat')) return '🐈';
  if (t.contains('trash') || t.contains('garbage')) return '🗑️';
  if (t.contains('dish')) return '🍽️';
  if (t.contains('teeth') || t.contains('brush')) return '🪥';
  if (t.contains('read') || t.contains('book')) return '📚';
  if (t.contains('homework') || t.contains('study')) return '✏️';
  if (t.contains('practice')) return '🎹';
  if (t.contains('bath') || t.contains('shower')) return '🛁';
  if (t.contains('water') && t.contains('plant')) return '🪴';
  return '✨';
}
