import 'dart:developer';

import 'package:dart_week_vakinha_burger/app/core/constants/constants.dart';
import 'package:dart_week_vakinha_burger/app/core/exceptions/rest_client_exception.dart';
import 'package:dart_week_vakinha_burger/app/core/exceptions/user_not_found_exception.dart';
import 'package:dart_week_vakinha_burger/app/core/mixins/loader_mixin.dart';
import 'package:dart_week_vakinha_burger/app/core/mixins/messages_mixin.dart';
import 'package:dart_week_vakinha_burger/app/repositories/auth/auth_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {

  final AuthRepository _authRepository;

  LoginController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final _loading = false.obs;

  final _message = Rxn<MessageModel>();

  Future<void> login({
    required String email,
    required String password
  }) async {

    _loading.toggle();

    try {
      
      final userLogged = await _authRepository.login(email, password);

      final storage = GetStorage();

      storage.write(Constants.USER_KEY, userLogged.id);

      _loading.toggle();

    } on UserNotFoundException catch(e, s) {
      _loading.toggle();

      log("Login e/ou senha inválidos", error: e, stackTrace: s);

      _message(MessageModel(
        title: "Erro", 
        message: "Login e/ou senha inválidos", 
        type: MessageType.error
      ));
    } catch(e,s) {

      _loading.toggle();

      log("Erro ao realizar login", error: e, stackTrace: s);

      _message(MessageModel(
        title: "Erro", 
        message: "Erro ao realizar login", 
        type: MessageType.error
      ));
    }
  }

  @override
  void onInit() {
    
    loaderListener(_loading);

    messageListener(_message);

    super.onInit();
  }
}