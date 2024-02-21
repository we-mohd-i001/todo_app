import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/application/app/basic_app.dart';

void main() {
  testWidgets('Todo App smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const BasicApp());

    expect(find.text('1'), findsNothing);
  });
}
