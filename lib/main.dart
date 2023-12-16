import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/Expenses.dart';
// import 'package:flutter/services.dart';
void main() {
  /*Locking the device orientation
  * it works only in preferred style
  * in this case if we enable the below comments
  * it works only in portrait mode
  * */
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [
  //     DeviceOrientation.portraitUp,
  //   ],
  // ).then((fn) => {
  // runApp(const MyApp())
  //  }); closing of Lock
   runApp(const MyApp());
}
var kColorScheme = ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 96, 59, 181),
);
var darkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 50, 117, 155),);
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      darkTheme: ThemeData.dark().copyWith(useMaterial3: true,
      colorScheme: darkColorScheme,
      cardTheme: const  CardTheme().copyWith(
        color: darkColorScheme.secondaryContainer,
        margin: const  EdgeInsets.symmetric(
          horizontal: 16 ,
          vertical: 6,
        ),
      ),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: darkColorScheme.primaryContainer,
              foregroundColor: darkColorScheme.onPrimaryContainer,
            )
        ),
      ),
      theme: ThemeData().copyWith(useMaterial3: true,
        colorScheme: kColorScheme,
      appBarTheme: const AppBarTheme().copyWith(
        backgroundColor: kColorScheme.onPrimaryContainer,
        foregroundColor: kColorScheme.primaryContainer,
        centerTitle: true ,
      ),

        cardTheme: const  CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const  EdgeInsets.symmetric(
            horizontal: 16 ,
            vertical: 6,
          ),
        ) ,
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kColorScheme.primaryContainer,
            )
        ),
        textTheme: ThemeData().textTheme.copyWith(
          titleLarge:  TextStyle(
            fontWeight: FontWeight.bold,
            color: kColorScheme.onSurface,
            fontSize: 18,
          ),
        ),
      ),
      // themeMode: ,
      home: const Expenses(),
    );
  }
}

