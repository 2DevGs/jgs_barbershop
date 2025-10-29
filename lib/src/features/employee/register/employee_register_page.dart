import 'package:flutter/material.dart';
import 'package:jgs_barbershop/src/core/ui/widgets/avatar_widget.dart';

class EmployeeRegisterPage extends StatelessWidget {
  const EmployeeRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastrar colaborador')),
      backgroundColor: Colors.white,
      body: const SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              AvatarWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
