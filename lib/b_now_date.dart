
import 'package:flutter/material.dart';
import 'package:chinese_lunar_calendar/chinese_lunar_calendar.dart';
import 'package:intl/intl.dart';

import 'b_time_bean.dart';
class NowDataTime extends StatefulWidget {
  const NowDataTime({super.key, required this.title});

  final String title;

  @override
  State<NowDataTime> createState() => _NowDataTimeState();
}

class _NowDataTimeState extends State<NowDataTime> {
  @override
  void initState() {
    // TODO: implement initState

    LunarCalendar lunarCalendar = LunarCalendar.from(
      utcDateTime: DateTime.now().toUtc(),
      // utcDateTime: DateTime(2024, 11, 8, 16, 10).toUtc(),
    );

    List<BTimeBean> beans = [];

    ///中国标准时间
    String cst = lunarCalendar.cst.toString();
    beans.add(BTimeBean(name: "中国标准时间", value: cst));

    ///本地时间
    String localTime = lunarCalendar.localTime.toString();

    beans.add(BTimeBean(name: "本地时间", value: localTime));

    ///以下使用 使用本地时间计算
    ///
    ///春节
    String chineseNewYearString = lunarCalendar.chineseNewYearString.toString();

    beans.add(BTimeBean(name: "春节", value: chineseNewYearString));

    ///生肖
    String zodiac = lunarCalendar.zodiac.name.sValue.toString();
    beans.add(BTimeBean(name: "生肖", value: zodiac));

    ///阴历数字
    String yinlishuzi =
        "${lunarCalendar.lunarDate.lunarYear.number}, ${lunarCalendar.lunarDate.lunarMonth.number}, ${lunarCalendar.lunarDate.lunarDay}, 闰月：${lunarCalendar.lunarDate.lunarMonth.isLeapMonth}";

    beans.add(BTimeBean(name: "阴历数字", value: yinlishuzi));

    ///阴历汉字
    String fullCNString = lunarCalendar.lunarDate.fullCNString.toString();

    beans.add(BTimeBean(name: "阴历汉字", value: fullCNString));

    ///八字
    String eightChar = lunarCalendar.eightChar.toString();
    beans.add(BTimeBean(name: "八字", value: eightChar));

    ///星期
    String weekday = lunarCalendar.weekday.name.toString();

    beans.add(BTimeBean(name: "星期", value: weekday));

    ///月相
    String moonPhase = lunarCalendar.moonPhase.name.sValue.toString();

    beans.add(BTimeBean(name: "月相", value: moonPhase));

    ///本年节气
    String localTimeYear = "${getSolarTerms(lunarCalendar.localTime.year)}";

    beans.add(BTimeBean(name: "本年节气", value: ""));

    getSolarTerms(lunarCalendar.localTime.year).forEach((e){
      var formatter = DateFormat('yyyy-MM-dd HH:mm');
      String formatted = formatter.format(e.local);
      beans.add(BTimeBean(name: formatted, value:e.name.sValue.toString() ));
    });


    ///本日节气
    // String rijieqi = jsonEncode(lunarCalendar.localTime.getSolarTerm());
    //
    // beans.add(BTimeBean(name: "本日节气", value: rijieqi));

    ///当前时辰
    String dangrishichen =
        "${lunarCalendar.twoHourPeriod.name}(${lunarCalendar.twoHourPeriod.jing?.cnName ?? ''}${lunarCalendar.twoHourPeriod.jing?.unit ?? ''})${lunarCalendar.ke.fullName}${lunarCalendar.ke.unitName}";
    final twoHourPeriodsString = lunarCalendar.twoHourPeriodList
        .map((e) =>
    '${e.twoHourPeriodIndex}: ${e.name} (${e.nameInHanDynasty}) ${e.meridian} ${e.isLuckyName}')
        .toList();

    beans.add(BTimeBean(name: "当前时辰", value: ""));

    ///本日时辰
    String rishichen = twoHourPeriodsString.toString();

    lunarCalendar.twoHourPeriodList.forEach((e) {
      beans.add(BTimeBean(
          name: "${e.twoHourPeriodIndex}",
          value:
          "${e.name} (${e.nameInHanDynasty}) ${e.meridian} ${e.isLuckyName}"));
    });

    listContainer = [];
    listContainer.add(
      Container(
        child: GestureDetector(onTap: () {}, child: Text('测算当前日期数据')),
      ),
    );

    beans.forEach((bean) {
      listContainer.add(_buildRow(bean: bean));
    });

    print('中国标准时间：${lunarCalendar.cst}');
    print('本地时间：${lunarCalendar.localTime}');
    print('使用本地时间计算');
    print('春节: ${lunarCalendar.chineseNewYearString}');
    print('生肖: ${lunarCalendar.zodiac.name.tValue}');
    print(
        '阴历数字: ${lunarCalendar.lunarDate.lunarYear.number}, ${lunarCalendar.lunarDate.lunarMonth.number}, ${lunarCalendar.lunarDate.lunarDay}, 闰月：${lunarCalendar.lunarDate.lunarMonth.isLeapMonth}');
    print('阴历汉字: ${lunarCalendar.lunarDate.fullCNString}');
    print('八字: ${lunarCalendar.eightChar}');
    print('星期：${lunarCalendar.weekday.name}');
    print('月相：${lunarCalendar.moonPhase.name.sValue}');
    print('本年节气: ${getSolarTerms(lunarCalendar.localTime.year)}');
    print('本日节气：${lunarCalendar.localTime.getSolarTerm()}');
    print(
        '当前时辰：${lunarCalendar.twoHourPeriod.name}(${lunarCalendar.twoHourPeriod.jing?.cnName}${lunarCalendar.twoHourPeriod.jing?.unit})${lunarCalendar.ke.fullName}${lunarCalendar.ke.unitName}');
    print('本日时辰：$twoHourPeriodsString');

    super.initState();
  }

  List<Widget> listContainer = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: listContainer,
          ),
        ),
      ),
    );
  }

  Widget _buildRow({BTimeBean? bean}) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            bean?.name ?? '',
            style: TextStyle(color: Colors.red),
          ),
          Expanded(
              child: Text(
                bean?.value ?? '',
                maxLines: 10,
              )),
        ],
      ),
    );
  }
}
