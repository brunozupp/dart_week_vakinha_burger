import 'dart:developer';

import 'package:dart_week_vakinha_burger/app/core/exceptions/rest_client_exception.dart';
import 'package:dart_week_vakinha_burger/app/core/mixins/loader_mixin.dart';
import 'package:dart_week_vakinha_burger/app/core/mixins/messages_mixin.dart';
import 'package:get/get.dart';

import 'package:dart_week_vakinha_burger/app/repositories/auth/auth_repository.dart';

class RegisterController extends GetxController with LoaderMixin, MessagesMixin {

  final AuthRepository _authRepository;

  RegisterController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final _loading = false.obs;

  final _message = Rxn<MessageModel>();

  Future<void> register({
    required String name,
    required String email,
    required String password
  }) async {

    _loading.toggle();

    try {
      
      await _authRepository.register(name, email, password);

      _message(MessageModel(
        title: "Sucesso", 
        message: "Cadastro realizado com sucesso", 
        type: MessageType.info
      ));

      _loading.toggle();

      Get.back();

    } on RestClientException catch (e, s) {

      _loading.toggle();

      log("Erro ao registrar usuário", error: e, stackTrace: s);

      _message(MessageModel(
        title: "Erro", 
        message: e.message, 
        type: MessageType.error
      ));
    } catch(e,s) {

      _loading.toggle();

      log("Erro ao registrar usuário", error: e, stackTrace: s);

      _message(MessageModel(
        title: "Erro", 
        message: "Erro ao registrar usuário", 
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
