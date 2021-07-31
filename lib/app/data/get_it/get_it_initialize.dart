import 'package:base_structure_using_mobx/app/controller/login_controller/login_controller.dart';
import 'package:base_structure_using_mobx/app/controller/master_controller/master_controller.dart';
import 'package:base_structure_using_mobx/app/data/http/dio_client.dart';
import 'package:get_it/get_it.dart';

abstract class GetItInitialize {

  static getItControllers(){
    GetIt.I.registerSingleton(DioClient());
    GetIt.I.registerSingleton(MasterController());
    GetIt.I.registerSingleton(LoginController());
  }

}