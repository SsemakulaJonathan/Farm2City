import 'dart:io';

import 'package:dio_http/dio_http.dart';
import 'package:farm_city/constants/constant.dart';
import 'package:flutter/material.dart';

class AppErrorWidget extends StatelessWidget {
  final dynamic exception;
  final bool retry;

  const AppErrorWidget({this.exception, this.retry = false});
  @override
  Widget build(BuildContext context) {
    if (exception is DioError) {
      DioError dioError = exception;
      if (dioError.type == DioErrorType.connectTimeout ||
          dioError.type == DioErrorType.sendTimeout ||
          dioError.type == DioErrorType.receiveTimeout) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Icon(
              Icons.warning,
              size: 100,
              color: Constants.errorColor,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Text(
                  'Uh oh! It appears the connection timed out',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Visibility(
              visible: retry,
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text('Retry'),
                ),
              ),
            )
          ],
        );
      } else if (dioError.type == DioErrorType.other) {
        if (dioError.error is SocketException) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.warning,
                size: 100,
                color: Constants.errorColor,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Text(
                    'Uh oh! It appears there is no internet connection',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Visibility(
                visible: retry,
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: Text('Retry'),
                  ),
                ),
              )
            ],
          );
        } else {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.warning,
                size: 100,
                color: Constants.errorColor,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Center(
                  child: Text(
                    'Whoops! Something went wrong, our engineers have been alerted',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Visibility(
                visible: retry,
                child: SizedBox(
                  width: 150,
                  child: ElevatedButton(
                    onPressed: () => {},
                    child: Text('Retry'),
                  ),
                ),
              )
            ],
          );
        }
      } else {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.warning,
              size: 100,
              color: Constants.errorColor,
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Text(
                  'Whoops! Something went wrong, our engineers have been alerted',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Visibility(
              visible: retry,
              child: SizedBox(
                width: 150,
                child: ElevatedButton(
                  onPressed: () => {},
                  child: Text('Retry'),
                ),
              ),
            )
          ],
        );
      }
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.warning,
            size: 100,
            color: Constants.errorColor,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Center(
              child: Text(
                'Whoops! Something went wrong, our engineers have been alerted',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Visibility(
            visible: retry,
            child: SizedBox(
              width: 150,
              child: ElevatedButton(
                onPressed: () => {},
                child: Text('Retry'),
              ),
            ),
          )
        ],
      );
    }
  }
}
