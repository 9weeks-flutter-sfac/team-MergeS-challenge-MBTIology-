import 'package:flutter/material.dart';
import 'package:mbtiology/2_test_screen/test_screen.dart';
import 'package:mbtiology/common/const.dart';

List<String> mbti = [
  'ISTJ',
  'ISFJ',
  'INFJ',
  'INTJ',
  'ISTP',
  'ISFP',
  'INFP',
  'INTP',
  'ENFJ',
  'ENTJ',
  'ESTJ',
  'ESFJ',
  'ESTP',
  'ESFP',
  'ENFP',
  'ENTP'
];

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
    print('name: $name');
    print('type: $type');

    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: CommonValue.paperColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              // 제2교시
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 100,
                  padding: EdgeInsets.all(8),
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        CommonValue.commonBorderRadius.toDouble()),
                    border: Border.all(
                      color: Colors.black,
                      width: CommonValue.commonWidth.toDouble(),
                    ),
                  ),
                  child: Center(
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
              SizedBox(height: 16),

              // 시작합니다
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: Text(
                    '지금부터 MBTI 시험을 시작합니다.',
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              // 영역
              Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Container(
                      child: Text(
                        '남의 영역',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Text('좋아하는 형'),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 48),
              // 이름
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: TextField(
                    onChanged: (val) {
                      name = val;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(),
                      labelText: '성명',
                      hintText: '좋아하는 사람의 이름을 입력하시오.',
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 8,
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(8),
                  child: TextField(
                    onChanged: (val) {
                      type = val;
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      border: OutlineInputBorder(),
                      labelText: '수험번호',
                      hintText: '위에 작성한 분의 MBTI 유형을 고르시오.',
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.all(8),
                  decoration: BoxDecoration(border: Border.all()),
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Flexible(
                            child: Text(
                              '문제지의 해당란에 정확한 성명과 MBTI 유형을 입력하시오.',
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Flexible(
                            child: Text('다음의 문구를 마음속에 새기고 답을 정확히 표시하시오.'),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.grey),
                        child: Text('너만 보인단 말이야'),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Flexible(
                              child: Text(
                                  '답은 OX로 구분되며 나의 성격이 아닌 내가 생각하고 있는 사람의 성격을 골라야 함에 유의하시오.'))
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Flexible(
                              child: Text(
                                  '문항은 총 70문항이며, 시간제한은 없으나 내가 좋아하는 사람이라면 빠르게 모든 문항에 빠짐없이 응답하시오.'))
                        ],
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.circle_outlined,
                            size: 16,
                          ),
                          SizedBox(width: 4),
                          Flexible(
                              child: Text(
                                  '이 검사는 재미로 하는 검사이므로, 이 결과를 중요한 결정을 하는 데 사용하거나 타인에게 불쾌감을 주는 행위는 하지 마시오.'))
                        ],
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      OutlinedButton(
                        onPressed: () {
                          if (name.isEmpty) {
                            info = '이름을 입력해주세요';
                            setState(() {});
                          } else if (type.length != 4 )  {
                            // (mbti.contains(type.toUpperCase())


                            // print(type.toUpperCase() in mbti);
                            info = '유형을 정확하게 입력해주세요';
                            setState(() {});
                          } else {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                  builder: (_) => TestScreen(
                                    name: name,
                                    type: type,
                                  ),
                                ),
                                (route) => false);
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.black,
                        ),
                        child: const Text("시험을 시작하기"),
                      ),
                      Text(
                        info,
                        style: TextStyle(
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
      ),
    );
  }
}
