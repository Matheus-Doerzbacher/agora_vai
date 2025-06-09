import 'package:agora_vai/data/repository/auth_repository.dart';
import 'package:agora_vai/ui/auth/logout/logout_button.dart';
import 'package:agora_vai/ui/user/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:result_command/result_command.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final UserViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = UserViewModel(
      authRepository: context.read(),
      usuarioRepository: context.read(),
      lembreteRepository: context.read(),
      compromissoRepository: context.read(),
    );
    _viewModel.deleteUser.addListener(_onDeleteUser);
  }

  @override
  void dispose() {
    _viewModel.deleteUser.removeListener(_onDeleteUser);
    super.dispose();
  }

  void _onDeleteUser() {
    if (_viewModel.deleteUser.isSuccess) {
      _viewModel.deleteUser.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.green,
          content: Text('Usuário deletado com sucesso'),
        ),
      );
    }

    if (_viewModel.deleteUser.isFailure) {
      final failure = _viewModel.deleteUser.value as FailureCommand;
      _viewModel.deleteUser.reset();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.red,
          content: Text(failure.error.toString().replaceAll('Exception: ', '')),
        ),
      );
    }
  }

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
                  usuario.name.substring(0, 1).toUpperCase(),
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
                    _buildInfoRow('Nome: ', usuario.name),
                    _buildInfoRow('Email: ', usuario.email),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  LogoutButton(viewModel: context.read()),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Deletar Conta'),
                          content: const Text(
                            // ignore: lines_longer_than_80_chars
                            'Tem certeza que deseja deletar sua conta? Esta ação não pode ser desfeita.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancelar'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                _viewModel.deleteUser.execute();
                              },
                              child: const Text(
                                'Deletar',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Deletar Conta'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(children: [Text(label), Text(value)]);
  }
}
