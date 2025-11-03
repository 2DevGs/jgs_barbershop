import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jgs_barbershop/src/core/ui/barbershop_icons.dart';
import 'package:jgs_barbershop/src/core/ui/constants.dart';
import 'package:jgs_barbershop/src/core/ui/helpers/form_helper.dart';
import 'package:jgs_barbershop/src/core/ui/helpers/messages.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:jgs_barbershop/src/features/schedule/widgets/schedule_calendar.dart';
import 'package:validatorless/validatorless.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  var dateFormat = DateFormat('dd/MM/yyyy');
  var showCalendar = false;
  final _formKey = GlobalKey<FormState>();
  final _clientEC = TextEditingController();
  final _dateEC = TextEditingController();

  @override
  void dispose() {
    _clientEC.dispose();
    _dateEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendar cliente')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                children: [
                  AvatarWidget(hideUploadButton: true),
                  const SizedBox(height: 12),
                  const Text(
                    'Nome e sobrenome',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 37),
                  TextFormField(
                    controller: _clientEC,
                    validator: Validatorless.required('Nome do cliente obrigatório'),
                    onTapOutside: (_) => context.unFocus(),
                    decoration: const InputDecoration(label: Text('Cliente')),
                  ),
                  const SizedBox(height: 32),
                  TextFormField(
                    controller: _dateEC,
                    validator: Validatorless.required('Selecione a data do agendamento'),
                    onTapOutside: (_) => context.unFocus(),
                    onTap: () {
                      setState(() {
                        showCalendar = true;
                      });
                      context.unFocus();
                    },
                    readOnly: true,
                    decoration: const InputDecoration(
                      label: Text('Selecione uma data'),
                      hintText: 'Selecione uma data',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
                      suffixIcon: Icon(
                        BarbershopIcons.calendar,
                        color: ColorsConstants.brow,
                        size: 18,
                      ),
                    ),
                  ),
                  Offstage(
                    offstage: !showCalendar,
                    child: Column(
                      children: [
                        const SizedBox(height: 24),
                        ScheduleCalendar(
                          cancelPressed: () {
                            setState(() {
                              showCalendar = false;
                            });
                          },
                          okPressed: (value) {
                            setState(() {
                              _dateEC.text = dateFormat.format(value);
                              showCalendar = false;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  HoursPanel.singleSelection(
                    startTime: 6,
                    endTime: 23,
                    onHourPressed: (hour) {},
                    enabledTimes: [6, 7, 8],
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(56),
                    ),
                    onPressed: () {
                      switch(_formKey.currentState?.validate()){
                        case null || false:
                          Messages.showError('Dados incompletos!', context);
                          case true: 
                            // Call Vm
                      }
                    },
                    child: const Text('AGENDAR'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
