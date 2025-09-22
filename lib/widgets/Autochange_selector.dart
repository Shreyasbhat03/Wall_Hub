import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AutoWallpaperDialTile extends StatelessWidget {
  final Duration currentInterval;
  final String currentCategory;
  final List<String> categories;
  final Function(Duration) onIntervalChanged;
  final Function(String) onCategoryChanged;

  const AutoWallpaperDialTile({
    super.key,
    required this.currentInterval,
    required this.currentCategory,
    required this.categories,
    required this.onIntervalChanged,
    required this.onCategoryChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: const Text("Auto Wallpaper Settings"),
      subtitle: Text("Every ${currentInterval.inHours}h | $currentCategory"),
      trailing: const Icon(Icons.settings),
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (_) => CupertinoAutoWallpaperPicker(
            initialInterval: currentInterval,
            initialCategory: currentCategory,
            categories: categories,
            onIntervalChanged: onIntervalChanged,
            onCategoryChanged: onCategoryChanged,
          ),
        );
      },
    );
  }
}
class CupertinoAutoWallpaperPicker extends StatefulWidget {
  final Duration initialInterval;
  final String initialCategory;
  final List<String> categories;
  final Function(Duration) onIntervalChanged;
  final Function(String) onCategoryChanged;

  const CupertinoAutoWallpaperPicker({
    super.key,
    required this.initialInterval,
    required this.initialCategory,
    required this.categories,
    required this.onIntervalChanged,
    required this.onCategoryChanged,
  });

  @override
  State<CupertinoAutoWallpaperPicker> createState() => _CupertinoAutoWallpaperPickerState();
}

class _CupertinoAutoWallpaperPickerState extends State<CupertinoAutoWallpaperPicker> {
  late int selectedHour;
  late int selectedCategoryIndex;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialInterval.inHours - 1;
    selectedCategoryIndex = widget.categories.indexOf(widget.initialCategory);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350,
      color: CupertinoColors.systemGrey6,
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const Text("Auto Change Interval", style: TextStyle(fontSize: 18)),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(initialItem: selectedHour),
              onSelectedItemChanged: (val) => setState(() => selectedHour = val),
              children: List.generate(24, (i) => Center(child: Text("${i + 1} hours"))),
            ),
          ),
          const SizedBox(height: 12),
          const Text("Wallpaper Category", style: TextStyle(fontSize: 18)),
          Expanded(
            child: CupertinoPicker(
              itemExtent: 40,
              scrollController: FixedExtentScrollController(initialItem: selectedCategoryIndex),
              onSelectedItemChanged: (val) => setState(() => selectedCategoryIndex = val),
              children: widget.categories.map((cat) => Center(child: Text(cat))).toList(),
            ),
          ),
          const SizedBox(height: 12),
          CupertinoButton.filled(
            child: const Text("Save"),
            onPressed: () {
              widget.onIntervalChanged(Duration(hours: selectedHour + 1));
              widget.onCategoryChanged(widget.categories[selectedCategoryIndex]);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
