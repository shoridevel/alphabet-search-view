import 'dart:convert';
import 'dart:typed_data';

const double letterSize = 45;
const double letterBoxHeight = 38;

final Uint8List searchImageBytes = base64Decode('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');

final Uint8List closeImageBytes = base64Decode('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');

const List<LetterChar> letters = LetterChar.values;

enum LetterChar {
  others,
  A,
  B,
  C,
  D,
  E,
  F,
  G,
  H,
  I,
  J,
  K,
  L,
  M,
  N,
  O,
  P,
  Q,
  R,
  S,
  T,
  U,
  V,
  W,
  X,
  Y,
  Z,
}

extension LetterCharExt on LetterChar {
  String get value {
    if (name.length > 1) {
      return '#';
    }
    return name;
  }

  bool match(String text) {
    text = text[0].toUpperCase();
    if (this == LetterChar.others) {
      return !RegExp('[A-Z]').hasMatch(text);
    }
    return value == text.toUpperCase();
  }

  static LetterChar fromString(String letter) {
    final char = letter[0].toUpperCase();
    if (RegExp('[A-Z]').hasMatch(char)) {
      for (final letter in LetterChar.values) {
        if (letter.value == char) {
          return letter;
        }
      }
    }
    return LetterChar.others;
  }
}
