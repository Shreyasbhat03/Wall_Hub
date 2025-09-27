import"package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:google_fonts/google_fonts.dart";
import "package:hive/hive.dart";
import "package:path_provider/path_provider.dart";
import "package:wallpaper_app/Hive_Repo/data_model.dart";
import "package:wallpaper_app/Hive_Repo/setting_service.dart";
import "package:wallpaper_app/Hive_Repo/settings_model.dart";
import "package:wallpaper_app/bloc/wallhub_bloc.dart";
import "package:wallpaper_app/cubits/favorite/fav_cubit.dart";
import "package:wallpaper_app/cubits/navBar/navbar_cubit.dart";
import "package:wallpaper_app/cubits/setting/settings_cubit.dart";
import "package:wallpaper_app/cubits/setting/settings_state.dart";
import "package:wallpaper_app/notificationService/notification.dart";

import "pages/mainPage.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final appDocumentDir = await getApplicationDocumentsDirectory();
  Hive.init(appDocumentDir.path);
  Hive.registerAdapter(ImageModelAdapter());
  await Hive.openBox<ImageModel>('FavImages');
  Hive.registerAdapter(SettingsModelAdapter());
  final settingsBox= await Hive.openBox<SettingsModel>("Settings"); // ✅
  final settingService= SettingsService(settingsBox);
  await NotificationService.initialize();
  runApp(myApp(settingsService: settingService,));
}

class myApp extends StatelessWidget {
  final SettingsService settingsService;

  myApp({super.key , required this.settingsService});

  final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xFFF8F9FA), // Clean white background

    // Color Scheme for Light Theme
    colorScheme: ColorScheme.light(
      brightness: Brightness.light,
      primary: Color(0xFF2196F3), // Blue primary
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFE3F2FD), // Light blue container
      onPrimaryContainer: Color(0xFF0D47A1),

      secondary: Color(0xFFE91E63), // Pink for likes/favorites
      onSecondary: Colors.white,
      secondaryContainer: Color(0xFFFCE4EC),
      onSecondaryContainer: Color(0xFF880E4F),

      tertiary: Color(0xFF4CAF50), // Green for success/actions
      onTertiary: Colors.white,

      surface: Color(0xFFFFFFFF), // Card/surface background
      onSurface: Color(0xFF1C1B1F),
      surfaceVariant: Color(0xFFF5F5F5), // Slightly darker surface
      onSurfaceVariant: Color(0xFF49454F),

      outline: Color(0xFF79747E), // Border colors
      outlineVariant: Color(0xFFCAC4D0),

      error: Color(0xFFBA1A1A),
      onError: Colors.white,

      background: Color(0xFFFFFBFE), // Overall background
      onBackground: Color(0xFF1C1B1F),

      // Custom colors for buttons
      inverseSurface: Color(0xFF313033), // Unselected button background
      onInverseSurface: Color(0xFFF4EFF4), // Unselected button text
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFFFFFFF),
      foregroundColor: Color(0xFF1C1B1F),
      elevation: 4,
      shadowColor: Colors.black12,
      surfaceTintColor: Color(0xFF2196F3),
      iconTheme: IconThemeData(color: Color(0xFF1C1B1F), size: 28),
    ),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.acme(
        textStyle: TextStyle(
          fontSize: 24,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      titleMedium: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 18,
          color: Color(0xFF1C1B1F),
          fontWeight: FontWeight.bold,
        ),
      ),
      titleSmall: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 12,
          color: Color(0xFF1C1B1F),
          fontWeight: FontWeight.w400,
        ),
      ),
      bodyLarge: TextStyle(
        color: Color(0xFF1C1B1F),
        fontSize: 16,
      ),
      labelSmall: TextStyle(
        color: Color(0xFF1C1B1F),
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        color: Color(0xFF1C1B1F),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF2196F3),
      unselectedItemColor: Color(0xFF49454F),
      selectedIconTheme: IconThemeData(color: Color(0xFF2196F3), size: 28),
      unselectedIconTheme: IconThemeData(color: Color(0xFF49454F), size: 24),
      selectedLabelStyle: TextStyle(
        color: Color(0xFF2196F3),
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        color: Color(0xFF49454F),
      ),
    ),

    iconTheme: IconThemeData(color: Color(0xFF1C1B1F), size: 28),


    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF2196F3),
      foregroundColor: Colors.white,
      elevation: 6,
    ),

    cardTheme: CardTheme(
      color: Colors.white38,
      shadowColor: Colors.black38,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
  );

  final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    scaffoldBackgroundColor: Color(0xFF121212), // Dark background

    // Color Scheme for Dark Theme
    colorScheme: ColorScheme.dark(
      brightness: Brightness.dark,
      primary: Color(0xFF90CAF9), // Light blue primary for dark mode
      onPrimary: Color(0xFF003258),
      primaryContainer: Color(0xFF004881),
      onPrimaryContainer: Color(0xFFD1E4FF),

      secondary: Color(0xFFF48FB1), // Light pink for likes/favorites
      onSecondary: Color(0xFF3F2844),
      secondaryContainer: Color(0xFF633B48),
      onSecondaryContainer: Color(0xFFFFD8E4),

      tertiary: Color(0xFF81C784), // Light green for success/actions
      onTertiary: Color(0xFF003909),

      surface: Color(0xFF1E1E1E), // Card/surface background
      onSurface: Color(0xFFE6E1E5),
      surfaceVariant: Color(0xFF2C2C2C), // Slightly lighter surface
      onSurfaceVariant: Color(0xFFCAC4D0),

      outline: Color(0xFF938F99), // Border colors
      outlineVariant: Color(0xFF49454F),

      error: Color(0xFFFFB4AB),
      onError: Color(0xFF690005),

      background: Color(0xFF10131C), // Overall background
      onBackground: Color(0xFFE6E1E5),

      // Custom colors for buttons
      inverseSurface: Color(0xFF424242), // Unselected button background
      onInverseSurface: Color(0xFFBDBDBD), // Unselected button text
    ),

    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Color(0xFFE6E1E5),
      elevation: 4,
      shadowColor: Colors.black45,
      surfaceTintColor: Color(0xFF90CAF9),
      iconTheme: IconThemeData(color: Color(0xFFE6E1E5), size: 28),
    ),

    textTheme: TextTheme(
      titleLarge: GoogleFonts.acme(
        textStyle: TextStyle(
          fontSize: 24,
          color: Color(0xFFE6E1E5),
          fontWeight: FontWeight.bold,
        ),
      ),
      titleMedium: GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      titleSmall:
      GoogleFonts.roboto(
        textStyle: TextStyle(
          fontSize: 12,
          color: Color(0xFFE6E1E5),
          fontWeight: FontWeight.w400,
        ),
      ),
      bodyLarge: TextStyle(
        color: Color(0xFFE6E1E5),
        fontSize: 16,
      ),
      labelLarge: TextStyle(
        color: Color(0xFFE6E1E5),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        color: Color(0xFFE6E1E5),
        fontSize: 10,
        fontWeight: FontWeight.w400,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Color(0xFF1E1E1E), // Dark background
      selectedItemColor: Color(0xFF90CAF9), // Light blue for selected
      unselectedItemColor: Color(0xFFCAC4D0), // Grey for unselected
      selectedIconTheme: IconThemeData(color: Color(0xFF90CAF9), size: 28),
      unselectedIconTheme: IconThemeData(color: Color(0xFFCAC4D0), size: 24),
      selectedLabelStyle: TextStyle(
        color: Color(0xFF90CAF9),
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: TextStyle(
        color: Color(0xFFCAC4D0),
      ),
    ),

    iconTheme: IconThemeData(color: Color(0xFFE6E1E5), size: 28),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF90CAF9),
      foregroundColor: Color(0xFF003258),
      elevation: 6,

    ),

    cardTheme: CardTheme(
      color:Colors.grey.shade900,
      shadowColor: Colors.black54,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),

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
          create: (context) => SettingsCubit(settingsService),
        )
      ],
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Flutter WallPaper app",
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: (state.isDark)
                ? ThemeMode.dark
                : ThemeMode.light,
            home: mainPage(),
          );
        },
      ),
    );
  }
}