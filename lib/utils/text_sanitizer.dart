/// Cleans up text coming from the backend that may contain mangled
/// characters — typically the result of content being authored in Word/PDF
/// and copy-pasted into the CMS, where font-specific ligatures (e.g. the
/// "ti" ligature) get mis-encoded into obscure Unicode code points that
/// Poppins (the app's font) has no glyph for. Left alone, those render as
/// a "tofu" box on device — this repairs the known cases and, as a safety
/// net, drops anything else outside the character ranges the app's fonts
/// actually support, so a not-yet-seen bad character never shows a tofu
/// box again — it just silently disappears instead.
class TextSanitizer {
  TextSanitizer._();

  /// Known copy-paste ligature corruption -> the text it was meant to be.
  static const Map<String, String> _knownFixes = {
    'Ɵ': 'ti', // classic MS Word "ti" ligature mis-encoded as U+019F
    'ﬁ': 'fi',
    'ﬂ': 'fl',
    'ﬀ': 'ff',
    'ﬃ': 'ffi',
    'ﬄ': 'ffl',
  };

  static const Set<int> _safePunctuation = {
    0x2013, // – en dash
    0x2014, // — em dash
    0x2018, // ' left single quote
    0x2019, // ' right single quote
    0x201C, // " left double quote
    0x201D, // " right double quote
    0x2022, // • bullet
    0x2026, // … ellipsis
  };

  /// Returns [input] with known ligature corruption repaired and any
  /// character the app's font can't render stripped out. Null-safe.
  static String? clean(String? input) {
    if (input == null) return null;
    final buffer = StringBuffer();
    for (final rune in input.runes) {
      final char = String.fromCharCode(rune);
      final fix = _knownFixes[char];
      if (fix != null) {
        buffer.write(fix);
        continue;
      }
      if (_isSafe(rune)) buffer.write(char);
      // Anything else is dropped — a missing character reads better than
      // a tofu box.
    }
    return buffer.toString();
  }

  static bool _isSafe(int rune) {
    if (rune == 0x09 || rune == 0x0A || rune == 0x0D) return true; // tab/\n/\r
    if (rune >= 0x20 && rune <= 0x7E) return true; // basic Latin
    if (rune >= 0xA0 && rune <= 0xFF) return true; // Latin-1 Supplement
    return _safePunctuation.contains(rune);
  }
}
