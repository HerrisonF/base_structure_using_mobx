import 'package:base_structure_using_mobx/app/controller/master_controller/master_controller.dart';
import 'package:base_structure_using_mobx/app/data/model/user.dart';
import 'package:base_structure_using_mobx/app/ui/android/pages/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

part 'login_controller.g.dart';

class LoginController = _LoginController with _$LoginController;

abstract class _LoginController with Store {

  final MasterController masterController = GetIt.I<MasterController>();

  final TextEditingController emailEditingController = TextEditingController();
  final TextEditingController passwordEditingController =
  TextEditingController();

  @observable
  User user = User();

  @observable
  bool showPassword = false;

  @observable
  bool isLoading = false;


  @observable
  bool successLogin = true;

  @action
  setSuccessLogin(bool status){
    successLogin = status;
  }

  @action
  changePasswordVisibility() {
    showPassword = !showPassword;
  }

  @action
  cleanFormError(){
    setSuccessLogin(true);
  }

  @action
  startLoading(){
    isLoading = true;
  }

  @action
  stopLoading(){
    isLoading = false;
  }

  void login(BuildContext context) async {
    _pushToHome(context);
  }

  _pushToHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => HomePage(),
      ),
    );
  }
}