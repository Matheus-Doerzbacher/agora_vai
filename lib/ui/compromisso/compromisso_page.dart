import 'package:agora_vai/data/service/api/model/compromisso/compromisso_created.dart';
import 'package:agora_vai/ui/compromisso/compromisso_viewmodel.dart';
import 'package:agora_vai/ui/compromisso/widgets/form_compromisso_widget.dart';
import 'package:flutter/material.dart';

class CompromissoPage extends StatefulWidget {
  final CompromissoViewModel viewModel;
  const CompromissoPage({super.key, required this.viewModel});

  @override
  State<CompromissoPage> createState() => _CompromissoPageState();
}

class _CompromissoPageState extends State<CompromissoPage> {
  void _handleSubmit(CompromissoCreated compromisso) {
    widget.viewModel.createCompromisso.execute(compromisso);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(const SnackBar(content: Text('Compromisso criado')));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListenableBuilder(
        listenable: Listenable.merge([
          widget.viewModel,
          widget.viewModel.getCompromissos,
        ]),
        builder: (context, _) {
          if (widget.viewModel.getCompromissos.isRunning) {
            return const Center(child: CircularProgressIndicator());
          }

          if (widget.viewModel.compromissos.isEmpty) {
            return const Center(child: Text('Nenhum compromisso encontrado'));
          }

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
              itemCount: widget.viewModel.compromissos.length,
              itemBuilder: (context, index) {
                final compromisso = widget.viewModel.compromissos[index];
                return Dismissible(
                  key: Key(compromisso.idCompromisso.toString()),
                  background: Card(
                    child: Container(
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.red,
                      ),
                      child: const Row(
                        children: [
                          SizedBox(width: 16),
                          Icon(Icons.delete, color: Colors.white),
                          Text(
                            'Deletar',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  direction: DismissDirection.startToEnd,
                  onDismissed: (direction) {
                    widget.viewModel.deleteCompromisso.execute(
                      compromisso.idCompromisso,
                    );
                    ScaffoldMessenger.of(context)
                      ..hideCurrentSnackBar()
                      ..showSnackBar(
                        const SnackBar(content: Text('Compromisso deletado')),
                      );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(compromisso.titulo),
                      subtitle: Text(compromisso.descricao),
                      trailing: Container(
                        width: 120,
                        alignment: Alignment.centerRight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${compromisso.dataHoraInicio.day}/${compromisso.dataHoraInicio.month}/${compromisso.dataHoraInicio.year} ${compromisso.dataHoraInicio.hour}:${compromisso.dataHoraInicio.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(fontSize: 14),
                            ),
                            Text(
                              '${compromisso.dataHoraFim.day}/${compromisso.dataHoraFim.month}/${compromisso.dataHoraFim.year} ${compromisso.dataHoraFim.hour}:${compromisso.dataHoraFim.minute.toString().padLeft(2, '0')}',
                              style: const TextStyle(fontSize: 14),
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
                      'Novo Compromisso',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FormCompromissoWidget(onSubmit: _handleSubmit),
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
