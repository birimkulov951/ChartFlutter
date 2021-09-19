import 'dart:math';

import 'package:core/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

import 'package:flutter_bloc/flutter_bloc.dart';


class MainScreen extends StatefulWidget {
  static const routeName = "/mainScreen";

  const MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>{

  String price;
  String changePercent;
  String changeAmount;
  String high;
  String low;
  String volumePrimary24h;
  String volumeSecondary24h;

  bool isOnceStateSet = false;


  bool is1dClicked = true;
  bool is1wClicked = false;
  bool is1mClicked = false;
  bool is1yClicked = false;
  bool isAllClicked = false;

  List<ChartPoints> _scores;

  final rng = Random();
  final dayCount = 7;

  @override
  void initState() {
    super.initState();

    context.read<ChartBloc>().add(GetChart('1d', 'Xbt', 'Aud'));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColors.greyBg,
      appBar: AppBar(
          backgroundColor: AppColors.white,
          elevation: 1,
          title: Text(
              'BTC/AUD',
              style: Theme.of(context).textTheme.headline1
          ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Text('Bitcoin', style: Theme.of(context).textTheme.headline2),
                      Text(' | BTC', style: Theme.of(context).textTheme.headline3)
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(price == null ? '--' : '\$$price', style: Theme.of(context).textTheme.headline4),
                      const SizedBox(width: 7),
                      Text(changePercent == null ? '' : '\$$changeAmount', style: Theme.of(context).textTheme.subtitle1),
                      Text(changePercent == null ? '' : ' ($changePercent%)', style: Theme.of(context).textTheme.subtitle1)
                    ],
                  ),
                  const SizedBox(height: 7),
                  Row(
                    children: [
                      Text('High: ', style: Theme.of(context).textTheme.bodyText1),
                      Text(high ?? '--', style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(width: 10),
                      Text('Low: ', style: Theme.of(context).textTheme.bodyText1),
                      Text(low ?? '--', style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Text('Vol: ', style: Theme.of(context).textTheme.bodyText1),
                      Text(volumePrimary24h ?? '--', style: Theme.of(context).textTheme.bodyText2),
                      const SizedBox(width: 5),
                      Text(volumeSecondary24h == null ? '--' : '\$$volumeSecondary24h', style: Theme.of(context).textTheme.bodyText2)
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonWrapper(
                        text: '1D',
                        width: 55,
                        height: 35,
                        isClicked: is1dClicked,
                        onPressed: () {
                          rangeButtonClicked('1D');
                          context.read<ChartBloc>().add(GetChart('1d', 'Xbt', 'Aud'));
                        }
                      ),
                      ButtonWrapper(
                          text: '1W',
                          width: 55,
                          height: 35,
                          isClicked: is1wClicked,
                          onPressed: () {
                            rangeButtonClicked('1W');
                            context.read<ChartBloc>().add(GetChart('1w', 'Xbt', 'Aud'));
                          }
                      ),
                      ButtonWrapper(
                          text: '1M',
                          width: 55,
                          height: 35,
                          isClicked: is1mClicked,
                          onPressed: () {
                            rangeButtonClicked('1M');
                            context.read<ChartBloc>().add(GetChart('1M', 'Xbt', 'Aud'));
                          }
                      ),
                      ButtonWrapper(
                          text: '1Y',
                          width: 55,
                          height: 35,
                          isClicked: is1yClicked,
                          onPressed: () {
                            rangeButtonClicked('1Y');
                            context.read<ChartBloc>().add(GetChart('1y', 'Xbt', 'Aud'));
                          }
                      ),
                      ButtonWrapper(
                          text: 'ALL',
                          width: 55,
                          height: 35,
                          isClicked: isAllClicked,
                          onPressed: () {
                            rangeButtonClicked('ALL');
                            context.read<ChartBloc>().add(GetChart('all', 'Xbt', 'Aud'));
                          }
                      )
                    ],
                  ),
                ]
              ),
            ),
            const SizedBox(height: 20),
            BlocBuilder<ChartBloc, ChartState>(
                builder: (context, state) {
                  //print('ChartBloc state: $state');
                  if (state is ChartNoInternetConnection) {
                    return Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text('No internet connection', style: Theme.of(context).textTheme.bodyText1),
                    );
                  }
                  if (state is ChartError) {
                    return Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text(state.errorMessage, style: Theme.of(context).textTheme.bodyText1),
                    );
                  }
                  if (state is ChartNoData) {
                    return Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: Text('No data', style: Theme.of(context).textTheme.bodyText1),
                    );
                  }
                  if (state is ChartHasData) {

                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      _setStateOne(state.result);
                    });

                    _scores = List<ChartPoints>.generate(state.result.points.length, (index) {
                      final y = state.result.points[index];
                      final d = state.result.pointsStartFrom.add(Duration(days: -state.result.points.length + index));
                      return ChartPoints(y,d);
                    });

                    return PaintWrapper(
                        scores: _scores,
                        high: state.result.high,
                        low: state.result.low);
                  }
                  if (state is ChartLoading) {
                    return Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: const CupertinoActivityIndicator(radius: 10),
                    );
                  }
                  else {
                    return Container(
                      height: MediaQuery.of(context).size.width,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      child: const Text('BloC error'),
                    );
                  }
                }
            ),

            //const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('BTC Holdings', style: Theme.of(context).textTheme.headline2),
                  Text('\$00.00', style: Theme.of(context).textTheme.headline3)
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      )
    );
  }


  void rangeButtonClicked(String i) {
    isOnceStateSet = false;

    switch(i) {

      case '1W': {
        is1dClicked = false;
        is1wClicked = true;
        is1mClicked = false;
        is1yClicked = false;
        isAllClicked = false;
      }
      break;

      case '1M': {
        is1dClicked = false;
        is1wClicked = false;
        is1mClicked = true;
        is1yClicked = false;
        isAllClicked = false;
      }
      break;

      case '1Y': {
        is1dClicked = false;
        is1wClicked = false;
        is1mClicked = false;
        is1yClicked = true;
        isAllClicked = false;
      }
      break;

      case 'ALL': {
        is1dClicked = false;
        is1wClicked = false;
        is1mClicked = false;
        is1yClicked = false;
        isAllClicked = true;
      }
      break;

      default: {
        is1dClicked = true;
        is1wClicked = false;
        is1mClicked = false;
        is1yClicked = false;
        isAllClicked = false;
      }
      break;
    }
    setState(() {});
  }

  void _setStateOne(ChartResult result) {
    if (!isOnceStateSet) {
      setState(() {
        price = result.price.toString();
        changePercent = result.changePercent.toString();
        changeAmount = result.changeAmount.toString();
        high = result.high.toString();
        low = result.low.toString();
        volumePrimary24h = result.volumePrimary24h.toString();
        volumeSecondary24h = result.volumeSecondary24h.toString();

        isOnceStateSet = true;
      });
    }

  }



}

