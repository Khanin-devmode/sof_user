import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sof_user/features/user_rep/data/user_rep_model.dart';
import 'package:sof_user/features/user_rep/domain/user_rep_state.dart';
import 'package:sof_user/features/users_list/data/user_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

class UserRepPage extends ConsumerStatefulWidget {
  const UserRepPage({super.key, required this.user});

  final UserModel user;

  @override
  UserRepState createState() => UserRepState(user: user);
}

class UserRepState extends ConsumerState<UserRepPage> {
  UserRepState({required this.user});

  final UserModel user;

  ScrollController userRepScrollCtrl = ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    ref
        .read(userRepNotifierProvider.notifier)
        .getUserRepHistory(user.userId, 1, () {});

    userRepScrollCtrl.addListener(
      () {
        int pageToLoad = ref.read(repPageToLoadNumber);
        var currentPosition = userRepScrollCtrl.position.pixels;
        var maxPosition = userRepScrollCtrl.position.maxScrollExtent;
        if ((currentPosition == maxPosition) && !isLoading) {
          setState(() => isLoading = true);
          ref.read(userRepNotifierProvider.notifier).getUserRepHistory(
            user.userId,
            pageToLoad,
            () {
              ref
                  .read(repPageToLoadNumber.notifier)
                  .update((state) => state + 1);
              setState(() => isLoading = false);
            },
          );
        }
      },
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userRepHistory = ref.watch(userRepNotifierProvider);

    return LoaderOverlay(
      child: Scaffold(
          backgroundColor: Colors.grey[200],
          appBar: AppBar(
            title: Text(user.displayName),
          ),
          body: UserRepColumnWidget(
              user: user,
              userRepScrollCtrl: userRepScrollCtrl,
              userRepHistory: userRepHistory,
              ref: ref,
              isLoading: isLoading)),
    );
  }
}

class UserRepColumnWidget extends StatelessWidget {
  const UserRepColumnWidget(
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
      padding: const EdgeInsets.all(6),
      controller: userRepScrollCtrl,
      itemCount: userRepHistory.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return Column(
            children: [
              Center(
                child: ClipOval(
                  child: CachedNetworkImage(
                    height: 160,
                    width: 160,
                    imageUrl: user.imgUrl,
                    placeholder: (context, url) => const Icon(
                      Icons.face,
                      size: 36,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: const [
                  Text('Repuation History'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              if (userRepHistory.isEmpty) const CircularProgressIndicator()
            ],
          );
        }
        if (index != userRepHistory.length) {
          UserRep rep = userRepHistory[index];
          return ListTile(
            dense: true,
            horizontalTitleGap: 0,
            leading: getVotedIcon(rep.repType),
            tileColor: Colors.white,
            title: Text(getVotedText(rep.repType)),
            subtitle: Text('${rep.repChange.toString()}'),
            trailing: Text(getDateTime(rep.dateCreated)),
          );
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

  Icon getVotedIcon(String voteType) {
    switch (voteType) {
      case 'post_upvoted':
        return const Icon(
          Icons.arrow_upward,
          color: Colors.green,
        );
      case 'post_unupvoted':
        return const Icon(
          Icons.arrow_downward,
          color: Colors.red,
        );
      case 'user_deleted':
        return const Icon(Icons.close);
      case 'answer_accepted':
        return const Icon(
          Icons.check,
          color: Colors.green,
        );

      default:
        return const Icon(Icons.remove);
    }
  }

  String getVotedText(String voteType) {
    switch (voteType) {
      case 'post_upvoted':
        return 'Up voted';
      case 'post_unupvoted':
        return 'Down voted';
      case 'user_deleted':
        return 'Deleted';
      case 'answer_accepted':
        return 'Accepted';

      default:
        return 'Vote';
    }
  }

  String getDateTime(int datetime) {
    var votedTime =
        DateTime.fromMillisecondsSinceEpoch(datetime * 1000).toLocal();

    return DateFormat('MMM d, yyyy').format(votedTime).toString();
  }
}
