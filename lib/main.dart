import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gifthunt/firebase_options.dart';
import 'package:gifthunt/src/presentation/routing/app_router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Define a custom ColorScheme
    final ColorScheme customColorScheme = ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: const Color(0xFF6200EE), // A vibrant purple
      secondary: const Color(0xFF03DAC6), // A bright teal
      tertiary: const Color(0xFFBB86FC), // A lighter purple
      error: const Color(0xFFB00020), // Standard error red
      surface: const Color(0xFFFFFFFF), // White surface
      onPrimary: Colors.white,
      onSecondary: Colors.black,
      onTertiary: Colors.black,
      onError: Colors.white,
      onSurface: Colors.black,
    );

    return MaterialApp.router(
      title: 'GiftHunt',
      theme: ThemeData(
        colorScheme: customColorScheme,
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routerConfig: appRouter,
    );
  }
}

