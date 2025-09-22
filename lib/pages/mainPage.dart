import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper_app/cubits/navBar/navbar_cubit.dart';
import 'package:wallpaper_app/cubits/navBar/navbar_state.dart';
import 'package:wallpaper_app/pages/favorites.dart';
import 'package:wallpaper_app/pages/gallery.dart';
import 'package:wallpaper_app/pages/settings.dart';
import 'category.dart';

class mainPage extends StatefulWidget {
  const mainPage({super.key});

  @override
  State<mainPage> createState() => _mainPageState();
}

class _mainPageState extends State<mainPage> {

  int selectedNavIndex= 0;
  PageController pageController= PageController();
  void onNavBarTapped(BuildContext context, int index) {
    context.read<NavbarCubit>().updateIndex(index);
    pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOutCubic,
    );
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavbarCubit, NavigationState>(
  builder: (context, state) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView(
        controller: pageController,
        onPageChanged: (index){
          context.read<NavbarCubit>().updateIndex(index);
        },
        physics: const CustomScrollPhysics(),
        children: [
          galleryPage(),
          categoryPage(),
          FavoritePage(),
          settingsPage(),
        ],
      ),
      bottomNavigationBar:Theme(data: Theme.of(context).copyWith(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        hoverColor: Colors.white24,
      ), child:
      BottomNavigationBar(items: const<BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.image_outlined,),label: "Gallery"),
        BottomNavigationBarItem(icon: Icon(Icons.category_outlined,),label: "Category"),
        BottomNavigationBarItem(icon: Icon(Icons.favorite,),label: "Favorite"),
        BottomNavigationBarItem(icon: Icon(Icons.settings,),label: "Settings"),
      ],
        backgroundColor: Colors.black,
        currentIndex: state.selectedIndex,
        selectedItemColor: Colors.lightBlue,
        unselectedItemColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        onTap:(index)=> onNavBarTapped(context,index),))
     ,

    );
  },
);
  }
}
class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({ScrollPhysics? parent}) : super(parent: parent);

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  SpringDescription get spring => const SpringDescription(
    mass: 80, // Higher mass for smoother movement
    stiffness: 100, // Lower stiffness for less resistance
    damping: 1.0, // Balanced damping
  );
}