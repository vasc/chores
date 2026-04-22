import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

String _hex(Color c) {
  final v = c.toARGB32();
  return '#${(v & 0xFFFFFF).toRadixString(16).padLeft(6, '0').toUpperCase()}';
}

class SavannaIcons {
  const SavannaIcons._();

  static Widget coin({double size = 18, Color fill = const Color(0xFFF4B942)}) {
    final f = _hex(fill);
    return SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <circle cx="12" cy="12" r="10" fill="$f"/>
  <circle cx="12" cy="12" r="7" fill="none" stroke="#8C4A18" stroke-width="1.5" opacity="0.4"/>
  <text x="12" y="16" text-anchor="middle" font-size="10" font-weight="800" fill="#8C4A18">T</text>
</svg>''', width: size, height: size);
  }

  static Widget flame({double size = 18}) => SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <path d="M12 2 C14 6 18 8 18 14 A6 6 0 0 1 6 14 C6 11 7 9 9 8 C9 10 10 11 11 11 C11 8 11 5 12 2 Z" fill="#F46A4E"/>
  <path d="M12 8 C13 10 15 11 15 14 A3 3 0 0 1 9 14 C9 12 10 11 11 11 Z" fill="#F4B942"/>
</svg>''', width: size, height: size);

  static Widget star({double size = 18, Color fill = const Color(0xFFF4B942)}) {
    final f = _hex(fill);
    return SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <path d="M12 2 L14.5 9 L22 9.5 L16 14 L18 21.5 L12 17 L6 21.5 L8 14 L2 9.5 L9.5 9 Z" fill="$f"/>
</svg>''', width: size, height: size);
  }

  static Widget check({double size = 18, Color color = Colors.white}) {
    final c = _hex(color);
    return SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M5 12 L10 17 L19 7" stroke="$c" stroke-width="3" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''', width: size, height: size);
  }

  static Widget home({double size = 24, Color color = const Color(0xFF2A1C10)}) {
    final c = _hex(color);
    return SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M3 11 L12 3 L21 11 V20 A1 1 0 0 1 20 21 H15 V14 H9 V21 H4 A1 1 0 0 1 3 20 Z" fill="$c"/>
</svg>''', width: size, height: size);
  }

  static Widget gift({double size = 24, Color color = const Color(0xFF2A1C10)}) {
    final c = _hex(color);
    return SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <rect x="3" y="9" width="18" height="12" rx="2" fill="$c"/>
  <rect x="2" y="6" width="20" height="5" rx="1" fill="$c"/>
  <rect x="11" y="6" width="2" height="15" fill="#FBF3E3"/>
  <path d="M8 6 C8 3 11 3 12 6 C13 3 16 3 16 6" stroke="$c" stroke-width="2" fill="none"/>
</svg>''', width: size, height: size);
  }

  static Widget heart({double size = 24, Color color = const Color(0xFF2A1C10)}) {
    final c = _hex(color);
    return SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <path d="M12 20 C12 20 3 14 3 8.5 A4.5 4.5 0 0 1 12 6 A4.5 4.5 0 0 1 21 8.5 C21 14 12 20 12 20 Z" fill="$c"/>
</svg>''', width: size, height: size);
  }

  static Widget quest({double size = 24, Color color = const Color(0xFF2A1C10)}) {
    final c = _hex(color);
    return SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <path d="M4 4 H14 L20 10 V20 A1 1 0 0 1 19 21 H4 A1 1 0 0 1 3 20 V5 A1 1 0 0 1 4 4 Z" fill="$c"/>
  <path d="M8 11 L11 14 L16 9" stroke="#FBF3E3" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" fill="none"/>
</svg>''', width: size, height: size);
  }

  static Widget lock({double size = 24, Color color = const Color(0xFF2A1C10)}) {
    final c = _hex(color);
    return SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none">
  <rect x="5" y="11" width="14" height="10" rx="2" fill="$c"/>
  <path d="M8 11 V7 A4 4 0 0 1 16 7 V11" stroke="$c" stroke-width="2.5" fill="none" stroke-linecap="round"/>
</svg>''', width: size, height: size);
  }

  static Widget chevron({double size = 14, Color color = const Color(0xFF2A1C10)}) {
    final c = _hex(color);
    return SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 14 14" fill="none">
  <path d="M5 3 L9 7 L5 11" stroke="$c" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
</svg>''', width: size, height: size);
  }

  static Widget sparkle({double size = 16, Color color = const Color(0xFFF4B942)}) {
    final c = _hex(color);
    return SvgPicture.string('''
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
  <path d="M12 2 L13.5 10.5 L22 12 L13.5 13.5 L12 22 L10.5 13.5 L2 12 L10.5 10.5 Z" fill="$c"/>
</svg>''', width: size, height: size);
  }
}
