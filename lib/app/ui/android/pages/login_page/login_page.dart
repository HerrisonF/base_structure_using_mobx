import 'package:base_structure_using_mobx/app/constants/assets.dart';
import 'package:base_structure_using_mobx/app/constants/text_constants.dart';
import 'package:base_structure_using_mobx/app/controller/login_controller/login_controller.dart';
import 'package:base_structure_using_mobx/app/ui/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:progress_indicators/progress_indicators.dart';

const MESSAGE_ERROR = "Esse campo é obrigatório";

final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

class LoginPage extends StatelessWidget {
  final LoginController loginController = GetIt.I<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appThemeData.backgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: SvgPicture.asset(logo),
              ),
              Form(
                key: _loginFormKey,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 65,
                      width: double.infinity,
                      child: TextFormField(
                        enabled: true,
                        controller: loginController.emailEditingController,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.toString().isEmpty) {
                            return MESSAGE_ERROR;
                          }
                          return null;
                        },
                        onChanged: (value) {
                          loginController.cleanFormError();
                        },
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.black,
                        ),
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: emailHint,
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      height: 65,
                      width: double.infinity,
                      child: Observer(
                        builder: (_) {
                          return TextFormField(
                            keyboardType: TextInputType.text,
                            enabled: true,
                            textInputAction: TextInputAction.done,
                            controller:
                                loginController.passwordEditingController,
                            validator: (value) {
                              if (value.toString().isEmpty) {
                                return MESSAGE_ERROR;
                              }
                              return null;
                            },
                            onChanged: (value) {
                              loginController.cleanFormError();
                            },
                            onFieldSubmitted: (value) {
                              submit(context);
                            },
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                            obscureText: !loginController.showPassword,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  loginController.changePasswordVisibility();
                                },
                                icon: Observer(
                                  builder: (_) {
                                    return Icon(
                                      loginController.showPassword
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: appThemeData.accentColor,
                                    );
                                  },
                                ),
                              ),
                              labelText: passwordHint,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 40),
                child: OutlinedButton(
                  child: Observer(
                    builder: (_) {
                      return loginController.isLoading
                          ? Container(
                              child: JumpingDotsProgressIndicator(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              loginButton,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            );
                    },
                  ),
                  onPressed: () {
                    submit(context);
                  },
                ),
              ),
              Observer(
                builder: (_) {
                  return !loginController.successLogin
                      ? Container(
                          padding: EdgeInsets.only(top: 20),
                          child: Text(
                            loginErrorMessage,
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        )
                      : SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  submit(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (_loginFormKey.currentState!.validate()) {
      loginController.login(context);
    } else {
      loginController.setSuccessLogin(false);
    }
  }
}
