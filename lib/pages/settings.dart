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

  final categories = ["Nature", "Day Special", "Weather", "Space", "City", "Abstract"];
  final durations = ["6h", "12h", "24h", "Weekly", "Monthly"];
  final applyToOptions = ["Home Screen", "Lock Screen", "Both"];

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
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final cubit = context.read<SettingsCubit>();
          return SingleChildScrollView( // Make entire body scrollable
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  // APPEARANCE Section
                  Container(
                    padding: EdgeInsets.all(12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("APPEARANCE", style: theme.textTheme.titleMedium),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          child: SwitchListTile(
                            tileColor: theme.cardTheme.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text("Dark Mode", style: theme.textTheme.titleMedium),
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
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text("Notification", style: theme.textTheme.titleMedium),
                            value: state.isNotificationsEnabled,
                            onChanged: (val) {
                              cubit.toggleNotifications(val);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20),

                  // CONTENT Section
                  Container(
                    padding: EdgeInsets.all(12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CONTENT", style: theme.textTheme.titleMedium),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          child: SwitchListTile(
                            tileColor: theme.cardTheme.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text("Auto Wallpaper Change", style: theme.textTheme.titleMedium),
                            value: state.isAutoWallpaperEnabled,
                            onChanged: (val) {
                              cubit.toggleAutoWallpaper(val);
                            },
                          ),
                        ),

                        // Animated expansion for additional options
                      if (state.isAutoWallpaperEnabled) ...[
              const SizedBox(height: 16),

          // Category
          _buildDropdownTile(
          title: "Category",
          value: state.category,
          items: categories,
          onChanged: (val) => cubit.changeCategory(val!),
          theme: theme,
          ),

          const SizedBox(height: 12),

          // Duration
          _buildDropdownTile(
          title: "Change Every",
          value: state.duration,
          items: durations,
          onChanged: (val) => cubit.changeDuration(val!),
          theme: theme,
          ),

          const SizedBox(height: 12),

          // Apply To
          _buildDropdownTile(
          title: "Apply To",
          value: state.setAs,
          items: applyToOptions,
          onChanged: (val) => cubit.changeSetAs(val!),
          theme: theme,
          ),

          const SizedBox(height: 16),
          ],
                        Material(
                          color: Colors.transparent,
                          child: SwitchListTile(
                            tileColor: theme.cardTheme.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
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

                  SizedBox(height: 20),

                  // ABOUT Section
                  Container(
                    padding: EdgeInsets.all(12.0),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("ABOUT", style: theme.textTheme.titleMedium),
                        SizedBox(height: 10),
                        Material(
                          color: Colors.transparent,
                          child: ListTile(
                            tileColor: theme.cardTheme.color,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            title: Text("App Version", style: theme.textTheme.titleMedium),
                            subtitle: Text("version: 1.0.0", style: theme.textTheme.titleMedium),
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20), // Bottom padding
                ],
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildDropdownTile({
    required String title,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
    required ThemeData theme,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          // Show dropdown menu
          showModalBottomSheet(
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              decoration: BoxDecoration(
                color: theme.scaffoldBackgroundColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      "Select $title",
                      style: theme.textTheme.titleLarge,
                    ),
                  ),
                  ...items.map((item) => ListTile(
                    title: Text(item, style: theme.textTheme.titleMedium),
                    trailing: value == item ? Icon(Icons.check, color: theme.primaryColor) : null,
                    onTap: () {
                      onChanged(item);
                      Navigator.pop(context);
                    },
                  )),
                  SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
        child: Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: theme.cardTheme.color,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: Colors.grey[600],
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    value ?? "Select $title",
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[600],
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}