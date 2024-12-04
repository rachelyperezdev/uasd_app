import 'package:url_launcher/url_launcher.dart';

// Función encargada de redirigir a la url especificada
import 'package:flutter/material.dart';

void openUrl(BuildContext context, String url) async {
  if (!url.startsWith('http://') && !url.startsWith('https://')) {
    url = 'https://$url';
  }

  Uri uri = Uri.parse(url);

  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('No se pudo abrir $url'),
        backgroundColor: Colors.red,
      ),
    );
  }
}
