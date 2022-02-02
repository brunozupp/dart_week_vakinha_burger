import 'dart:developer';

import 'package:dart_week_vakinha_burger/app/core/constants/constants.dart';
import 'package:dart_week_vakinha_burger/app/core/exceptions/rest_client_exception.dart';
import 'package:dart_week_vakinha_burger/app/core/mixins/loader_mixin.dart';
import 'package:dart_week_vakinha_burger/app/core/mixins/messages_mixin.dart';
import 'package:get/get.dart';

import 'package:dart_week_vakinha_burger/app/repositories/auth/auth_repository.dart';
import 'package:get_storage/get_storage.dart';

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
      
      final userLogged = await _authRepository.register(name, email, password);

      _loading.toggle();

      GetStorage().write(Constants.USER_KEY, userLogged.id);

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
