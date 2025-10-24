import 'package:flutter/material.dart';

import '../../../../core/ui/widgets/hours_panel.dart';
import '../../../../core/ui/widgets/weekdays_panel.dart';

class BarbershopRegisterPage extends StatelessWidget {
  const BarbershopRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text('Cadastrar estabelecimento')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                decoration: const InputDecoration(label: Text('Nome')),
              ),
              const SizedBox(height: 24),
              TextFormField(
                decoration: const InputDecoration(label: Text('E-mail')),
              ),
              const SizedBox(height: 24),
              WeekdaysPanel(onDayPressed: (value) {
                print('Dia selecionado: $value');
              },),
              const SizedBox(height: 24),
              HoursPanel(startTime: 6, endTime: 23),
              const SizedBox(height: 48),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56),
                ),
                child: const Text('CADASTRAR ESTABELECIMENTO'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
