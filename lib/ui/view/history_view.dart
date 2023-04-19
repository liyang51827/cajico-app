import 'package:cached_network_image/cached_network_image.dart';
import 'package:cajico_app/ui/common/app_color.dart';
import 'package:cajico_app/ui/widget/footer.dart';
import 'package:cajico_app/ui/widget/header.dart';
import 'package:cajico_app/ui/widget/home_drawer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import '../../model/point_history.dart';
import '../common/ui_helper.dart';
import '../controller/history_view_controller.dart';
import '../widget/background.dart';
import '../widget/cajico_cashed_network_image.dart';
import '../widget/loading_stack.dart';
import '../widget/next_page_button.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.replace(HistoryViewController());
    return Obx(() {
      final controller = Get.put(HistoryViewController());
      final totalPointHistory = controller.totalPointHistory();
      final int totalCurrentPage = controller.totalCurrentPage();

      return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(55),
            child: Header(
              imageUrl: 'assets/images/logo_history.png',
              title: '家事履歴',
            )),
        drawer: const HomeDrawer(),
        body: Background(
          child: GetLoadingStack<HistoryViewController>(
            child: RefreshIndicator(
              color: primaryColor,
              onRefresh: controller.fetchData,
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: totalPointHistory != null
                    ? Column(
                        children: [
                          verticalSpaceMediumLarge,
                          GroupedListView<Point, String>(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            elements: controller.totalPointHistories(),
                            groupBy: (element) => element.date,
                            sort: false,
                            itemBuilder: (context, element) {
                              return _HouseWorkDetail(
                                pointHistoryId: element.pointHistoryId,
                                categoryImageUrl: element.houseWorkCategoryImageUrl,
                                categoryName: element.houseWorkCategoryName,
                                houseWorkName: element.houseWorkName,
                                userIconImageUrl: element.iconUrl ??
                                    'https://cazico-public.s3.ap-northeast-1.amazonaws.com/user_icon/icon_1.png',
                                time: element.time,
                                point: element.point,
                                isMe: element.isMe,
                              );
                            },
                            groupSeparatorBuilder: (date) {
                              return Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(date, style: const TextStyle(color: gray2)));
                            },
                          ),
                          totalCurrentPage < totalPointHistory.lastPage
                              ? NextPageButton(
                                  onPressed: () =>
                                      controller.onTapNextTotalPage(page: totalCurrentPage))
                              : const SizedBox(),
                        ],
                      )
                    : const SizedBox(),
              ),
            ),
          ),
        ),
        bottomNavigationBar: const Footer(),
      );
    });
  }
}

class _HouseWorkDetail extends GetView<HistoryViewController> {
  const _HouseWorkDetail({
    required this.pointHistoryId,
    required this.categoryImageUrl,
    required this.categoryName,
    required this.houseWorkName,
    required this.userIconImageUrl,
    required this.time,
    required this.point,
    required this.isMe,
  });

  final int pointHistoryId;
  final String categoryImageUrl;
  final String categoryName;
  final String houseWorkName;
  final String userIconImageUrl;
  final String time;
  final int point;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(HistoryViewController());
    return InkWell(
      onTap: () => controller.onTapDeleteDialog(
        isMe: isMe,
        houseWorkName: houseWorkName,
        categoryName: categoryName,
        pointHistoryId: pointHistoryId,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Row(
          children: [
            SizedBox(width: 60, child: CajicoCachedNetworkImage(imageUrl: categoryImageUrl)),
            horizontalSpaceTiny,
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(categoryName, style: const TextStyle(fontSize: 12)),
                          verticalSpaceTiny,
                          Text(
                            houseWorkName,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          CajicoCachedNetworkIconImage(imageUrl: userIconImageUrl, radius: 15),
                          horizontalSpaceTiny,
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(time, style: const TextStyle(fontSize: 16)),
                              Text(
                                "${point}P",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: point < 25
                                      ? lowColor
                                      : point < 50
                                          ? middleColor
                                          : point < 75
                                              ? secondaryColor
                                              : point < 100
                                                  ? primaryColor
                                                  : highestColor,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  verticalSpaceTiny,
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                        decoration: BoxDecoration(
                          color: selectedColor,
                          border: Border.all(color: lowColor, width: 1, style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://cazico-public.s3.ap-northeast-1.amazonaws.com/emoji/thinking.png',
                              imageBuilder: (context, imageProvider) {
                                return CircleAvatar(radius: 8, backgroundImage: imageProvider);
                              },
                            ),
                            horizontalSpaceTiny,
                            Text('1')
                          ],
                        ),
                      ),
                      horizontalSpaceTiny,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                        decoration: BoxDecoration(
                          color: gray6,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl:
                                  'https://cazico-public.s3.ap-northeast-1.amazonaws.com/emoji/love.png',
                              imageBuilder: (context, imageProvider) {
                                return CircleAvatar(radius: 8, backgroundImage: imageProvider);
                              },
                            ),
                            horizontalSpaceTiny,
                            Text('1')
                          ],
                        ),
                      ),
                      horizontalSpaceTiny,
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
                        decoration: BoxDecoration(
                          color: gray6,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.add_reaction_outlined,
                          color: gray3,
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  verticalSpaceSmall,
                  const Divider(color: gray4, height: 1),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
