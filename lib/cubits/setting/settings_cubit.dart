import 'package:bloc/bloc.dart';
import 'package:wallpaper_app/cubits/setting/settings_state.dart';


class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial()){
    emit(AppThemeState(isDark: false));
  }
  void ChangeToDarkTheme(){
    emit(AppThemeState(isDark:true));
  }
  void ChangeToLightTheme(){
    emit(AppThemeState(isDark:false));
  }
}
