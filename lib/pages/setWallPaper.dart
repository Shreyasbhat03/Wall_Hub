import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_handler/wallpaper_handler.dart';



class setWallpaperPage extends StatefulWidget {
  final String url;
  const setWallpaperPage({super.key, required this.url});

  @override
  State<setWallpaperPage> createState() => _setWallpaperPageState();
}

class _setWallpaperPageState extends State<setWallpaperPage> {
  void _showSetWallpaperDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.95),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildDialogOption(context, 'Both', WallpaperLocation.bothScreens),
                _divider(),
                _buildDialogOption(context, 'Lock Screen', WallpaperLocation.lockScreen ),
                _divider(),
                _buildDialogOption(context, 'Home Screen', WallpaperLocation.homeScreen  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDialogOption(BuildContext context, String title, final option) {
    return InkWell(
      onTap: () {
        Navigator.pop(context); // Close the dialog
        _setWallpaper(context, option,title); // Handle action
      },
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14.0),
        child: Center(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ),
      ),
    );
  }

  Widget _divider() {
    return Divider(height: 1, color: Colors.grey.withOpacity(0.4));
  }

  // Simulated wallpaper setter
 Future<void>_setWallpaper(BuildContext context, final option,String title) async {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Wallpaper set as $title'),
        duration: Duration(seconds: 2),
      ),
    );
    var location= option;
    var file= await DefaultCacheManager().getSingleFile(widget.url);
    await WallpaperHandler.instance.setWallpaperFromFile(file.path, location);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          children:[
            Expanded(child: Container(
              child: CachedNetworkImage(
                imageUrl: widget.url,
                fit: BoxFit.cover,
                placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) => Icon(Icons.error),
                width: double.infinity,
                height: double.infinity,
              ),
            )),
            Container(
              height: 40,
              width: double.infinity,
              color: theme.appBarTheme.backgroundColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: (){
                      _showSetWallpaperDialog(context);
                    }, child: Text("Set as",style: theme.textTheme.titleLarge,),
                  ),
                  Spacer(),
                  IconButton(
                    icon: Icon(Icons.download_outlined,color: theme.appBarTheme.iconTheme?.color,),
                    onPressed: (){},
                  ),
                ],
              ),
              
            )
          ],
        ),
      ),
    );
  }
}
