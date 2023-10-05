import 'package:flutter/material.dart';
import 'package:mbtiology/3_result_screen/result_screen.dart';
import 'package:mbtiology/common/common_value.dart';
import 'package:mbtiology/common/default_layout.dart';
import 'package:mbtiology/2_test_screen/questions.dart' as questions;

class TestScreen extends StatefulWidget {
  final String name;
  final String type;

  const TestScreen({
    required this.name,
    required this.type,
    super.key,
  });

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  var pageController = PageController();
  var page = 1;
  List<int> myAns = [];

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      fontSize: 20,
    );

    return DefaultLayout(
      appBar: renderAppBar(),
      body: ListView(
        children: [
          Text(
            '⭐️ ${widget.name} 이(가) 어떤 사람인지 생각하며 답변해 주시기 바랍니다.',
            style: defaultTextStyle,
          ),
          const SizedBox(height: 20),

          // 문제 container
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                width: CommonValue.commonWidth,
              ),
            ),
            height: 300,

            // 문제 context
            child: PageView.builder(
              physics: const NeverScrollableScrollPhysics(),
              controller: pageController,
              itemCount: questions.mbti_qs.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${questions.mbti_qs[index]['order']}. ${questions.mbti_qs[index]['question']}',
                      style: defaultTextStyle,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'a. ${questions.mbti_qs[index]['ans_a']}',
                      style: defaultTextStyle,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'b. ${questions.mbti_qs[index]['ans_b']}',
                      style: defaultTextStyle,
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: 40),
          Text(
            ' 답안 작성',
            style: defaultTextStyle,
          ),
          const SizedBox(height: 20),
          // 보기 a, b
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: CommonValue.commonWidth,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (page <= 70) {
                      myAns.add(0);
                      pageController.animateToPage(
                        page++,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                      setState(() {});
                    }
                  },
                  child: const Text('a', style: defaultTextStyle),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(
                      side: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black,
                    elevation: 0,
                  ),
                  onPressed: () {
                    if (page <= 70) {
                      myAns.add(1);
                      pageController.animateToPage(
                        page++,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }

                    setState(() {});
                  },
                  child: const Text(
                    'b',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          if (page == 71)
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 16,
              ),
              child: ElevatedButton(
                onPressed: () {
                  var ScoreE = myAns[0] +
                      myAns[7] +
                      myAns[14] +
                      myAns[21] +
                      myAns[28] +
                      myAns[35] +
                      myAns[42] +
                      myAns[49] +
                      myAns[56] +
                      myAns[63];
                  var ScoreN = myAns[1] +
                      myAns[8] +
                      myAns[15] +
                      myAns[22] +
                      myAns[29] +
                      myAns[36] +
                      myAns[43] +
                      myAns[50] +
                      myAns[57] +
                      myAns[64] +
                      myAns[2] +
                      myAns[9] +
                      myAns[16] +
                      myAns[23] +
                      myAns[30] +
                      myAns[37] +
                      myAns[44] +
                      myAns[51] +
                      myAns[58] +
                      myAns[65];
                  var ScoreF = myAns[3] +
                      myAns[10] +
                      myAns[17] +
                      myAns[24] +
                      myAns[31] +
                      myAns[38] +
                      myAns[45] +
                      myAns[52] +
                      myAns[59] +
                      myAns[66] +
                      myAns[4] +
                      myAns[11] +
                      myAns[18] +
                      myAns[25] +
                      myAns[32] +
                      myAns[39] +
                      myAns[46] +
                      myAns[53] +
                      myAns[60] +
                      myAns[67];
                  var ScoreP = myAns[5] +
                      myAns[12] +
                      myAns[19] +
                      myAns[26] +
                      myAns[33] +
                      myAns[40] +
                      myAns[47] +
                      myAns[54] +
                      myAns[61] +
                      myAns[68] +
                      myAns[6] +
                      myAns[13] +
                      myAns[20] +
                      myAns[27] +
                      myAns[34] +
                      myAns[41] +
                      myAns[48] +
                      myAns[55] +
                      myAns[62] +
                      myAns[69];

                  var type1 = ScoreE >= 5 ? 'E' : 'I';
                  var type2 = ScoreN >= 10 ? 'N' : 'S';
                  var type3 = ScoreF >= 10 ? 'F' : 'T';
                  var type4 = ScoreP >= 10 ? 'P' : 'F';

                  var predictType = type1 + type2 + type3 + type4;

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                      builder: (_) => ResultScreen(
                        name: widget.name,
                        type: widget.type,
                        predictType: predictType,
                      ),
                    ),
                    (route) => false,
                  );
                },
                style: const ButtonStyle(),
                child: const Text('제출하기'),
              ),
            ),
        ],
      ),
    );
  }

  renderAppBar() {
    return AppBar(
      foregroundColor: Colors.black,
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '제2교시',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            "남의 영역",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            '좋아하는 형',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      centerTitle: true,
      backgroundColor: CommonValue.paperColor,
      elevation: 0,
      shape: const Border(
        bottom: BorderSide(
          color: Colors.black,
          width: CommonValue.commonWidth,
        ),
      ),
    );
  }
}
