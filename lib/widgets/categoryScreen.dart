import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/bloc/wallhub_bloc.dart';
import 'package:wallpaper_app/bloc/wallhub_event.dart';
import 'package:wallpaper_app/bloc/wallhub_state.dart';
import 'package:wallpaper_app/pages/setWallPaper.dart';
class categoryWidget extends StatefulWidget {
  final String query;
  final String category;
   categoryWidget({super.key,required this.query, required this.category});

  @override
  State<categoryWidget> createState() => _categoryWidgetState();
}

class _categoryWidgetState extends State<categoryWidget> {
  late String url;
  late int page=1;
  List<bool> isLiked=[];
  List images=[];
  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
  // ScrollController to detect scroll position
  ScrollController scrollController=ScrollController();

  initState() {
    super.initState();
     url='https://api.pexels.com/v1/search?query=${widget.query}&per_page=50&auto=compress&format=webp';
    BlocProvider.of<wallhubBloc>(context).add(wallhubLoadEvent(url: url));
  }


  int selectedIndex= 0;
  void toggelSection(int index){
    setState((){
      selectedIndex=index;
    });
  }

  void onRefresh(){
    setState(() {
      page=page+1;
      url='https://api.pexels.com/v1/search?query=${widget.query}&per_page=50&page=$page&auto=compress&format=webp';
    });
    BlocProvider.of<wallhubBloc>(context).add(wallhubReloadEvent(url: url));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor:theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(widget.category,style: theme.textTheme.titleLarge,),
        backgroundColor:theme.appBarTheme.backgroundColor,
        elevation: 15,
        actions: [
          // IconButton(
          //   icon:Icon(Icons.search,color: theme.appBarTheme.iconTheme?.color,),
          //   onPressed: (){},
          // )
        ],
      ),
      body:Center(
        child:Column(
            children:[
              Expanded(
                child: Scrollbar(
                  controller: scrollController,
                  thumbVisibility: true,
                  thickness: 4,
                  child: BlocBuilder<wallhubBloc, wallhubState>(
                    builder: (context, state){
                      if(state is wallhubLoadingState){
                        return Center(child: CircularProgressIndicator(
                          value: null, // or a value like 0.5
                          color: Colors.lightBlue,
                          backgroundColor: Colors.grey[800],
                          strokeWidth: 5.0,
                          semanticsLabel: 'Loading...',
                        )
                          ,);
                      } else if(state is wallhubLoadedState){
                        images = state.images;
                        isLiked=state.isliked;// Reset images for first load
                        return Container(
                          margin: EdgeInsets.all(15),
                          child:GridView.builder(
                              controller: scrollController,
                              itemCount: images.length,
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio:2/3,),
                              itemBuilder: (context,index){
                                final image=images[index];
                                return InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(
                                      builder: (context)=>setWallpaperPage(url: image.imageUrlLarge,),
                                    ));
                                  },
                                  onDoubleTap: (){
                                    BlocProvider.of<wallhubBloc>(context).add(ToggelLikeEvent(index: index));
                                    print("double tap");

                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Stack(
                                      fit:StackFit.expand,
                                      children:[
                                        CachedNetworkImage(
                                          imageUrl: image.imageUrlMedium,
                                          placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                          errorWidget: (context, url, error) => Icon(Icons.error),
                                          fit: BoxFit.fill,
                                        ),

                                        Positioned(
                                          bottom: 2,
                                          right: 1,
                                          child: BlocBuilder<wallhubBloc, wallhubState>(
                                            builder: (context, state) {
                                              final isLiked = state is wallhubLoadedState ? state.isliked[index] : false;
                                              return Material(
                                                color: Colors.transparent,
                                                child: Ink(
                                                  decoration: BoxDecoration(
                                                    color: Colors.transparent,
                                                    borderRadius: BorderRadius.circular(50),
                                                    // boxShadow: [
                                                    //   BoxShadow(
                                                    //     color: isLiked ? Colors.pink.withOpacity(0.6) : Colors.transparent,
                                                    //     blurRadius: 3,
                                                    //     spreadRadius: 1,
                                                    //   ),
                                                    // ],
                                                  ),
                                                  child: IconButton(
                                                    icon: Icon(
                                                      isLiked ? Icons.favorite : Icons.favorite_border,
                                                      color: isLiked ? Colors.pink : Colors.white70,
                                                      size: 24,
                                                    ),
                                                    tooltip: isLiked ? 'Unlike' : 'Like',
                                                    splashRadius: 6,
                                                    onPressed: () {
                                                      BlocProvider.of<wallhubBloc>(context).add(ToggelLikeEvent(index: index));
                                                    },
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );;
                              }),

                        );}
                      else if(state is wallhubErrorState){
                        return Center(child: Text("Error: ${state.error}",style: TextStyle(color: Colors.red),));
                      }
                      else{
                        return Center(child: Text("press reload button ",style: TextStyle(color: Colors.red),));
                      }
                    },
                  ),
                ),
              )
            ]
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(5.0),
        child: FloatingActionButton(onPressed: (){
          onRefresh();
        },
          tooltip: 'Load More',
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
              side: BorderSide(color: Colors.blueGrey,width: 1)
          ),
          backgroundColor: Colors.lightBlue,
          child: Icon(Icons.refresh,color: Colors.white,size: 30,),
        ),
      ),
    );
  }
}
