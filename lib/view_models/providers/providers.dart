
import 'package:flutter_base_architecture/resources/lang/app_language.dart';
import 'package:flutter_base_architecture/view_models/provider_view_models/post_view_model.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider<AppLanguage>(create: (_) => AppLanguage()),
  ChangeNotifierProvider<PostViewModel>(create: (_) => PostViewModel()),
];
