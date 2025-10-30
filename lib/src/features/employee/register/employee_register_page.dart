import 'package:flutter/material.dart';
import 'package:jgs_barbershop/src/core/ui/constants.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/avatar_widget.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/hours_panel.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/weekdays_panel.dart';

class EmployeeRegisterPage extends StatefulWidget {
  const EmployeeRegisterPage({super.key});

  @override
  State<EmployeeRegisterPage> createState() => _EmployeeRegisterPageState();
}

class _EmployeeRegisterPageState extends State<EmployeeRegisterPage> {
  var registerADM = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar colaborador'),
        scrolledUnderElevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                        decoration: InputDecoration(label: Text('Nome')),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        decoration: InputDecoration(label: Text('E-mail')),
                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        decoration: InputDecoration(label: Text('Senha')),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
                WeekdaysPanel(
                  enabledDays: const ['Seg', 'Qua', 'Sab'],
                  onDayPressed: (String day) {},
                ),
                const SizedBox(height: 24),
                HoursPanel(
                  startTime: 6,
                  endTime: 23,
                  onHourPressed: (int hour) {},
                  enabledTimes: [6, 7, 12, 13, 15, 16, 17, 20, 21, 22, 23],
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {},
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
  }
}
