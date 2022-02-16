import 'package:mechily/Components/AnimatedDialog.dart';
import 'package:mechily/Pages/FoodScreen/fs_comment_dialog.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RatersController extends GetxController {
  static String commentCardGetID = "myCommentCard";
  static String ratersGetID = "ratersContainer";
  int enabledNb_0;
  int trueRating = 0;
  int starsNb;
  bool canPublish = false;
  bool hasRated = false;
  bool hasUpdatedRating = false;
  String comment;
  final Function onPublished, onDeleted;
  AnimatedRevealerController daCardRemote = AnimatedRevealerController();

  List<bool> stars = [];
  RatersController({
    trueRating = 0,
    this.starsNb = 5,
    hasRated = false,
    this.onPublished,
    this.onDeleted,
  }) : assert(trueRating <= starsNb) {
    this.trueRating = trueRating;
    this.enabledNb_0 = this.trueRating;
    this.hasRated = hasRated;
    for (var i = 0; i < starsNb; i++) {
      if (i < enabledNb_0)
        stars.add(true);
      else
        stars.add(false);
    }
  }

  Future openCommentDialog(daContext, {isChangingComment = false}) async {
    CommentDialogController commentController = new CommentDialogController();
    if (isChangingComment) commentController.textController.text = comment;
    await AnimatedDialog.show(
      child: FsCommentDialog(
        enabledNb_0: enabledNb_0 + 1,
        daController: commentController,
      ),
    );
    if (commentController.hasCommented) {
      comment = commentController.textController.text;
      doAfterPublishing();
      return true;
    } else
      return false;
  }

  void writeComment(daContext) {
    openCommentDialog(daContext);
  }

  void changeComment(BuildContext daContext) {
    print("changed");
    openCommentDialog(daContext, isChangingComment: true);
  }

  void deleteComment() {
    resetRaters();
    daCardRemote.hide().then((_) {
      onDeleted?.call();
    });
  }

  void resetRaters() {
    hasRated = false;
    hasUpdatedRating = false;
    canPublish = true;
    trueRating = 0;
    disableFromNb(0);
    update([RatersController.commentCardGetID]);
  }

  void refreshValues(int daNum) {
    enabledNb_0 = daNum;
    // if ((trueRating != enabledNb_0) && !canPublish)
    if (!canPublish) canPublish = true;

    if (enabledNb_0 == trueRating - 1) {
      if (hasUpdatedRating) hasUpdatedRating = false;
    } else if (!hasUpdatedRating && hasRated) hasUpdatedRating = true;

    update([RatersController.ratersGetID]);
    // update();
  }

  void doAfterPublishing() {
    canPublish = true;
    hasUpdatedRating = false;
    hasRated = true;
    trueRating = enabledNb_0 + 1;
    update([RatersController.ratersGetID, RatersController.commentCardGetID]);
    // update();
    onPublished?.call();
    daCardRemote.show();
    print("publishedd");
  }

  void doIfNotPublished() {
    print("has Not Published");
  }

  void enableToNb(int daNum) {
    print("en");
    for (var i = 0; i <= daNum; i++) {
      if (!stars[i]) stars[i] = true;
    }
    refreshValues(daNum);
  }

  void disableFromNb(int daNum) {
    print("dis");

    for (var i = daNum + 1; i < stars.length; i++) {
      if (stars[i]) stars[i] = false;
    }
    refreshValues(daNum);
  }
}
