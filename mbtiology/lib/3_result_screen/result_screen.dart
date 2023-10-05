import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mbtiology/1_home_screen/home_screen.dart';
import 'package:mbtiology/common/common_value.dart';
import 'package:mbtiology/common/default_layout.dart';
import 'package:mbtiology/3_result_screen/mbti.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class ResultScreen extends StatefulWidget {
  final String name;
  final String type;
  final String predictType;

  const ResultScreen({
    required this.name,
    required this.type,
    required this.predictType,
    super.key,
  });

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  WidgetsToImageController widgetsToImageController =
      WidgetsToImageController();
  bool isOpen = false;

  String getScoreMBTI(String type, String predictType) {
    List<String> typeList = type.split('');
    List<String> predictTypeList = predictType.split('');
    int score = 0;
    for (int i = 0; i < type.length; i++) {
      if (typeList[i] == predictTypeList[i]) {
        score++;
      }
    }
    switch (score) {
      case 4:
        return 'A';
      case 3:
        return 'B';
      case 2:
        return 'C';
      case 1:
        return 'D';
      default:
        return 'F';
    }
  }

  void openBox() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  void handleOnPressedRepeatCourse() {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void handleOnPressedShare() async {
    final bytes = await widgetsToImageController.capture();

    if (bytes != null) {
      if (!mounted) return;
      await showDialog(
        barrierDismissible: true,
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          content: Image.memory(bytes),
          actionsAlignment: MainAxisAlignment.spaceEvenly,
          actionsPadding: const EdgeInsets.only(bottom: 10),
          actions: [
            GestureDetector(
              onTap: () async {
                await Share.shareXFiles(
                  [
                    XFile.fromData(
                      bytes,
                      name: 'great_picture.png',
                      mimeType: 'image/png',
                    ),
                  ],
                );

                if (!mounted) return;
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.share_outlined),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String name = widget.name;
    String personality = widget.type.toUpperCase();
    String predictPersonality = widget.predictType;

    return DefaultLayout(
      body: ListView(
        children: [
          WidgetsToImage(
            controller: widgetsToImageController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Center(
                  child: Text(
                    "성적조회",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 25,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Table(
                  border: TableBorder.all(
                    width: CommonValue.commonWidth,
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: ['과목명', '정답', '제출한 답', '점수']
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: Text(
                                e,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    TableRow(
                      children: [
                        '$name의\nMBTI',
                        personality.toUpperCase(),
                        predictPersonality,
                        getScoreMBTI(personality, predictPersonality),
                      ]
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(4),
                              child: Text(
                                e,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                isOpen
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: MBTI.gift[personality]!
                            .map(
                              (e) => FadeInUp(
                                delay: const Duration(milliseconds: 300),
                                from: 50,
                                child: Image.asset(e, width: 50, height: 50),
                                // child: ShakeY(
                                //   from: 10,
                                //   infinite: true,
                                //   duration: const Duration(seconds: 4),
                                //
                                // ),
                              ),
                            )
                            .toList(),
                      )
                    : const SizedBox(height: 50),
                isOpen
                    ? GestureDetector(
                        onTapUp: (TapUpDetails details) => openBox(),
                        child: ElasticIn(
                          duration: const Duration(milliseconds: 2500),
                          child: Image.asset(
                            'asset/images/opened_gift_box.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTapUp: (TapUpDetails details) => openBox(),
                        child: ElasticInDown(
                          duration: const Duration(milliseconds: 800),
                          child: Image.asset(
                            'asset/images/gift_box.png',
                            width: 200,
                            height: 200,
                          ),
                        ),
                      ),
                const SizedBox(height: 32),
                Text(
                  '$name 님의 MBTI는 ${personality.toUpperCase()}입니다.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '내가 본 $name 님은 처음 제출했던 실제 $name 님의 MBTI 성격유형과 ${personality == predictPersonality ? "일치하는 것으로 나타납니다." : "다르게 나타납니다."}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '내가 본 $name 님의 성격은 $predictPersonality로 다음과 같은 성격을 가지는 것으로 나타납니다.',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '👉 ${MBTI.feature[predictPersonality]}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '실제 $name 님의 성격을 다시한번 확인하시기 바라며, 이 성격에 잘 맞는 선물을 추천드리니 확인하시고 공유하시기 바랍니다.',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '📋 ${MBTI.feature[personality]}',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  '$name 님과 행복한 시간 보내시길! 🍀',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              OutlinedButton(
                onPressed: handleOnPressedShare,
                child: const Text("공유하기"),
              ),
              OutlinedButton(
                onPressed: handleOnPressedRepeatCourse,
                child: const Text("재수강하기"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
