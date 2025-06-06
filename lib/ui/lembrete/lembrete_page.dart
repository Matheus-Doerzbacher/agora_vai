import 'package:agora_vai/data/service/api/model/lembrete/lembrete_create.dart';
import 'package:agora_vai/ui/lembrete/lembrete_viewmodel.dart';
import 'package:agora_vai/ui/lembrete/widgets/form_lembrete_widget.dart';
import 'package:flutter/material.dart';

class LembretePage extends StatefulWidget {
  final LembreteViewModel viewModel;
  const LembretePage({super.key, required this.viewModel});

  @override
  State<LembretePage> createState() => _LembretePageState();
}

class _LembretePageState extends State<LembretePage> {
  void _handleSubmit(CreateLembrete lembrete) {
    widget.viewModel.createLembrete.execute(lembrete);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lembretes')),
      body: ListenableBuilder(
        listenable: Listenable.merge([
          widget.viewModel,
          widget.viewModel.getLembretes,
        ]),
        builder: (context, _) {
          if (widget.viewModel.getLembretes.isRunning) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.viewModel.lembretes.isEmpty) {
            return const Center(child: Text('Nenhum lembrete encontrado'));
          }

          return ListView.builder(
            itemCount: widget.viewModel.lembretes.length,
            itemBuilder: (context, index) {
              final lembrete = widget.viewModel.lembretes[index];
              return ListTile(
                title: Text(lembrete.titulo),
                subtitle: Text(lembrete.descricao),
                trailing: lembrete.isConcluido == true
                    ? const Icon(Icons.check_circle, color: Colors.green)
                    : const Icon(Icons.circle_outlined),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => Dialog(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Novo Lembrete',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormLembreteWidget(onSubmit: _handleSubmit),
                  ],
                ),
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
