// // //
// // // // // import 'package:flutter/material.dart';
// // // // // import 'package:firebase_core/firebase_core.dart';
// // // // // import 'myprojcet/screen/splash1_screen.dart';
// // // // //
// // // // // void main() async {
// // // // //   WidgetsFlutterBinding.ensureInitialized();
// // // // //   await Firebase.initializeApp();
// // // // //   runApp(MyApp());
// // // // // }
// // // // //
// // // // // class MyApp extends StatelessWidget {
// // // // //   @override
// // // // //   Widget build(BuildContext context) {
// // // // //     return MaterialApp(
// // // // //
// // // // //         debugShowCheckedModeBanner: false,
// // // // //         title: 'Flutter Demo',
// // // // //         theme: ThemeData(
// // // // //           primarySwatch: Colors.blue,
// // // // //         ),
// // // // //      //  home:NewsSearch(),
// // // // //         home:Splash1Screen(),
// // // // //
// // // // //
// // // // //     );
// // // // //   }
// // // // // }
// // // // //
// // // // // // import 'package:authenthication/task_news_app/screen_app/news_service_class.dart';
// // // // // // import 'package:authenthication/task_news_app/screen_app/search_screen.dart';
// // // // // // import 'package:flutter/material.dart';
// // // // // // import 'package:provider/provider.dart';
// // // // // //
// // // // // // void main() {
// // // // // //   runApp(
// // // // // //     MultiProvider(
// // // // // //       providers: [
// // // // // //         ChangeNotifierProvider(create: (_) => NewsProvider()),
// // // // // //       ],
// // // // // //       child: const MyApp(),
// // // // // //     ),
// // // // // //   );
// // // // // // }
// // // // // //
// // // // // // class MyApp extends StatelessWidget {
// // // // // //   const MyApp({super.key});
// // // // // //
// // // // // //   @override
// // // // // //   Widget build(BuildContext context) {
// // // // // //     return const MaterialApp(
// // // // // //       debugShowCheckedModeBanner: false,
// // // // // //       home: NewsSearchView(),
// // // // // //     );
// // // // // //   }
// // // // // // }
// // // //
// // // // import 'package:authenthication/todolist/add_details.dart';
// // // // import 'package:authenthication/todolist/add_provider.dart';
// // // // import 'package:authenthication/todolist/add_task.dart';
// // // // import 'package:flutter/material.dart';
// // // // import 'package:provider/provider.dart';
// // // //
// // // // import 'firestore/users/home_screen.dart';
// // // //
// // // //
// // // // void main() {
// // // //   runApp(MyApp());
// // // // }
// // // //
// // // // class MyApp extends StatelessWidget {
// // // //   @override
// // // //   Widget build(BuildContext context) {
// // // //     return ChangeNotifierProvider(
// // // //
// // // //       create: (context) => TaskProvider(),
// // // //       child: MaterialApp(
// // // //         debugShowCheckedModeBanner: false,
// // // //         title: 'Enhanced Todo List',
// // // //         theme: ThemeData(
// // // //           primarySwatch: Colors.blue,
// // // //         ),
// // // //         home: AddTaskScreen(),
// // // //       ),
// // // //     );
// // // //   }
// // // // }
// // //
// // //
// // // import 'package:authenthication/todolist/task_list_screen.dart';
// // // import 'package:flutter/material.dart';
// // //
// // // void main() {
// // //   runApp(const MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return const MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       title: 'Task Manager',
// // //       home: TaskListScreen(),
// // //     );
// // //   }
// // // }
// // import 'package:flutter/material.dart';
// // import 'package:firebase_core/firebase_core.dart';
// // import 'instagram_project/insta_login_screen.dart';
// // import 'instagram_project/insta_registration_screen.dart';
// // import 'instagram_project/insta_slpash_screen.dart';
// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         primarySwatch: Colors.blue,
// //       ),
// //       initialRoute: '/',
// //       routes: {
// //         '/': (context) => InstaSplashScreen(),
// //         '/login': (context) =>IstaLoginScreen(),
// //         '/signup': (context) =>  SignUpRegisterScreen(),
// //       },
// //     );
// //   }
// // }
import 'package:authenthication/instagram_project/authInsta/instalogin_insta.dart';
import 'package:authenthication/instagram_project/authInsta/insta_register_insta.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'instagram_project/controllers/insta_auth_controller.dart';
import 'instagram_project/splashs/insta_splash.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(InstaAuthController());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: InstaSplashScreen(),
      getPages: [
        GetPage(name: '/register', page: () => InstaRegistrationScreen()),
        GetPage(name: '/login', page: () => InstaLoginScreen()),
      ],
    );
  }
}