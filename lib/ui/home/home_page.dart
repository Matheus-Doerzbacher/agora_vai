import 'package:agora_vai/routing/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  // Controller TabController

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
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
            tabs: <Widget>[
              Tab(icon: Icon(Icons.task_alt), child: Text('Lembretes')),
              Tab(
                icon: Icon(Icons.calendar_month_outlined),
                child: Text('Compromissos'),
              ),
            ],
          ),
        ),
        body: const TabBarView(
          // children: <Widget>[LembretePage(), CompromissoPage()],
          children: [
            Center(child: Text('Lembretes')),
            Center(child: Text('Compromissos')),
          ],
        ),
      ),
    );
  }
}
