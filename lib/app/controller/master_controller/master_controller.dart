import 'package:base_structure_using_mobx/app/data/model/user.dart';
import 'package:base_structure_using_mobx/app/data/repository/preferences_repository.dart';
import 'package:mobx/mobx.dart';

part 'master_controller.g.dart';

class MasterController = _MasterController with _$MasterController;

abstract class _MasterController with Store {

  final PreferencesRepository preferencesRepository = PreferencesRepository();

  @observable
  User user = User();

  @action
  setCurrentUser(User user){
    this.user = user;
  }


  persistUser(){
    preferencesRepository.saveUserPreferences(user);
  }

  Future<bool> isUserLogged() async {
    user = await preferencesRepository.getUserPreferences();
    return user.id.isNotEmpty;
  }

}