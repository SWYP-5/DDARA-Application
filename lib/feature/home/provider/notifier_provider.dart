import 'package:ddara/feature/home/home_notifier.dart';
import 'package:ddara/feature/home/util/home_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeNotifierProvider = NotifierProvider<HomeNotifier, HomeState>(
  HomeNotifier.new,
);
