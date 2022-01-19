import 'package:blush_delivery/services/auth_service/auth_service.dart';
import 'package:blush_delivery/views/login_view/login_bloc/login_bloc.dart';
import 'package:blush_delivery/views/login_view/login_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

part 'app_routes.dart';

final kRouter = GoRouter(
  initialLocation: kLoginRoute,
  routes: <GoRoute>[
    GoRoute(
      path: kLoginRoute,
      builder: (context, state) => BlocProvider<LoginBloc>(
        create: (ctx) => LoginBloc(authService: AuthService()),
        child: const LoginView(),
      ),
    )
  ],
  debugLogDiagnostics: true,
);
