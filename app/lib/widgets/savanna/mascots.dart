import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum MascotKind { lion, giraffe, zebra, elephant, meerkat, cheetah, tiger, rhino }

enum MascotMood { happy, neutral, sleepy }

class MascotInfo {
  const MascotInfo({required this.name, required this.species, required this.color});
  final String name;
  final String species;
  final Color color;
}

const mascotInfo = <MascotKind, MascotInfo>{
  MascotKind.lion: MascotInfo(name: 'Leo', species: 'Lion', color: Color(0xFFF4B942)),
  MascotKind.giraffe: MascotInfo(name: 'Gigi', species: 'Giraffe', color: Color(0xFFE8A72E)),
  MascotKind.zebra: MascotInfo(name: 'Ziggy', species: 'Zebra', color: Color(0xFF2A1C10)),
  MascotKind.elephant: MascotInfo(name: 'Ellie', species: 'Elephant', color: Color(0xFFA39AB8)),
  MascotKind.meerkat: MascotInfo(name: 'Miko', species: 'Meerkat', color: Color(0xFFB88A5C)),
  MascotKind.cheetah: MascotInfo(name: 'Coco', species: 'Cheetah', color: Color(0xFFE8A956)),
  MascotKind.tiger: MascotInfo(name: 'Tala', species: 'Tiger', color: Color(0xFFF08A3C)),
  MascotKind.rhino: MascotInfo(name: 'Remy', species: 'Rhino', color: Color(0xFF9FA3A8)),
};

const mascotToEmoji = <MascotKind, String>{
  MascotKind.lion: '🦁',
  MascotKind.giraffe: '🦒',
  MascotKind.zebra: '🦓',
  MascotKind.elephant: '🐘',
  MascotKind.tiger: '🐯',
  MascotKind.cheetah: '🐆',
  MascotKind.rhino: '🦏',
  // No meerkat emoji; use badger so we can still round-trip.
  MascotKind.meerkat: '🦡',
};

MascotKind? mascotFromEmoji(String emoji) {
  switch (emoji) {
    case '🦁':
      return MascotKind.lion;
    case '🦒':
      return MascotKind.giraffe;
    case '🦓':
      return MascotKind.zebra;
    case '🐘':
      return MascotKind.elephant;
    case '🐯':
    case '🐅':
      return MascotKind.tiger;
    case '🐆':
      return MascotKind.cheetah;
    case '🦏':
      return MascotKind.rhino;
    case '🦝':
    case '🦡':
      return MascotKind.meerkat;
  }
  return null;
}

class Mascot extends StatelessWidget {
  const Mascot({
    super.key,
    required this.kind,
    this.size = 80,
    this.mood = MascotMood.happy,
  });

  final MascotKind kind;
  final double size;
  final MascotMood mood;

  @override
  Widget build(BuildContext context) {
    final svg = _mascotSvg(kind, mood);
    return SvgPicture.string(svg, width: size, height: size);
  }
}

String _mascotSvg(MascotKind kind, MascotMood mood) {
  switch (kind) {
    case MascotKind.lion:
      return _lion(mood);
    case MascotKind.giraffe:
      return _giraffe(mood);
    case MascotKind.zebra:
      return _zebra(mood);
    case MascotKind.elephant:
      return _elephant(mood);
    case MascotKind.meerkat:
      return _meerkat(mood);
    case MascotKind.cheetah:
      return _cheetah(mood);
    case MascotKind.tiger:
      return _tiger(mood);
    case MascotKind.rhino:
      return _rhino(mood);
  }
}

String _eye(double r, double cx, double cy, MascotMood mood, {String color = '#2A1C10'}) {
  if (mood == MascotMood.sleepy) {
    return '<circle cx="$cx" cy="$cy" r="1.2" fill="$color"/>'
        '<rect x="${cx - 4}" y="${cy - 1}" width="8" height="1.5" fill="$color"/>';
  }
  return '<circle cx="$cx" cy="$cy" r="$r" fill="$color"/>';
}

String _lion(MascotMood mood) {
  final manePetals = List.generate(12, (i) {
    final a = (i / 12) * 2 * math.pi;
    final cx = 50 + 36 * math.cos(a);
    final cy = 52 + 36 * math.sin(a);
    return '<circle cx="${cx.toStringAsFixed(2)}" cy="${cy.toStringAsFixed(2)}" r="10" fill="#8C4A18"/>';
  }).join();
  return '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <circle cx="50" cy="52" r="38" fill="#B86A2B"/>
  $manePetals
  <circle cx="50" cy="54" r="26" fill="#F4B942"/>
  <circle cx="32" cy="38" r="6" fill="#F4B942"/>
  <circle cx="68" cy="38" r="6" fill="#F4B942"/>
  ${_eye(3, 42, 52, mood)}
  ${_eye(3, 58, 52, mood)}
  <path d="M46 60 L54 60 L50 64 Z" fill="#2A1C10"/>
  <path d="M50 64 Q46 69 42 67 M50 64 Q54 69 58 67" stroke="#2A1C10" stroke-width="1.8" fill="none" stroke-linecap="round"/>
</svg>''';
}

String _giraffe(MascotMood mood) => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <rect x="44" y="40" width="12" height="48" fill="#F4B942" rx="3"/>
  <circle cx="47" cy="55" r="3" fill="#8C4A18"/>
  <circle cx="53" cy="70" r="3" fill="#8C4A18"/>
  <circle cx="48" cy="82" r="3" fill="#8C4A18"/>
  <ellipse cx="50" cy="32" rx="18" ry="15" fill="#F4B942"/>
  <ellipse cx="34" cy="24" rx="5" ry="8" fill="#F4B942" transform="rotate(-25 34 24)"/>
  <ellipse cx="66" cy="24" rx="5" ry="8" fill="#F4B942" transform="rotate(25 66 24)"/>
  <rect x="40" y="12" width="3" height="10" fill="#8C4A18" rx="1"/>
  <circle cx="41.5" cy="11" r="3" fill="#8C4A18"/>
  <rect x="57" y="12" width="3" height="10" fill="#8C4A18" rx="1"/>
  <circle cx="58.5" cy="11" r="3" fill="#8C4A18"/>
  <circle cx="40" cy="28" r="3" fill="#8C4A18"/>
  <circle cx="60" cy="38" r="2.5" fill="#8C4A18"/>
  ${_eye(2.5, 44, 32, mood)}
  ${_eye(2.5, 56, 32, mood)}
  <ellipse cx="50" cy="40" rx="6" ry="4" fill="#E8A72E"/>
  <circle cx="48" cy="39" r="1" fill="#2A1C10"/>
  <circle cx="52" cy="39" r="1" fill="#2A1C10"/>
</svg>''';

String _zebra(MascotMood mood) => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <ellipse cx="50" cy="55" rx="30" ry="28" fill="#FFFFFF"/>
  <path d="M25 45 Q35 42 28 60" stroke="#2A1C10" stroke-width="4" fill="none" stroke-linecap="round"/>
  <path d="M72 45 Q65 42 72 60" stroke="#2A1C10" stroke-width="4" fill="none" stroke-linecap="round"/>
  <path d="M40 30 Q42 40 36 45" stroke="#2A1C10" stroke-width="3.5" fill="none" stroke-linecap="round"/>
  <path d="M60 30 Q58 40 64 45" stroke="#2A1C10" stroke-width="3.5" fill="none" stroke-linecap="round"/>
  <path d="M50 28 L52 40" stroke="#2A1C10" stroke-width="3.5" stroke-linecap="round"/>
  <path d="M30 70 L38 70" stroke="#2A1C10" stroke-width="3" stroke-linecap="round"/>
  <path d="M62 70 L70 70" stroke="#2A1C10" stroke-width="3" stroke-linecap="round"/>
  <path d="M50 22 L46 30 L50 28 L54 30 Z" fill="#2A1C10"/>
  <ellipse cx="32" cy="35" rx="4" ry="7" fill="#FFFFFF" stroke="#2A1C10" stroke-width="2"/>
  <ellipse cx="68" cy="35" rx="4" ry="7" fill="#FFFFFF" stroke="#2A1C10" stroke-width="2"/>
  ${_eye(3, 42, 54, mood)}
  ${_eye(3, 58, 54, mood)}
  <ellipse cx="50" cy="68" rx="9" ry="7" fill="#F5E6D3"/>
  <circle cx="47" cy="66" r="1.2" fill="#2A1C10"/>
  <circle cx="53" cy="66" r="1.2" fill="#2A1C10"/>
</svg>''';

String _elephant(MascotMood mood) => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <ellipse cx="22" cy="52" rx="14" ry="18" fill="#A39AB8"/>
  <ellipse cx="78" cy="52" rx="14" ry="18" fill="#A39AB8"/>
  <ellipse cx="50" cy="50" rx="26" ry="24" fill="#BEB5CB"/>
  <path d="M50 62 Q50 78 60 82 Q70 84 68 74" stroke="#BEB5CB" stroke-width="10" fill="none" stroke-linecap="round"/>
  <circle cx="68" cy="74" r="5" fill="#A39AB8"/>
  ${_eye(3, 40, 48, mood)}
  ${_eye(3, 60, 48, mood)}
  <path d="M44 62 Q42 68 43 72" stroke="#FFFFFF" stroke-width="3" fill="none" stroke-linecap="round"/>
  <path d="M56 62 Q58 68 57 72" stroke="#FFFFFF" stroke-width="3" fill="none" stroke-linecap="round"/>
</svg>''';

String _meerkat(MascotMood mood) => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <ellipse cx="50" cy="78" rx="16" ry="14" fill="#B88A5C"/>
  <circle cx="50" cy="42" r="22" fill="#C9A074"/>
  <circle cx="32" cy="30" r="5" fill="#2A1C10"/>
  <circle cx="68" cy="30" r="5" fill="#2A1C10"/>
  <ellipse cx="42" cy="44" rx="7" ry="6" fill="#2A1C10"/>
  <ellipse cx="58" cy="44" rx="7" ry="6" fill="#2A1C10"/>
  ${_eye(2.5, 42, 44, mood, color: '#FBF3E3')}
  ${_eye(2.5, 58, 44, mood, color: '#FBF3E3')}
  <ellipse cx="50" cy="54" rx="6" ry="5" fill="#E8C6A0"/>
  <path d="M48 52 L52 52 L50 55 Z" fill="#2A1C10"/>
</svg>''';

String _cheetah(MascotMood mood) {
  const spots = [
    [30, 40], [40, 32], [60, 32], [70, 40], [28, 58],
    [72, 58], [38, 70], [62, 70], [50, 36],
  ];
  final spotSvg = spots
      .map((s) => '<circle cx="${s[0]}" cy="${s[1]}" r="2.5" fill="#2A1C10"/>')
      .join();
  return '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <ellipse cx="50" cy="52" rx="30" ry="28" fill="#E8A956"/>
  $spotSvg
  <circle cx="30" cy="28" r="7" fill="#E8A956"/>
  <circle cx="70" cy="28" r="7" fill="#E8A956"/>
  <circle cx="30" cy="28" r="3.5" fill="#2A1C10"/>
  <circle cx="70" cy="28" r="3.5" fill="#2A1C10"/>
  <path d="M42 55 L40 68" stroke="#2A1C10" stroke-width="2" stroke-linecap="round"/>
  <path d="M58 55 L60 68" stroke="#2A1C10" stroke-width="2" stroke-linecap="round"/>
  ${_eye(3, 42, 52, mood)}
  ${_eye(3, 58, 52, mood)}
  <ellipse cx="50" cy="64" rx="7" ry="5" fill="#F5E6D3"/>
  <path d="M48 62 L52 62 L50 65 Z" fill="#2A1C10"/>
</svg>''';
}

String _tiger(MascotMood mood) => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <ellipse cx="50" cy="55" rx="32" ry="30" fill="#F08A3C"/>
  <ellipse cx="36" cy="64" rx="10" ry="8" fill="#FFFFFF"/>
  <ellipse cx="64" cy="64" rx="10" ry="8" fill="#FFFFFF"/>
  <path d="M26 40 Q30 48 24 54" stroke="#2A1C10" stroke-width="4" fill="none" stroke-linecap="round"/>
  <path d="M74 40 Q70 48 76 54" stroke="#2A1C10" stroke-width="4" fill="none" stroke-linecap="round"/>
  <path d="M38 30 L40 40" stroke="#2A1C10" stroke-width="3.5" stroke-linecap="round"/>
  <path d="M62 30 L60 40" stroke="#2A1C10" stroke-width="3.5" stroke-linecap="round"/>
  <path d="M50 26 L50 38" stroke="#2A1C10" stroke-width="3.5" stroke-linecap="round"/>
  <path d="M28 70 L34 72" stroke="#2A1C10" stroke-width="3" stroke-linecap="round"/>
  <path d="M72 70 L66 72" stroke="#2A1C10" stroke-width="3" stroke-linecap="round"/>
  <circle cx="30" cy="30" r="7" fill="#F08A3C"/>
  <circle cx="70" cy="30" r="7" fill="#F08A3C"/>
  <circle cx="30" cy="30" r="3.5" fill="#2A1C10"/>
  <circle cx="70" cy="30" r="3.5" fill="#2A1C10"/>
  ${_eye(3, 42, 52, mood)}
  ${_eye(3, 58, 52, mood)}
  <path d="M46 62 L54 62 L50 66 Z" fill="#2A1C10"/>
  <path d="M50 66 Q46 72 42 70 M50 66 Q54 72 58 70" stroke="#2A1C10" stroke-width="1.8" fill="none" stroke-linecap="round"/>
</svg>''';

String _rhino(MascotMood mood) => '''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
  <ellipse cx="50" cy="55" rx="32" ry="28" fill="#9FA3A8"/>
  <path d="M50 30 L44 48 L56 48 Z" fill="#D4D6D8"/>
  <path d="M50 42 L46 56 L54 56 Z" fill="#D4D6D8"/>
  <ellipse cx="30" cy="38" rx="5" ry="7" fill="#9FA3A8"/>
  <ellipse cx="70" cy="38" rx="5" ry="7" fill="#9FA3A8"/>
  ${_eye(2.5, 38, 56, mood)}
  ${_eye(2.5, 62, 56, mood)}
  <ellipse cx="42" cy="72" rx="2" ry="3" fill="#2A1C10"/>
  <ellipse cx="58" cy="72" rx="2" ry="3" fill="#2A1C10"/>
</svg>''';

