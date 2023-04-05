import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:post_app/core/utils/extended_string.dart';
import 'package:post_app/features/settings/presentation/cubits/localization/localization_cubit.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  Map<String, dynamic> languages = {'ar': 'العربية', 'en': 'English'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr(context)),centerTitle: true,),
      body: Column(
        children: [
          BlocBuilder<LocalizationCubit,LocalizationState>(
            builder: (context, state) {
              if(state is ChangeLocalState){          
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  String mapKey=languages.keys.toList()[index];
                  return ListTile(
                  
                    selected: state.locale.languageCode == mapKey,
                    onTap: (() {
                        BlocProvider.of<LocalizationCubit>(context)
                            .changeLanguage(mapKey);
                    }),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        
                        Text("${index + 1}"),
                        Text(languages[mapKey]),
                        
                        
                      ],
                    ),
                  );
                },
                itemCount: languages.keys.length,
              ); 
              }
              else{
               return Container();
              }
            },
          ),
        ],
      ),
    );
  }
}
