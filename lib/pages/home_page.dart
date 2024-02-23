import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:treinamento1/cubits/treinamento1/treinamento1_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<Treinamento1Cubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
          actions: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: openCreateModal,
            ),
          ],
        ),
        body: BlocBuilder<Treinamento1Cubit, Treinamento1State>(
          builder: (context, state) {
            if (state.list.isEmpty) {
              return const Center(
                child: Text('Lista Vazia'),
              );
            }
            return ListView.builder(
                itemCount: state.list.length,
                itemBuilder: (_, index) {
                  final treinamento1 = state.list[index];
                  return ListTile(
                    title: Text(treinamento1.title),
                    subtitle: Text(treinamento1.description ?? ''),
                    leading: Checkbox(
                      value: treinamento1.isCheckd,
                      onChanged: (bool? value) {
                        context
                            .read<Treinamento1Cubit>()
                            .toggle(treinamento1.id);
                      },
                    ),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          context
                              .read<Treinamento1Cubit>()
                              .remove(treinamento1.id);
                        }),
                  );
                });
          },
        ));
  }

  void openCreateModal() {
    final titleCtrl = TextEditingController();
    final descriptionCtrl = TextEditingController();

    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: 240,
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.amber,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            children: [
              TextField(
                controller: titleCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: 16.0),
              TextField(
                controller: descriptionCtrl,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16.0),
              SizedBox(
                width: double.maxFinite,
                height: 40,
                child: ElevatedButton(
                  child: const Text('Create'),
                  onPressed: () {
                    context.read<Treinamento1Cubit>().add(
                          title: titleCtrl.text,
                          description: descriptionCtrl.text,
                        );
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
