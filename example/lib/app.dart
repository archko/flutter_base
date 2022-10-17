// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_base/widget/appbar/title_bar.dart';
// import 'package:flutter_base_example/page/home_tabs_page.dart';
// import 'package:flutter_base_example/page/movie_list_page.dart';
// import 'package:flutter_base_example/page/test.dart';
//
// Widget createApp() {
//   return StateDemoApp();
// }
//
// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       home: StateDemoApp(),
//     );
//   }
// }
//
// class StateDemoApp extends StatefulWidget {
//   const StateDemoApp({
//     Key? key,
//   }) : super(key: key);
//
//   @override
//   _StateDemoAppState createState() => _StateDemoAppState();
// }
//
// class _StateDemoAppState extends State<StateDemoApp> {
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: Scaffold(
//         appBar: TitleBar.simpleTitleBar("test"),
//         body: Container(
//           margin: EdgeInsets.all(10),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute<void>(
//                       builder: (_) {
//                         return HomeTabsPage();
//                       },
//                     ),
//                   );
//                 },
//                 child: Text("HomeTabsPage"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute<void>(
//                       builder: (_) {
//                         return TestApp();
//                       },
//                     ),
//                   );
//                 },
//                 child: Text("TestApp"),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).push(
//                     MaterialPageRoute<void>(
//                       builder: (_) {
//                         return MaterialApp(
//                             theme: ThemeData(
//                               primarySwatch: Colors.green,
//                             ),
//                             home: Scaffold(
//                               appBar: TitleBar.simpleTitleBar("Movie list"),
//                               body: MovieListPage(),
//                             ));
//                       },
//                     ),
//                   );
//                 },
//                 child: Text("TestList"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
