import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class Steps extends Equatable {
  const Steps({
    required this.counter,
    required this.goal,
    required this.title,
    required this.colorCard,
    required this.pathImg,
  });

  final int counter;
  final int goal;
  final String title;
  final String pathImg;
  final Color colorCard;

  @override
  List<Object?> get props => [counter, goal, title];
}
