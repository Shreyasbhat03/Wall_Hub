import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class SwitchTile extends StatefulWidget {
  final String title;
  final String? settingKey;
  final bool defaultValue;
  final Color textColor;
  const SwitchTile({super.key, required this.title, required this.settingKey, required this.defaultValue, required this.textColor});

  @override
  State<SwitchTile> createState() => _SwitchTileState();
}

class _SwitchTileState extends State<SwitchTile> {
   bool value=false;
  void toggel(){
    setState(() {
      value = !value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: SwitchListTile(
        tileColor: Colors.grey.shade900,
        selectedTileColor: Colors.grey.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
        ),
          title: Text(widget.title, style: GoogleFonts.acme(color: widget.textColor, fontSize: 20)),

          value: value , onChanged: (_)=> toggel()),
    );
  }
}
