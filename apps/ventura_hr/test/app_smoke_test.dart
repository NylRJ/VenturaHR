import 'package:flutter_test/flutter_test.dart';
import 'package:ventura_hr/app.dart';

void main() {
  testWidgets('renders VenturaHR 2.0 home', (tester) async {
    await tester.pumpWidget(const VenturaHrApp());
    await tester.pumpAndSettle();

    expect(find.text('VenturaHR 2.0'), findsOneWidget);
    expect(find.text('Abrir demonstração do Match PMD'), findsOneWidget);
  });
}
