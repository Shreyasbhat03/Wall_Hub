import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wallpaper_app/cubits/favorite/fav_cubit.dart';
import 'package:wallpaper_app/pages/setWallPaper.dart';
class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  final ScrollController _scrollController = ScrollController();
void initState() {
    super.initState();
    BlocProvider.of<FavCubit>(context).loadImages();
  }
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Favorites",style: GoogleFonts.acme(color: Colors.white,fontSize:30,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.black,
        elevation:15,
        actions: [
          IconButton(
            icon: Icon(Icons.delete, color: Colors.white),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Delete All"),
                    content: Text("Are you sure you want to delete all favorites?"),
                    actions: [
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      TextButton(
                        child: Text("Delete"),
                        onPressed: () {
                          BlocProvider.of<FavCubit>(context).removeAll();
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: true,
          thickness: 4, // Default is 6. Make it smaller like 2-4
          radius: Radius.circular(10),
          child: BlocBuilder<FavCubit, FavState>(
  builder: (context, state) {
    if(state is FavLoading){
      return Center(child: CircularProgressIndicator());
    }
    else if(state is FavLoaded){
      final images = state.images;
      if(images.isEmpty){
        return Center(child: Text("No favorites yet",style: TextStyle(color: Colors.white,fontSize: 20),));
      }
      return ListView.builder(
        itemCount: images.length, // Replace with your actual data length
        itemBuilder: (context,index){
          final image = images[index];
          return Stack(
            children: [
              Card(
                elevation: 5,
                shadowColor: Colors.black,

                margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.grey[900],
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context)=>setWallpaperPage(url: image.imageUrlLarge,),
                          ));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl:image.imageUrlMedium, // Replace with your image URL
                            height: 140,
                            width: 120,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) => Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if(image.photoName.isNotEmpty)
                              Text(image.photoName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                            if(image.photoName.isEmpty)
                              Text("Pexel Image",  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
                            SizedBox(height: 5),
                            Text("Photographer: ${image.photographer}", style: TextStyle(fontSize: 10,color: Colors.grey[600])),
                            SizedBox(height: 2),
                            Text("Date: ${image.dateTime.toLocal().toString().split(' ')[0]}", style: TextStyle(fontSize: 10,color: Colors.grey[600])),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.pink), // or Icons.favorite_border
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('You have liked this image'),
                              duration: Duration(seconds: 2),
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          // Toggle favorite
                        },
                      ),
                    ],

                  ),
                ),
              ),
              Positioned(
                right: 2,
                top: 10,
                child: PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert, color: Colors.white),
                  onSelected: (value) {
                    if (value == 'delete') {
                      context.read<FavCubit>().removeFromFavorites(image.id);
                    }
                    else if (value == 'set_as') {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context)=>setWallpaperPage(url: image.imageUrlLarge,),
                      ));
                    }
                    else if (value == 'share') {
                      // Share functionality
                    }
                    else if (value == 'download') {
                      // Show info
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(value: 'delete', child: Text('Delete')),
                    PopupMenuItem(value: 'set_as', child: Text('Set as')),
                    PopupMenuItem(value: 'share', child: Text('Share')),
                    PopupMenuItem(value: 'download', child: Text('Download')),
                  ],
                ),
              )
            ],
          );
        },);
    }
    else if(state is FavError){
      return Center(child: Text("Error loading favorites",style: TextStyle(color: Colors.white,fontSize: 20),));
    }
    return Center(child: Text("Something went wrong",style: TextStyle(color: Colors.white,fontSize: 20),));

  },
),
        ),
      ),
    );
  }
}
