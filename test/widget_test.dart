import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/main.dart';
import 'package:restaurant/presentation/screens/client/client_home_screen.dart';
import 'package:restaurant/presentation/screens/store_owner/store_owner_home_screen.dart';
import 'package:restaurant/presentation/screens/wholesaler/wholesaler_home_screen.dart';
import 'package:restaurant/presentation/screens/delivery_agent/delivery_agent_home_screen.dart';
import 'package:restaurant/presentation/screens/super_admin/super_admin_home_screen.dart';

void main() {
  testWidgets('Client home screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: ClientHomeScreen()));
    expect(find.text('What do you want eat today?'), findsOneWidget);
  });

  testWidgets('Store owner home screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: StoreOwnerHomeScreen()));
    expect(find.text('Welcome, Store Owner!'), findsOneWidget);
  });

  testWidgets('Wholesaler home screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: WholesalerHomeScreen()));
    expect(find.text('Welcome, Wholesaler!'), findsOneWidget);
  });

  testWidgets('Delivery agent home screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: DeliveryAgentHomeScreen()));
    expect(find.text('Welcome, Delivery Agent!'), findsOneWidget);
  });

  testWidgets('Super admin home screen test', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: SuperAdminHomeScreen()));
    expect(find.text('Welcome, Super Admin!'), findsOneWidget);
  });
}
