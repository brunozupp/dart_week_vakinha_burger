import 'package:dart_week_vakinha_burger/app/core/ui/vakinha_state.dart';
import 'package:dart_week_vakinha_burger/app/core/ui/widgets/vakinha_appbar.dart';
import 'package:dart_week_vakinha_burger/app/core/ui/widgets/vakinha_button.dart';
import 'package:dart_week_vakinha_burger/app/core/ui/widgets/vakinha_textformfield.dart';
import 'package:dart_week_vakinha_burger/app/modules/auth/register/register_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({ Key? key }) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends VakinhaState<RegisterPage, RegisterController> {

  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {

    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: VakinhaAppBar(
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: IntrinsicHeight(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Cadastro",
                  style: context.textTheme.headline6?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.theme.primaryColorDark
                  ),
                ),

                Text(
                  "Preencha os campos abaixo para criar o seu cadastro.",
                  style: context.textTheme.bodyText1,
                ),

                const SizedBox(
                  height: 30,
                ),

                VakinhaTextFormField(
                  label: "Nome",
                  controller: _nameEC,
                  validator: Validatorless.required("Nome obrigatório"),
                ),

                const SizedBox(
                  height: 30,
                ),

                VakinhaTextFormField(
                  label: "Email",
                  controller: _emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required("Email obrigatório"),
                    Validatorless.email("Email inválido"),
                  ]),
                ),

                const SizedBox(
                  height: 30,
                ),

                VakinhaTextFormField(
                  label: "Senha",
                  controller: _passwordEC,
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required("Senha obrigatória"),
                    Validatorless.min(6, "Senha deve conter pelo menos 6 caracteres"),
                  ]),
                ),

                const SizedBox(
                  height: 30,
                ),

                VakinhaTextFormField(
                  label: "Confirma senha",
                  obscureText: true,
                  validator: Validatorless.multiple([
                    Validatorless.required("Confirma senha obrigatória"),
                    Validatorless.compare(_passwordEC, "Senha diferente da informada acima")
                  ]),
                ),

                const SizedBox(
                  height: 50,
                ),

                Center(
                  child: VakinhaButton(
                    label: "CADASTRAR",
                    width: context.width,
                    onPressed: () async {
                      final formValid = _formKey.currentState?.validate() ?? false;

                      if(formValid) {
                        
                        await controller.register(
                          name: _nameEC.text,
                          email: _emailEC.text, 
                          password: _passwordEC.text
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}