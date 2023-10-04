import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:mbtiology/1_home_screen/home_screen.dart';
import 'package:mbtiology/common/const.dart';
import 'package:mbtiology/common/mbti.dart';
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
  late String name = widget.name;
  late String personality = widget.type;
  late String predictPersonality = widget.predictType;


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
        barrierDismissible: false,
        context: context,
        builder: (_) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.chevron_left),
              ),
              const Text(
                '저장하기',
                style: TextStyle(
                    // fontSize: 18.h,
                    ),
              ),
            ],
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
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            WidgetsToImage(
              controller: widgetsToImageController,
              child: Padding(
                padding: const EdgeInsets.all(CommonValue.commonPadding),
                child: Column(
                  children: [
                    const Center(
                      child: Text(
                        "성적조회",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 25),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Table(
                      border: TableBorder.all(),
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: [
                        const TableRow(
                          children: [
                            Center(
                              child: Text(
                                '과목명',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '정답',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '제출한 답',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                '점수',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                        TableRow(
                          children: [
                            Center(
                              child: Text(
                                '$name의 MBTI',
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                predictPersonality,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                personality,
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Center(
                              child: Text(
                                getScoreMBTI(personality, predictPersonality),
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    isOpen
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: MBTI.gift[personality]!
                                .map<Widget>(
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
                        : const SizedBox(
                            height: 50,
                          ),
                    isOpen
                        ? GestureDetector(
                            onTapUp: (TapUpDetails details) => openBox(),
                            child: ElasticIn(
                              duration: const Duration(milliseconds: 2500),
                              child: Image.asset(
                                  'asset/images/opened_gift_box.png',
                                  width: 200,
                                  height: 200),
                            ),
                          )
                        : GestureDetector(
                            onTapUp: (TapUpDetails details) => openBox(),
                            child: ElasticInDown(
                              duration: const Duration(milliseconds: 800),
                              child: Image.asset('asset/images/gift_box.png',
                                  width: 200, height: 200),
                            ),
                          ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "$name님의 MBTI는 ",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: personality,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const TextSpan(
                            text: "입니다.",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: "내가 본 ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: ' $name ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const TextSpan(
                            text: "님은 ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: ' $name ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const TextSpan(
                            text: "님의  실제 성격 유형과  ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: personality == predictPersonality
                                ? "일치합니다."
                                : "다릅니다.",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: "내가 본 ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: ' $name ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const TextSpan(
                            text: "님은 ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: MBTI.feature[predictPersonality],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: "실제  ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: ' $name ',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          const TextSpan(
                            text: "님의 성격은 ",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          TextSpan(
                            text: MBTI.feature[personality],
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 60),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                    onPressed: handleOnPressedShare, child: const Text("공유하기")),
                OutlinedButton(
                    onPressed: handleOnPressedRepeatCourse,
                    child: const Text("재수강하기")),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
