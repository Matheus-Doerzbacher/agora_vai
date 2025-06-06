import 'package:agora_vai/data/repository/auth_repository.dart';
import 'package:agora_vai/ui/auth/logout/logout_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    final usuario = context.read<AuthRepository>().usuarioLogado!;
    return Scaffold(
      appBar: AppBar(title: const Text('Usuário')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 20),
            Center(
              child: CircleAvatar(
                radius: 50,
                child: Text(
                  usuario.nome.substring(0, 1).toUpperCase(),
                  style: const TextStyle(fontSize: 32),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Informações Pessoais',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildInfoRow('Nome', usuario.nome),
                    _buildInfoRow('Email', usuario.email),
                    _buildInfoRow('ID', usuario.idUsuario.toString()),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(child: LogoutButton(viewModel: context.read())),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(children: [Text(label), Text(value)]);
  }
}
