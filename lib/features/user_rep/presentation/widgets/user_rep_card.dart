import 'package:flutter/material.dart';
import 'package:sof_user/features/user_rep/data/user_rep_model.dart';
import 'package:sof_user/features/user_rep/presentation/widgets/helper_functions.dart';

class UserRepCard extends StatelessWidget {
  const UserRepCard({
    super.key,
    required this.rep,
  });

  final UserRep rep;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          height: 0,
        ),
        ListTile(
          dense: true,
          horizontalTitleGap: 0,
          leading: getVotedIcon(rep.repType),
          tileColor: Colors.white,
          title: Text(getVotedText(rep.repType)),
          subtitle: Text(rep.repChange.toString()),
          trailing: Text(getDateTime(rep.dateCreated)),
        ),
      ],
    );
  }
}