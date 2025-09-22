import 'package:bloc/bloc.dart';
import 'package:wallpaper_app/cubits/navBar/navbar_state.dart';
class NavbarCubit extends Cubit<NavigationState> {
  NavbarCubit() : super(NavigationState(selectedIndex: 0));
  void updateIndex(int index){
    emit(NavigationState(selectedIndex:index));
  }
}
