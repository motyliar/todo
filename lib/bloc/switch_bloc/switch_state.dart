// ignore_for_file: public_member_api_docs, sort_constructors_first

part of 'switch_bloc.dart';

class SwitchState extends Equatable {
  const SwitchState({
    required this.switchValue,
  });
  final bool switchValue;
  @override
  List<Object> get props => [switchValue];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'switchValue': switchValue,
    };
  }

  factory SwitchState.fromMap(Map<String, dynamic> map) {
    return SwitchState(
      switchValue: map['switchValue'] as bool,
    );
  }
}

class SwitchInitial extends SwitchState {
  SwitchInitial({required bool switchValue}) : super(switchValue: switchValue);
}
