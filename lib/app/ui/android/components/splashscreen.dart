import 'package:base_structure_using_mobx/app/constants/assets.dart';
import 'package:base_structure_using_mobx/app/controller/master_controller/master_controller.dart';
import 'package:base_structure_using_mobx/app/ui/android/pages/home_page/home_page.dart';
import 'package:base_structure_using_mobx/app/ui/android/pages/login_page/login_page.dart';
import 'package:base_structure_using_mobx/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final MasterController masterController = GetIt.I<MasterController>();

  @override
  void initState() {
    super.initState();
    _isUserLogged();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: appThemeData.backgroundColor,
        child: Center(
          child: SvgPicture.asset(logo, height: 40,width: 40,),
        ),
      ),
    );
  }

  _isUserLogged() async {
    bool isUserLogged = await masterController.isUserLogged();
    if(isUserLogged){
      _pushToHome();
    }else{
      _pushToLogin();
    }
  }

  _pushToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  _pushToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

}
