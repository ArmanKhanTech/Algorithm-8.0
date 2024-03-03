import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:algorithm/viewmodels/auth/login_view_model.dart';
import 'package:algorithm/viewmodels/admin/register_view_model.dart';

List<SingleChildWidget> providers = [
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => RegisterViewModel()),
];
