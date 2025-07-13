import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/domain/bloc/blocs.dart';
import 'package:restaurant/domain/models/response/response_login.dart';
import 'package:restaurant/domain/services/auth_Services.dart';
import 'package:mockito/mockito.dart';

class MockAuthServices extends Mock implements AuthServices {}

void main() {
  group('AuthBloc', () {
    AuthBloc authBloc;
    MockAuthServices mockAuthServices;

    setUp(() {
      mockAuthServices = MockAuthServices();
      authBloc = AuthBloc();
    });

    test('initial state is correct', () {
      expect(authBloc.state, AuthState());
    });

    test('login success', () {
      final responseLogin = ResponseLogin(resp: true, user: User(uid: '1', rolId: '3'));
      when(mockAuthServices.loginController(any, any))
          .thenAnswer((_) async => responseLogin);

      authBloc.add(LoginEvent('test@test.com', 'password'));

      expectLater(
        authBloc,
        emitsInOrder([
          isA<LoadingAuthState>(),
          isA<AuthState>().having((state) => state.isSuccess, 'isSuccess', true),
        ]),
      );
    });

    test('login failure', () {
      final responseLogin = ResponseLogin(resp: false, msg: 'Error');
      when(mockAuthServices.loginController(any, any))
          .thenAnswer((_) async => responseLogin);

      authBloc.add(LoginEvent('test@test.com', 'password'));

      expectLater(
        authBloc,
        emitsInOrder([
          isA<LoadingAuthState>(),
          isA<FailureAuthState>(),
        ]),
      );
    });
  });
}
