import 'package:agora_vai/config/dependecies/respository_dependecy.dart';
import 'package:agora_vai/config/dependecies/service_dependecy.dart';
import 'package:agora_vai/config/dependecies/viewmodel_dependecy.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ...serviceProviders,
  ...respositoryProviders,
  ...viewmodelProviders,
];
