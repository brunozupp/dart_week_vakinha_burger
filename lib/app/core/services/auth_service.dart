import 'package:dart_week_vakinha_burger/app/core/constants/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AuthService extends GetxService {

  final _isLogged = RxnBool();

  final _getStorage = GetStorage();

  Future<AuthService> init() async {
    
    // Quando o listener é criado, ele não executa essa função de primeira
    // por isso preciso fazer uma verificação ao executar esse método init
    _getStorage.listenKey(Constants.USER_KEY, (value) { 
      _isLogged(value != null);
    });

    ever<bool?>(_isLogged, (isLogged) {
      if(isLogged == null || !isLogged) {
        Get.offAllNamed('/auth/login');
      } else {
        Get.offAllNamed('/home');
      }
    });

    // fazendo a verificação aqui pois o listener não é executado quando criado
    _isLogged(getUserId() != null);

    return this;
  }

  void logout() => _getStorage.write(Constants.USER_KEY, null);

  int? getUserId() => _getStorage.read(Constants.USER_KEY);
}