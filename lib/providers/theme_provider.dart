// TODO 6: Implementasi ThemeProvider
// 1. Install Riverpod: `flutter pub add flutter_riverpod`
// 2. Import 'package:flutter_riverpod/flutter_riverpod.dart';
// 3. Buat class ThemeNotifier extends Notifier<bool> (menyimpan state isDarkMode)
// 4. Implementasikan fungsi toggleTheme() untuk mengubah state dan menyimpannya di SharedPreferences
// 5. Buat themeProvider (NotifierProvider) untuk digunakan di UI

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_app/data/services/theme_storage.dart';

final ThemeStorageProvider = Provider<ThemeStorage>((ref) => ThemeStorage());

// tema awal yang dibaca di 'main.dart' sebelum app tampil (berjalan secara asinkron).
// nilai nya di override lewat `ProvideScope.overrides`.

final initialThemeModeProvider = Provider<ThemeMode>((ref) => ThemeMode.system);

// mode tema yang aktif, bisa terang/gelap (default mengikuti sistem)
class ThemeNotifier extends Notifier<ThemeMode>{
  @override 
  ThemeMode build() => ref.read(initialThemeModeProvider);

  // beralih ke kebalikan dari  tema yang sedang tampil/aktif
  void toggle(Brightness currentBrightness) {
    state = currentBrightness == Brightness.dark ? ThemeMode.light : ThemeMode.dark;
    ref.read(ThemeStorageProvider).save(state);
  }
}

// TODO = deklarasikan sebuah notifier untuk memberitahukan perubahan yang terjadi, 
//agar aplikasi dapat mengetahui bahwa ada perubahan yang akan terjadi pada theme.
final themeModeProvider = NotifierProvider<ThemeNotifier, ThemeMode>(
  ThemeNotifier.new,
);

