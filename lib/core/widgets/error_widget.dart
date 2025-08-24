import 'package:flutter/material.dart';
import 'package:what_s_up_app/core/extensions/ext.dart';
import 'package:what_s_up_app/core/theme/styles.dart';

class AppErrorWidget extends StatelessWidget {
  const AppErrorWidget({super.key, required this.errorText});
final String errorText;
  @override  
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          10.hSpace,
          Icon(Icons.error_outline_rounded,color: Colors.red,
          size: 50,
          ),
          10.hSpace,
          Text(errorText,style: font16w700.copyWith(
            color: Colors.red,

          ),),

        ],
      ),
    );
  }
}
