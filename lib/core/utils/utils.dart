import 'package:flutter/material.dart';

mixin RetipUtils {
  static RichText getQueryText(
      BuildContext context, String title, String query) {
    final startIndex = title.toLowerCase().indexOf(query.toLowerCase());
    final endIndex = startIndex + query.length;
    final boldText = title.substring(startIndex, endIndex);

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: [
          if (startIndex > 0) ...[
            TextSpan(text: title.substring(0, startIndex)),
          ],
          TextSpan(
            text: boldText,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          TextSpan(text: title.substring(endIndex)),
        ],
      ),
    );
  }
}
