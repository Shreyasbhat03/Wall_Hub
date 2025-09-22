import"package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";
import "package:wallpaper_app/Hive_Repo/data_model.dart";
import "package:wallpaper_app/Hive_Repo/settings_model.dart";
import "package:wallpaper_app/bloc/wallhub_bloc.dart";
import "package:wallpaper_app/cubits/favorite/fav_cubit.dart";
import "package:wallpaper_app/cubits/navBar/navbar_cubit.dart";
import "package:wallpaper_app/cubits/setting/settings_cubit.dart";
import "package:wallpaper_app/cubits/setting/settings_state.dart";

import "pages/mainPage.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ImageModelAdapter());
  await Hive.openBox<ImageModel>('FavImages');
  Hive.registerAdapter(SettingsModelAdapter());
  await Hive.openBox<SettingsModel>("Settings"); // ✅
  runApp(myApp());
}

class myApp extends StatelessWidget {
  myApp({super.key});

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey.shade600,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.acme(textStyle: TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.bold)),
      bodyLarge: TextStyle(color: Colors.blueGrey.shade800, fontSize: 20),

    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF121212),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      foregroundColor: Colors.white,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.acme(textStyle: TextStyle(
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold)),
      bodyLarge: TextStyle(color: Colors.white, fontSize: 20),
    ),
    iconTheme: const IconThemeData(color: Colors.white,
    size: 30),
  );


  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => wallhubBloc(),
        ),
        BlocProvider(
          create: (context) => NavbarCubit(),
        ),
        BlocProvider(
          create: (context) => FavCubit(),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(),
        )
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Fultter WallPaper app",
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: (state is AppThemeState && state.isDark)
                ? ThemeMode.dark
                : ThemeMode.light,
            home: mainPage(),
          );
        },
      ),
    );
  }
}

