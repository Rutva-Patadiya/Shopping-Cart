import 'package:flutter/widgets.dart';

import 'app_localizations.dart';

extension LocalizationContextExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this)!;
}
