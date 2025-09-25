import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/cubits/setting/settings_cubit.dart';
import 'package:wallpaper_app/cubits/setting/settings_state.dart';
import 'package:wallpaper_app/widgets/switchListtile.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
bool isDarkMode = false;
  bool isNotificationsOn = false;
  bool isAutoRotateOn = false;
  Duration interval = Duration(hours: 6);
  String category = "Nature";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: theme.appBarTheme.titleTextStyle),
        backgroundColor: theme.appBarTheme.backgroundColor,
        elevation: 15,
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body:BlocBuilder<SettingsCubit, SettingsState>(
  builder: (context, state) {
    final cubit = context.read<SettingsCubit>();
    return Center(
        child: Column(
          children:[
            Container(
              padding: EdgeInsets.all(12.0),
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("APPEARENCE", style: theme.textTheme.titleMedium),
                            Material(
                              color: Colors.transparent,
                              child: SwitchListTile(
                                tileColor: theme.cardTheme.color,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
                                ),
                                title: Text("Dark Mode" ,style: theme.textTheme.titleMedium,),
                                value: state.isDark,
                                onChanged: (val) {
                                  cubit.toggleTheme(val);
                                },
                              ),

                            ),
                    SizedBox(height: 10),

                    Material(
                      color: Colors.transparent,
                      child: SwitchListTile(
                        tileColor: theme.cardTheme.color,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
                        ),
                        title: Text("Notification" ,style: theme.textTheme.titleMedium,),
                        value: state.isNotificationsEnabled,
                        onChanged: (val) {
                          cubit.toggleNotifications(val);
                        },
                      ),

                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12.0),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color:theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("CONTENT", style: theme.textTheme.titleMedium),
                        Material(
                        color: Colors.transparent,
                        child: SwitchListTile(
                        tileColor: theme.cardTheme.color,
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
                        ),
                        title: Text("Auto Wallpaper Change", style: theme.textTheme.titleMedium),
                        value: state.isAutoWallpaperEnabled,
                        onChanged: (val) {
                          cubit.toggleAutoWallpaper(val);
                        },
                      ),
                    ),
                    SizedBox(height: 10),

                          Material(
                          color: Colors.transparent,
                          child: SwitchListTile(
                          tileColor: theme.cardTheme.color,
                          shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
                          ),
                        title: Text("Clear Cache", style: theme.textTheme.titleMedium),
                        value: state.isClearCache,
                        onChanged: (val) {
                          cubit.clearCache(val);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12.0),
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ABOUT", style: theme.textTheme.titleMedium),
                  SizedBox(height: 10),
    Material(
    color: Colors.transparent,
    child: ListTile(
    tileColor: theme.cardTheme.color,
    shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
    ),
                          title: Text("App Version", style:theme.textTheme.titleMedium),
                          subtitle: Text("version: 1.0.0", style: theme.textTheme.titleMedium),
                        ),
                  ),
                  ],
                ),
              ),
            )

          ]
        ),
      );
  },
)

      // ListView(
      //   children: [
      //     SwitchListTile(
      //       title: Text("Dark Mode", style: GoogleFonts.acme(color: Colors.white, fontSize: 18)),
      //       value: isDarkMode,
      //       onChanged: (val) {
      //         setState(() {
      //           isDarkMode = val;
      //         });
      //         print("Dark Mode toggled: $val");
      //       },
      //     ),
      //     SwitchListTile(
      //       title: Text("Notifications", style: GoogleFonts.acme(color: Colors.white, fontSize: 18)),
      //       value: isNotificationsOn,
      //       onChanged: (val) {
      //         setState(() {
      //           isNotificationsOn = val;
      //         });
      //         print("Notifications toggled: $val");
      //       },
      //     ),
      //     SwitchListTile(
      //       title: Text("Auto Wallpaper Rotate", style: GoogleFonts.acme(color: Colors.white, fontSize: 18)),
      //       value: isAutoRotateOn,
      //       onChanged: (val) {
      //         setState(() {
      //           isAutoRotateOn = val;
      //         });
      //         print("Auto Wallpaper Rotate toggled: $val");
      //       },
      //     ),
      //     ListTile(
      //       title: Text("Refresh Content", style: GoogleFonts.acme(color: Colors.white, fontSize: 18)),
      //       trailing: const Icon(Icons.refresh),
      //       onTap: () => print("Refresh Content tapped"),
      //     ),
      //     const ListTile(
      //       title: Text("App Version", style: TextStyle(color: Colors.white, fontSize: 18)),
      //       subtitle: Text("version: 1.0.0", style: TextStyle(color: Colors.white70)),
      //     ),
      //   ],
      // ),
    );
  }
}
