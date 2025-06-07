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
  DateTime? _dataHora;
  bool _adicionarAlerta = false;

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_adicionarAlerta && _dataHora == null) {
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(
            backgroundColor: Colors.red,
            content: Text('Por favor, selecione uma data e hora'),
          ),
        );
      return;
    }
    if (_formKey.currentState!.validate()) {
      final lembrete = CreateLembrete(
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        dataHora: _dataHora,
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
              title: const Text('Adicionar Alerta'),
              value: _adicionarAlerta,
              onChanged: (value) {
                setState(() {
                  _adicionarAlerta = value;
                });
              },
            ),
            const SizedBox(height: 16),
            if (_adicionarAlerta) ...[
              ElevatedButton(
                onPressed: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2026),
                  );
                  if (pickedDate != null) {
                    final pickedTime = await showTimePicker(
                      // ignore: use_build_context_synchronously
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (pickedTime != null) {
                      setState(() {
                        _dataHora = DateTime(
                          pickedDate.year,
                          pickedDate.month,
                          pickedDate.day,
                          pickedTime.hour,
                          pickedTime.minute,
                        );
                      });
                    }
                  }
                },
                child: Text(
                  _dataHora == null
                      ? 'Selecionar Data e Hora'
                      : 'Data e Hora: ${_dataHora!.day}/${_dataHora!.month}/${_dataHora!.year} ${_dataHora!.hour}:${_dataHora!.minute.toString().padLeft(2, '0')}',
                ),
              ),
              const SizedBox(height: 16),
            ],
            ElevatedButton(onPressed: _submitForm, child: const Text('Salvar')),
          ],
        ),
      ),
    );
  }
}
