
import 'package:flutter/material.dart';

import '../../../../core/utils/url_helper.dart';

class ReadMoreBar extends StatelessWidget {
  const ReadMoreBar({
    super.key,
    required this.url,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.fromLTRB(
        18,
        8,
        18,
        MediaQuery.of(context).padding.bottom > 0 ? 8 : 14,
      ),
      child: SizedBox(
        height: 46,
        child: FilledButton.icon(
          onPressed: () => UrlHelper.open(context, url),
          style: FilledButton.styleFrom(
            backgroundColor: const Color(0xFF171717),
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          icon: const Icon(
            Icons.open_in_new_rounded,
            size: 17,
          ),
          label: const Text(
            'Baca artikel lengkap',
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
