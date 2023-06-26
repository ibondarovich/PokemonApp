part of 'bloc.dart';

@immutable
abstract class MainViewEvent {}

class InitEvent extends MainViewEvent {}
class LoadLocalData extends MainViewEvent {}
