import 'package:addcomments/comment/business%20logic/cubit/comment_cubit.dart';
import 'package:addcomments/comment/data/repo/comment_repo.dart';
import 'package:addcomments/comment/data/repo_impl/comment_repo_impl.dart';
import 'package:addcomments/comment/presentation/screens/home_screen.dart';
import 'package:addcomments/debug/app_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer=AppObserver();
  runApp(MultiRepositoryProvider(providers:[
    RepositoryProvider<CommentRepoImpl>(create: (context)=>CommentRepoImpl())
  ],child: const MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CommentCubit(context.read<CommentRepoImpl>()),
        ),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}