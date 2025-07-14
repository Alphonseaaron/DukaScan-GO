import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dukascan_go/domain/bloc/blocs.dart';
import 'package:dukascan_go/presentation/screens/client/client_home_screen.dart';
import 'package:dukascan_go/presentation/screens/home/select_role_screen.dart';
import 'package:dukascan_go/presentation/screens/login/login_screen.dart';
import 'package:dukascan_go/presentation/themes/colors_frave.dart';
import 'package:dukascan_go/presentation/screens/client/guest_access_screen.dart';

class CheckingLoginScreen extends StatefulWidget {
  @override
  _CheckingLoginScreenState createState() => _CheckingLoginScreenState();
}

class _CheckingLoginScreenState extends State<CheckingLoginScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_animationController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              _animationController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              _animationController.forward();
            }
          });
    _animationController.forward();
    BlocProvider.of<AuthBloc>(context).add(CheckLoginEvent());
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userBloc = BlocProvider.of<UserBloc>(context);
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is LoggedState) {
          userBloc.add(OnGetUserEvent(state.user!));
          if (state.user!.rolId == '1' || state.user!.rolId == '3') {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) => SelectRoleScreen()), (route) => false);
          } else if (state.user!.rolId == '2') {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => ClientHomeScreen()),
                (route) => false);
          }
        } else if (state is LogOutState) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
        }
      },
      child: Scaffold(
        backgroundColor: ColorsFrave.primaryColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) => Transform.scale(
                  scale: _scaleAnimation.value,
                  child: SizedBox(
                    height: 200,
                    width: 200,
                    child: Image.asset('Assets/Logo/logo-white.png'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GuestAccessScreen(),
                  ),
                );
              },
              child: Text('Continue as Guest'),
            ),
          ],
        ),
      ),
    );
  }
}