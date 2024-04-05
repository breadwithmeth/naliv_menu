import 'package:flutter/material.dart';
import 'package:naliv_menu/pages/categoryPage.dart';

void main() {
  runApp(const Main());
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NALIV MENU',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.amber,
            background: Colors.white,
            onBackground: Colors.black,
            error: Colors.red,
            primary: Colors.black,
            onPrimary: Colors.white,
            onError: Colors.white,
            secondary: Colors.grey
                .shade300,
            onSecondary: Colors.black,
          ),
          useMaterial3: true,
          brightness: Brightness.light,
          pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder()
          }),
          bottomNavigationBarTheme: const BottomNavigationBarThemeData(),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            // shadowColor: Color(0x70FFFFFF),
            shadowColor: Colors.transparent,
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            elevation: 4,
            scrolledUnderElevation: 4,
            // backgroundColor: Colors.white,
            // shadowColor: Colors.grey.withOpacity(0.2),
            // foregroundColor: Colors.black
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              backgroundColor: Colors.black,
              // backgroundColor: Color(0xFFFFCA3C),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(20),
              // foregroundColor: Colors.white
            ),
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(3),
              ),
            ),
          ),
          textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.grey),
              titleSmall: TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16)),
        ),
        debugShowCheckedModeBanner: false,
      home: const CategoryPage(),
    );
  }
}