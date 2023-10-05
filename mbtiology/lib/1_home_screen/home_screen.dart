import 'package:flutter/material.dart';
import 'package:mbtiology/2_test_screen/test_screen.dart';
import 'package:mbtiology/common/common_value.dart';
import 'package:mbtiology/common/default_layout.dart';
import 'package:mbtiology/3_result_screen/mbti.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String name = '';
  String type = '';
  String info = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: DefaultLayout(
        body: ListView(
          children: [
            const _TopPart(),
            const SizedBox(height: 48),
            _InputPart(
              onNameChanged: (val) {
                name = val;
              },
              onTypeChanged: (val) {
                type = val;
              },
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.center,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  border: Border.all(width: CommonValue.commonWidth),
                ),
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    renderInfo('문제지의 해당란에 정확한 성명과 MBTI 유형을 입력하시오.'),
                    renderInfo('다음의 문구를 마음속에 새기고 답을 정확히 표시하시오.'),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: const BoxDecoration(color: Colors.grey),
                      child: const Text('너만 보인단 말이야'),
                    ),
                    const SizedBox(height: 16),
                    renderInfo(
                        '답은 OX로 구분되며 나의 성격이 아닌 내가 생각하고 있는 사람의 성격을 골라야 함에 유의하시오.'),
                    renderInfo(
                        '문항은 총 70문항이며, 시간제한은 없으나 내가 좋아하는 사람이라면 빠르게 모든 문항에 빠짐없이 응답하시오.'),
                    renderInfo(
                        '이 검사는 재미로 하는 검사이므로, 이 결과를 중요한 결정을 하는 데 사용하거나 타인에게 불쾌감을 주는 행위는 하지 마시오.'),
                    OutlinedButton(
                      onPressed: () {
                        if (name.isEmpty) {
                          info = '이름을 입력해주세요';
                          setState(() {});
                        } else if (!MBTI.mbti.contains(type.toUpperCase())) {
                          info = '유형을 정확하게 입력해주세요';

                          type = type.toUpperCase();
                          setState(() {});
                        } else {
                          print('clicked!');
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (_) => TestScreen(
                                name: name,
                                type: type,
                              ),
                            ),
                            (route) => false,
                          );
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                      ),
                      child: const Text("시험 시작하기"),
                    ),
                    Text(
                      info,
                      style: const TextStyle(
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  renderInfo(String string) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Icon(
              Icons.circle_outlined,
              size: 12,
            ),
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(string),
          ),
        ],
      ),
    );
  }
}

class _TopPart extends StatelessWidget {
  const _TopPart({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            width: 100,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(CommonValue.commonBorderRadius),
              border: Border.all(
                color: Colors.black,
                width: CommonValue.commonWidth,
              ),
            ),
            child: const Center(
              child: Text(
                '제2교시',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(8),
            child: const Text(
              '지금부터 MBTI 시험을 시작합니다.',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                '남의 영역',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.all(8),
                child: Text('좋아하는 형'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InputPart extends StatelessWidget {
  final void Function(String)? onNameChanged;
  final void Function(String)? onTypeChanged;

  const _InputPart({
    required this.onNameChanged,
    required this.onTypeChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(8),
            child: TextField(
              onChanged: onNameChanged,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: OutlineInputBorder(),
                labelText: '성명',
                hintText: '좋아하는 사람의 이름을 입력하시오.',
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.center,
          child: Container(
            margin: const EdgeInsets.all(8),
            child: TextField(
              onChanged: onTypeChanged,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(8),
                border: OutlineInputBorder(),
                labelText: '수험번호',
                hintText: '위에 작성한 분의 MBTI 유형을 고르시오.',
              ),
            ),
          ),
        ),
      ],
    );
  }
}
