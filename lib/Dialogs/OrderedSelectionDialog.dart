import 'package:mechily/AppStyle.dart';
import 'package:mechily/Components/OrderSelectionBar.dart';
import 'package:mechily/Components/OrderedSelectionController.dart';
import 'package:mechily/Misc/classes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderedSelectionDialog<T extends GetxController> extends StatelessWidget {
  final List<OrderedSelectionMember> listOfChoices;
  final String getBuilderId;
  final Counter selectionCount;
  final ScrollController scrollController = ScrollController();

  OrderedSelectionDialog({
    Key key,
    this.listOfChoices,
    this.getBuilderId,
    this.selectionCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: screenHeight * 0.8),
      child: Container(
        width: screenWidth * 0.85,
        padding: EdgeInsets.only(bottom: 32),
        child: GetBuilder<T>(
          id: getBuilderId,
          builder: (_) {
            return Scrollbar(
              isAlwaysShown: true,
              controller: scrollController,
              child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.symmetric(horizontal: 16),
                shrinkWrap: true,
                itemCount: listOfChoices.length,
                itemBuilder: (context, index) {
                  OrderedSelectionMember daChoice = listOfChoices[index];
                  return Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: OrderSelectionBar(
                      color: shiro,
                      selectionMember: daChoice,
                      onEnabled: () {
                        selectionCount?.increment();
                      },
                      onDisabled: () {
                        selectionCount?.decrement();
                      },
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
