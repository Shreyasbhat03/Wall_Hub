import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/widgets/switchListtile.dart';

class settingsPage extends StatefulWidget {
  const settingsPage({super.key});

  @override
  State<settingsPage> createState() => _settingsPageState();
}

class _settingsPageState extends State<settingsPage> {
  bool isDarkMode = false;
  bool isNotificationsOn = true;
  bool isAutoRotateOn = false;
  Duration interval = Duration(hours: 6);
  String category = "Nature";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings", style: GoogleFonts.acme(color: Colors.white, fontSize: 25)),
        backgroundColor: Colors.black,
        elevation: 15,
      ),
      backgroundColor: Colors.black,
      body:Center(
        child: Column(
          children:[
            Container(
              padding: EdgeInsets.all(12.0),
              height: 190,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("APPEARENCE", style: GoogleFonts.roboto(color: Colors.grey, fontSize: 18)),
                            Material(
                              color: Colors.transparent,
                              child: SwitchListTile(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
                                ),
                               tileColor: Colors.grey.shade900,
                                selectedTileColor: Colors.grey.shade900,
                                title: Text("Dark Mode", style: GoogleFonts.acme(color: Colors.white, fontSize: 18)),
                                value: isDarkMode,
                                onChanged: (val) {
                                  setState(() {
                                    isDarkMode = val;
                                  });
                                  print("Dark Mode toggled: $val");
                                  isDarkMode ? print("Dark Mode enabled"):print("Light Mode enabled");
                                },
                              ),
                            ),
                    SizedBox(height: 10),
                     SwitchTile(title: "Notification", settingKey: '', defaultValue: false, textColor: Colors.white),

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
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("CONTENT", style: GoogleFonts.roboto(color: Colors.grey, fontSize: 18)),
                    Material(
                      color: Colors.transparent,
                      child: SwitchListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
                        ),
                        tileColor: Colors.grey.shade900,
                        selectedTileColor: Colors.grey.shade900,
                        title: Text("Auto Wallpaper Change", style: GoogleFonts.acme(color: Colors.white, fontSize: 18)),
                        value: isAutoRotateOn,
                        onChanged: (val) {
                          setState(() {
                            isAutoRotateOn = val;
                          });
                          print("Dark Mode toggled: $val");
                        },
                      ),
                    ),
                    SizedBox(height: 10),
                    SwitchTile(title: "Clear Cache", settingKey: '', defaultValue: false, textColor: Colors.white),

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
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("ABOUT", style: GoogleFonts.roboto(color: Colors.grey, fontSize: 18)),
                  SizedBox(height: 10),
                  Material(
                    color: Colors.transparent,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
                      ),
                      selectedTileColor: Colors.grey.shade900,
                          tileColor: Colors.grey.shade900,
                          title: Text("App Version", style: TextStyle(color: Colors.white, fontSize: 18)),
                          subtitle: Text("version: 1.0.0", style: TextStyle(color: Colors.white70)),
                        ),
                  ),
                  ],
                ),
              ),
            )

          ]
        ),
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
