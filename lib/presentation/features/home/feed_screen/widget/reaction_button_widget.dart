
import 'package:flutter/material.dart';
import 'package:flutter_reaction_button/flutter_reaction_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shahin_appify_task/domain/model/feed/feed_response.dart';

import '../../../../../core/utils/utils.dart';
import '../../../../../data/network/models/network_request/create_delete_reaction_request.dart';
import '../../../../../domain/model/common/meta_data.dart';
import '../../../../../domain/model/feed/like.dart';
import '../../../../widgets/button/reactions.dart';
import '../feeds_screen_view_model.dart';



class ReactionButtonWidget extends ConsumerStatefulWidget {
  FeedResponse feedResponse;
   ReactionButtonWidget( {super.key,required this.feedResponse});



  @override
  ConsumerState<ReactionButtonWidget> createState() => _ReactionButtonWidgetState();
}

class _ReactionButtonWidgetState extends ConsumerState<ReactionButtonWidget> {
  Reaction<String>? selectedReaction;
  var selectedIndexReact;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    print("--------olala------------->");

    var like = widget.feedResponse.like?.reactionType ?? "";
    var selectedIndexReact = getSelectedIndex(like ?? "");


    if (selectedIndexReact > -1) {
      selectedReaction = reactions.elementAt(selectedIndexReact);
    } else {
      selectedReaction = null;
    }



    return ReactionButton<String>(
      itemSize: const Size.square(40),
      onReactionChanged: (Reaction<String>? reaction) {
        var value = reaction?.value;
        if (widget.feedResponse.like != null && widget.feedResponse.like?.reactionType != null && (value == null || Utils.equalsIgnoreCase(widget.feedResponse.like?.reactionType, value))) {
          value = widget.feedResponse.like?.reactionType;
          // widget.feedResponse.like == null;
        } else {
          value ??= widget.feedResponse.like?.reactionType;
          value ??= "Like";
          widget.feedResponse.like = Like(
              reactionType: value.toUpperCase(),
              id: 0,
              createdAt: DateTime.now(),
              feedId: widget.feedResponse.id,
              updatedAt: DateTime.now(),
              meta: MetaDataClass(json: {}),
              userId: widget.feedResponse.userId,
              isAnonymous: 0);

        }

          selectedReaction=reaction;


        ref.read(createOrDeleteReactionStateNotifierProvider.notifier).createOrDeleteReaction(
            CreateOrDeleteReactionRequest(feed_id: widget.feedResponse.id.toString(), action: "deleteOrCreate", reaction_type: value?.toUpperCase(), reactionSource: "COMMUNITY"));
      },
      reactions: reactions,
      isChecked: selectedReaction?.value!=null,
      selectedReaction: selectedReaction,
      placeholder: defaultInitiaCommentReaction,
    );
  }
}

