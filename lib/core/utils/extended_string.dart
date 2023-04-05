import 'package:flutter/cupertino.dart';
import 'package:post_app/core/localization/app_localization.dart';

extension TranslateString on String{
  String tr(BuildContext context){
    return AppLocalizations.of(context)!.translate(this);
  }
}
