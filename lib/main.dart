import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:post_app/core/localization/app_localization.dart';
import 'package:post_app/core/cache/cache_helper.dart';

import 'package:post_app/features/posts/presntation/blocs/posts/posts_bloc.dart';

import 'package:post_app/features/posts/presntation/pages/posts_page.dart';
import 'package:post_app/features/settings/presentation/cubits/localization/localization_cubit.dart';
import 'package:post_app/ingection_container.dart' as ic;

import 'features/posts/presntation/blocs/comment/comment_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await ic.init();
  await CacheHelper.init();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => ic.sl<PostsBloc>(), lazy: true),
      BlocProvider(
        create: (context) => ic.sl<CommentBloc>(),
      ),
      BlocProvider(
          create: (context) => ic.sl<LocalizationCubit>()..getSavedLanguage()),
    ],
    child: BlocBuilder<LocalizationCubit, LocalizationState>(
      builder: (context, state) {
        if (state is ChangeLocalState) {
          return MaterialApp(
            locale: state.locale,
            debugShowCheckedModeBanner: false,
            home: const PostsPage(),
            supportedLocales: const [
              Locale('en', ""),
              Locale("ar", ""),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (currentLocal, supportedLocales) {
              for (var locale in supportedLocales) {
                if (currentLocal != null &&
                    currentLocal.languageCode == locale.languageCode) {
                  return currentLocal;
                }
              }
              return supportedLocales.first;
            },
          );
        }
        return Container();
      },
    ),
  ));
}
