
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/bloc/wallhub_state.dart';
import 'package:wallpaper_app/pages/setWallPaper.dart';
import '../bloc/wallhub_bloc.dart';
import '../bloc/wallhub_event.dart';
class galleryPage extends StatefulWidget {
  const galleryPage({super.key});

  @override
  State<galleryPage> createState() => _galleryPageState();
}

class _galleryPageState extends State<galleryPage> {
  String url = 'https://api.pexels.com/v1/curated?per_page=50&auto=compress&format=webp';
  late int page=1;
  List<bool> isLiked=[];
List images=[];
final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
  // ScrollController to detect scroll position
ScrollController scrollController=ScrollController();

  initState() {
    super.initState();
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
      url='https://api.pexels.com/v1/curated?per_page=50&page=$page&auto=compress&format=webp';
    });
    BlocProvider.of<wallhubBloc>(context).add(wallhubReloadEvent(url: url));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(), // Dismiss keyboard on tap outside
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text("WALL_HUB",style:theme.textTheme.titleLarge,),
          backgroundColor: theme.appBarTheme.backgroundColor,
          foregroundColor: theme.appBarTheme.foregroundColor,
          elevation: 15,
          actions: [
            SizedBox(
              height: 50,
              width: 150,
              child: TextField(
                enableIMEPersonalizedLearning: true,
                controller: _searchController, // add this controller
                style: TextStyle(color: theme.textTheme.bodyMedium?.color),
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(color: theme.hintColor),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(50),
                    borderSide: BorderSide(color: Colors.white, width: 1),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: theme.colorScheme.primary, width: 2),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
                onSubmitted: (query) {
                  if (query.isNotEmpty) {
                    BlocProvider.of<wallhubBloc>(context).add(wallhubSearchEvent(query: query));
                    FocusScope.of(context).unfocus(); // hide keyboard when icon pressed

                  }
                },
              ),
            ),
            IconButton(
              icon: Icon(Icons.search, color: theme.iconTheme.color, size: theme.iconTheme.size),
              onPressed: () {
                final query = _searchController.text; // get current text
                if (query.isNotEmpty) {
                  BlocProvider.of<wallhubBloc>(context).add(wallhubSearchEvent(query: query));
                  FocusScope.of(context).unfocus(); // hide keyboard when icon pressed

                }
              },
            )
          ],

        ),
        body:Center(
          child:Column(
              children:[
                Container(
                    height: 40,
                    width:MediaQuery.of(context).size.width,
                    margin: EdgeInsets.all(10),
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: selectedIndex== 0? Colors.lightBlue :Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: Colors.white38,width: 2)
                                )
                            ),
                            onPressed: (){
                              toggelSection(0);
                              BlocProvider.of<wallhubBloc>(context).add(wallhubLoadEvent(url: url));
                              print("All");
                            },
                            child: Text("All",style:TextStyle(fontSize: 18,color: Colors.white),)),
                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: selectedIndex==1? Colors.lightBlue :Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: Colors.white38,width: 2)
                                )
                            ),
                            onPressed: (){
                              toggelSection(1);
                              BlocProvider.of<wallhubBloc>(context).add(wallhubSearchEvent(query: "nature"));
                              print("Nature");
                            },
                            child: Text("Nature",style:TextStyle(fontSize: 18,color: Colors.white),)),
                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: selectedIndex==2? Colors.lightBlue :Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: Colors.white38,width: 2)
                                )
                            ),
                            onPressed: (){
                              toggelSection(2);
                              BlocProvider.of<wallhubBloc>(context).add(wallhubSearchEvent(query: "abstract"));
                              print("Abstract");
                            },
                            child: Text("Abstract",style:TextStyle(fontSize: 18,color: Colors.white),)),
                        TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: selectedIndex==3? Colors.lightBlue :Colors.grey[900],
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    side: BorderSide(color: Colors.white38,width: 2)
                                )
                            ),
                            onPressed: (){
                              toggelSection(3);
                              BlocProvider.of<wallhubBloc>(context).add(wallhubSearchEvent(query: "minimal"));
                              print("Minimal");
                            },
                            child: Text("Minimal",style:TextStyle(fontSize: 18,color: Colors.white),)),
                      ],
                    )
                ),
                Expanded(
                  child: Scrollbar(
                    controller: scrollController,
                    thumbVisibility: true,
                    thickness: 4, // Default is 6. Make it smaller like 2-4
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
                            final image = images[index];
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
      ),
    );
  }
}
