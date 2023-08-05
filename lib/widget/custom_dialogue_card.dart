import 'package:flutter/material.dart';

Future simpleDialogueCard({String? title, String? msg, BuildContext? context}) {
  return showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title!),
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 15.0),
              Expanded(child: Text(msg!, overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 10.0)
            ],
          ),
        );
      });
}

Future simpleDialogueCardSansTitle({String? msg, BuildContext? context}) {
  return showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(width: 15.0),
              Expanded(child: Text(msg!, overflow: TextOverflow.ellipsis)),
              const SizedBox(width: 10.0)
            ],
          ),
        );
      });
}

Future errorDialogueCard({String? title, String? msg, BuildContext? context}) {
  return showDialog(
      barrierDismissible: false,
      context: context!,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(msg!),
          actions: [
            ElevatedButton(
              child: const Text(
                "Ok",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 10.0)
          ],
        );
      });
}

customDialogue(BuildContext context, String title, String msg,
    {String? text, Function()? onPressed}) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(msg),
          actions: [
            TextButton(
              child: const Text("Annuler"),
              onPressed: () => Navigator.pop(context),
            ),
            const SizedBox(width: 10.0),
            ElevatedButton(
              onPressed: onPressed,
              child: Text(
                text ?? "Commencer",
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 10.0)
          ],
        );
      });
}
