import 'package:agora_vai/routing/routes.dart';
import 'package:agora_vai/ui/compromisso/compromisso_page.dart';
import 'package:agora_vai/ui/compromisso/compromisso_viewmodel.dart';
import 'package:agora_vai/ui/lembrete/lembrete_page.dart';
import 'package:agora_vai/ui/lembrete/lembrete_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  // Controller TabController

  @override
  Widget build(BuildContext context) {
    final lembreteViewModel = context.read<LembreteViewModel>();
    final compromissoViewModel = context.read<CompromissoViewModel>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Agenda VWM'),
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                context.push(Routes.user);
              },
            ),
          ],
          bottom: const TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorPadding: EdgeInsets.symmetric(horizontal: 16),
            tabs: <Widget>[
              Tab(icon: Icon(Icons.task_alt), child: Text('Lembretes')),
              Tab(
                icon: Icon(Icons.calendar_month_outlined),
                child: Text('Compromissos'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          // children: <Widget>[LembretePage(), CompromissoPage()],
          children: [
            LembretePage(viewModel: lembreteViewModel),
            CompromissoPage(viewModel: compromissoViewModel),
          ],
        ),
      ),
    );
  }
}
