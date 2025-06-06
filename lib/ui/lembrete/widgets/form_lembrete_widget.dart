import 'package:agora_vai/data/service/api/model/lembrete/lembrete_create.dart';
import 'package:flutter/material.dart';

class FormLembreteWidget extends StatefulWidget {
  final Function(CreateLembrete) onSubmit;

  const FormLembreteWidget({super.key, required this.onSubmit});

  @override
  State<FormLembreteWidget> createState() => _FormLembreteWidgetState();
}

class _FormLembreteWidgetState extends State<FormLembreteWidget> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  bool _isConcluida = false;

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final lembrete = CreateLembrete(
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        isConcluido: _isConcluida,
      );

      widget.onSubmit(lembrete);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _tituloController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira um título';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descricaoController,
              decoration: const InputDecoration(
                labelText: 'Descrição',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, insira uma descrição';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('Concluído'),
              value: _isConcluida,
              onChanged: (value) {
                setState(() {
                  _isConcluida = value;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: _submitForm, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}
