import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
  Icon getVotedIcon(String voteType) {
    switch (voteType) {
      case 'post_upvoted':
        return const Icon(
          Icons.arrow_upward,
          color: Colors.green,
        );
      case 'post_unupvoted':
        return const Icon(
          Icons.remove,
          color: Colors.green,
        );
      case 'post_downvoted':
        return const Icon(
          Icons.arrow_downward,
          color: Colors.red,
        );
      case 'post_undownvoted':
        return const Icon(
          Icons.remove,
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
        return 'Unup voted';
      case 'post_downvoted':
        return 'Down voted';
      case 'post_undownvoted':
        return 'Undown voted';
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