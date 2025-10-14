import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jgs_barbershop/src/core/ui/constants.dart';
import 'package:jgs_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:jgs_barbershop/src/core/ui/helpers/messages.dart';
import 'package:jgs_barbershop/src/features/auth/login/login_state.dart';
import 'package:jgs_barbershop/src/features/auth/login/login_vm.dart';
import 'package:validatorless/validatorless.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final LoginVm(:login) = ref.watch(loginVmProvider.notifier);
    ref.listen(loginVmProvider, (_, state) {
      switch(state){
        case LoginState(status: LoginStateStatus.initial):
          break;
        case LoginState(status: LoginStateStatus.error, :final errorMessage?):
          Messages.showError(errorMessage, context);
          break;
        case LoginState(status: LoginStateStatus.error):
          Messages.showError('Erro ao realizar LogIn', context);
          break;
        case LoginState(status: LoginStateStatus.admLogin):
          Navigator.of(context).pushNamedAndRemoveUntil('/home/adm', (route) => false,);
          break;
        case LoginState(status: LoginStateStatus.employeeLogin):
          Navigator.of(context).pushNamedAndRemoveUntil('/home/employee', (route) => false,);
          break;
      }
    },);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Form(
        key: _formKey,
        child: DecoratedBox(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImagesConstants.backgroundChair),
              fit: BoxFit.cover,
              opacity: 0.2,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(ImagesConstants.imageLogo),
                          const SizedBox(height: 20),
                          TextFormField(
                            onTapOutside: (_) => context.unFocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required('Email obrigatório'),
                              Validatorless.email('Email inválido'),
                            ]),
                            controller: _emailEC,
                            decoration: InputDecoration(
                              label: Text('E-mail'),
                              hintText: 'E-mail',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
                            onTapUpOutside: (_) => context.unFocus(),
                            validator: Validatorless.multiple([
                              Validatorless.required('Senha obrigatória'),
                              Validatorless.min(
                                6,
                                'A senha deve conter pelo menos 6 caracteres',
                              ),
                            ]),
                            obscureText: true,
                            controller: _passwordEC,
                            decoration: InputDecoration(
                              label: Text('Senha'),
                              hintText: 'Senha',
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
                              labelStyle: TextStyle(color: Colors.black),
                              hintStyle: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 26),
                          const Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Esqueceu a senha?',
                              style: TextStyle(
                                color: ColorsConstants.brow,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size.fromHeight(56),
                            ),
                            onPressed: () {
                              switch (_formKey.currentState?.validate()) {
                                case (false || null):
                                  Messages.showError(
                                    'Campos inválidos',
                                    context,
                                  );
                                  break;
                                case true:
                                  login(_emailEC.text, _passwordEC.text);
                              }
                            },
                            child: Text('ACESSAR'),
                          ),
                        ],
                      ),
                      const Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          'Criar Conta',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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
