import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jgs_barbershop/src/core/providers/application_providers.dart';
import 'package:jgs_barbershop/src/core/ui/constants.dart';
import 'package:jgs_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:jgs_barbershop/src/core/ui/helpers/messages.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/barbershop_loader.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/weekdays_panel.dart';
import 'package:jgs_barbershop/src/features/employee/register/employee_register_state.dart';
import 'package:jgs_barbershop/src/features/employee/register/employee_register_vm.dart';
import 'package:jgs_barbershop/src/model/barbershop_model.dart';
import 'package:validatorless/validatorless.dart';

class EmployeeRegisterPage extends ConsumerStatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  ConsumerState<EmployeeRegisterPage> createState() =>
      _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends ConsumerState<EmployeeRegisterPage> {
  var registerADM = false;
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
    final employeeRegisterVM = ref.watch(employeeRegisterVmProvider.notifier);
    final barbershopAsyncValue = ref.watch(getMyBarbershopProvider);

    ref.listen(employeeRegisterVmProvider.select((state) => state.status), (_, status) {
      switch(status){
        case EmployeeRegisterStateStatus.initial:
          break;
        case EmployeeRegisterStateStatus.success:
          Messages.showSuccess('Colaborador cadastrado com sucesso!', context);
          Navigator.of(context).pop();
        case EmployeeRegisterStateStatus.error:
          Messages.showError('Erro ao registrar colaborador!', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar colaborador'),
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: barbershopAsyncValue.when(
        error: (error, stackTrace) {
          log(
            'Erro ao carregar a página',
            error: error,
            stackTrace: stackTrace,
          );
          return Center(
            child: Text(
              'Erro ao carregar a página, por favor reinicie a operação',
            ),
          );
        },
        loading: () => const BarbershopLoader(),
        data: (barbershopModel) {
          final BarbershopModel(:openingDays, :openingHours) = barbershopModel;
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _formKey,
                child: Center(
                  child: Column(
                    children: [
                      const AvatarWidget(),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Checkbox.adaptive(
                            value: registerADM,
                            onChanged: (value) {
                              setState(() {
                                registerADM = !registerADM;
                                employeeRegisterVM.setRegisterADM(registerADM);
                              });
                            },
                            activeColor: ColorsConstants.brow,
                          ),
                          const Expanded(
                            child: Text(
                              'Sou administrador e quero me cadastrar como colaborador.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                      Offstage(
                        offstage: registerADM,
                        child: Column(
                          children: [
                            const SizedBox(height: 24),
                            TextFormField(
                              onTapOutside: (_) => context.unFocus(),
                              controller: _nameEC,
                              validator: registerADM ? null : 
                              Validatorless.required(
                                'Nome Obrigatório',
                              ),
                              decoration: InputDecoration(label: Text('Nome')),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              onTapOutside: (_) => context.unFocus(),
                              controller: _emailEC,
                              validator: registerADM ? null : 
                              Validatorless.multiple([
                                Validatorless.required('E-mail Obrigatório'),
                                Validatorless.email('E-mail inválido'),
                              ]),
                              decoration: InputDecoration(
                                label: Text('E-mail'),
                              ),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              onTapOutside: (_) => context.unFocus(),
                              obscureText: true,
                              controller: _passwordEC,
                              validator: registerADM ? null : 
                              Validatorless.multiple([
                                Validatorless.required('Senha Obrigatória'),
                                Validatorless.min(
                                  6,
                                  'Senha deve conter pelo menos 6 caracteres.',
                                ),
                              ]),
                              decoration: InputDecoration(label: Text('Senha')),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      WeekdaysPanel(
                        enabledDays: openingDays,
                        onDayPressed: employeeRegisterVM.addOrRemoveWorkDays,
                      ),
                      const SizedBox(height: 24),
                      HoursPanel(
                        startTime: 6,
                        endTime: 23,
                        onHourPressed: employeeRegisterVM.addOrRemoveWorkHours,
                        enabledTimes: openingHours,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: () {
                          switch (_formKey.currentState?.validate()) {
                            case false || null:
                              Messages.showError(
                                'Existem campos inválidos',
                                context,
                              );
                            case true:
                              final EmployeeRegisterState(
                                workDays: List(isNotEmpty: hasWorkDays),
                                workHours: List(isNotEmpty: hasWorkHours),
                              ) = ref.watch(
                                employeeRegisterVmProvider,
                              );
                              if (!hasWorkDays || !hasWorkHours) {
                                Messages.showError(
                                  'Por favor selecione os dias da semana e horário de atendimento',
                                  context,
                                );
                                return;
                              }
                              final name = _nameEC.text;
                              final email = _emailEC.text;
                              final password = _passwordEC.text;
                              employeeRegisterVM.register(
                                name: name,
                                email: email,
                                password: password,
                              );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56),
                        ),
                        child: Text('CADASTRAR COLABORADOR'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
