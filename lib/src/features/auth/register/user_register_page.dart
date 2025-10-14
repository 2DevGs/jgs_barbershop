import 'package:flutter/material.dart';

class UserRegisterPage extends StatelessWidget {
  const UserRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar Conta')),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(decoration: InputDecoration(label: Text('Nome'))),
              const SizedBox(height: 24),
              TextFormField(decoration: InputDecoration(label: Text('Email'))),
              const SizedBox(height: 24),
              TextFormField(decoration: InputDecoration(label: Text('Senha'))),
              const SizedBox(height: 24),
              TextFormField(
                decoration: InputDecoration(label: Text('Confirma senha')),
              ),
              const SizedBox(
                 height: 24,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(56) 
                ),
                onPressed: () {},
                child: const Text('CRIAR CONTA'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
