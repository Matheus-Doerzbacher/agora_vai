import 'package:agora_vai/data/service/api/model/compromisso/compromisso_created.dart';
import 'package:flutter/material.dart';

class FormCompromissoWidget extends StatefulWidget {
  final Function(CompromissoCreated) onSubmit;

  const FormCompromissoWidget({super.key, required this.onSubmit});

  @override
  State<FormCompromissoWidget> createState() => _FormCompromissoWidgetState();
}

class _FormCompromissoWidgetState extends State<FormCompromissoWidget> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();
  DateTime? _dataHoraInicio;
  DateTime? _dataHoraFim;
  final _localController = TextEditingController();

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    _localController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_dataHoraInicio == null || _dataHoraFim == null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Erro'),
            content: const Text('Data e hora de início e fim são obrigatórias'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
        return;
      }

      final compromisso = CompromissoCreated(
        titulo: _tituloController.text,
        descricao: _descricaoController.text,
        dataHoraInicio: _dataHoraInicio!,
        dataHoraFim: _dataHoraFim!,
        local: _localController.text,
      );

      widget.onSubmit(compromisso);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
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
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
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
                          _dataHoraInicio = DateTime(
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
                    _dataHoraInicio == null
                        ? 'Data e Hora de Início'
                        : 'Início: ${_dataHoraInicio!.day}/${_dataHoraInicio!.month}/${_dataHoraInicio!.year} ${_dataHoraInicio!.hour}:${_dataHoraInicio!.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    final pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
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
                          _dataHoraFim = DateTime(
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
                    _dataHoraFim == null
                        ? 'Data e Hora de Término'
                        : 'Término: ${_dataHoraFim!.day}/${_dataHoraFim!.month}/${_dataHoraFim!.year} ${_dataHoraFim!.hour}:${_dataHoraFim!.minute.toString().padLeft(2, '0')}',
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _localController,
                decoration: const InputDecoration(
                  labelText: 'Local',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira um local';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              FilledButton(onPressed: _submitForm, child: const Text('Salvar')),
            ],
          ),
        ),
      ),
    );
  }
}
