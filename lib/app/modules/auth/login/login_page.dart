import 'package:dart_week_vakinha_burger/app/core/ui/vakinha_state.dart';
import 'package:dart_week_vakinha_burger/app/core/ui/vakinha_ui.dart';
import 'package:dart_week_vakinha_burger/app/core/ui/widgets/vakinha_appbar.dart';
import 'package:dart_week_vakinha_burger/app/core/ui/widgets/vakinha_button.dart';
import 'package:dart_week_vakinha_burger/app/core/ui/widgets/vakinha_textformfield.dart';
import 'package:dart_week_vakinha_burger/app/modules/auth/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({ Key? key }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends VakinhaState<LoginPage, LoginController> {

  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    super.dispose();

    _emailEC.dispose();
    _passwordEC.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VakinhaAppBar(
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: LayoutBuilder(
        builder: (_, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Login",
                          style: context.textTheme.headline6?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: context.theme.primaryColorDark
                          ),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        VakinhaTextFormField(
                          label: "Email",
                          controller: _emailEC,
                          validator: Validatorless.multiple([
                            Validatorless.required("Email obrigatório"),
                            Validatorless.email("Email inválido")
                          ]),
                        ),

                        const SizedBox(
                          height: 30,
                        ),

                        VakinhaTextFormField(
                          label: "Senha",
                          obscureText: true,
                          controller: _passwordEC,
                          validator: Validatorless.multiple([
                            Validatorless.required("Senha obrigatório"),
                            Validatorless.min(6, "Senha deve conter pelo menos 6 caracteres")
                          ]),
                        ),

                        const SizedBox(
                          height: 50,
                        ),

                        Center(
                          child: VakinhaButton(
                            label: "ENTRAR",
                            width: context.width,
                            onPressed: () async {

                              final formValid = _formKey.currentState?.validate() ?? false;

                              if(formValid) {

                                await controller.login(
                                  email: _emailEC.text, 
                                  password: _passwordEC.text
                                );
                              }
                            },
                          ),
                        ),

                        const Spacer(),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("Não possui uma conta?"),
                            TextButton(
                              onPressed: () {
                                Get.toNamed("/auth/register");
                              }, 
                              child: const Text(
                                "Cadastre-se",
                                style: VakinhaUI.textBold,
                              )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}