import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sof_user/features/user_rep/data/user_rep_model.dart';
import 'package:sof_user/features/user_rep/presentation/widgets/user_rep_card.dart';
import 'package:sof_user/features/user_rep/presentation/widgets/user_rep_header.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';

class RepListView extends StatelessWidget {
  const RepListView(
      {super.key,
      required this.userRepScrollCtrl,
      required this.userRepHistory,
      required this.ref,
      required this.isLoading,
      required this.user});

  final ScrollController userRepScrollCtrl;
  final List<UserRep> userRepHistory;
  final WidgetRef ref;
  final bool isLoading;
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // padding: const EdgeInsets.all(6),
      controller: userRepScrollCtrl,
      itemCount: userRepHistory.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Stack(
            children: [
              ClipPath(
                clipper: BezierClipper(),
                child: Container(
                  color: Colors.deepOrange,
                  width: double.infinity,
                  height: 150,
                ),
              ),
              UserRepHeader(user: user, userRepHistory: userRepHistory),
            ],
          );
        }
        if (index != userRepHistory.length) {
          UserRep rep = userRepHistory[index];
          return UserRepCard(rep: rep);
        } else {
          return Container(
            height: 50,
            width: 50,
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: isLoading
                  ? const CircularProgressIndicator()
                  : const SizedBox(),
            ),
          );
        }
      },
    );
  }
}

class BezierClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height * 0.75);
    path.quadraticBezierTo(size.width * 0.25, size.height * 0.5,
        size.width * 0.5, size.height * 0.75);
    path.quadraticBezierTo(
        size.width * 0.75, size.height * 1, size.width, size.height * 0.75);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
