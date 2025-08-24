import 'package:flutter/foundation.dart';

void safePrint(Object? message) {
  if (kDebugMode) {
    print('=> - - - - - - SafePrint - - - - - - <=');
    print(message);
    print('=> - - - - - - SafePrint - - - - - - <=');
  }
}
