import 'package:base_structure_using_mobx/app/data/model/user.dart';
import 'package:base_structure_using_mobx/app/data/provider/preferences_provider.dart';

class PreferencesRepository {

  final PreferencesApiClient preferencesApiClient = PreferencesApiClient();

  Future<bool> saveUserPreferences(User user){
    return preferencesApiClient.saveUserPreferences(user);
  }

  Future<User> getUserPreferences() async {
    return await preferencesApiClient.getUserPreferences();
  }
}