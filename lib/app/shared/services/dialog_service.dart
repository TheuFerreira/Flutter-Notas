import 'package:flutter/material.dart';

class DialogService {
  Future<dynamic> showAlertDialog(
    BuildContext context,
    String title,
    String description,
  ) async {
    return await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.warning,
                color: Theme.of(context).textTheme.bodyText1!.color,
              ),
              SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ],
          ),
          content: Text(description),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: Text(
                'Confirmar',
                style: TextStyle(
                  color: Theme.of(context).textTheme.bodyText1!.color,
                ),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(
                'Cancelar',
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                ),
              ),
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).textTheme.bodyText1!.color,
              ),
            ),
          ],
        );
      },
    );
  }
}
