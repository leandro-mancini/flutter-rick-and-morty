// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailController on DetailControllerBase, Store {
  late final _$characterAtom =
      Atom(name: 'DetailControllerBase.character', context: context);

  @override
  dynamic get character {
    _$characterAtom.reportRead();
    return super.character;
  }

  @override
  set character(dynamic value) {
    _$characterAtom.reportWrite(value, super.character, () {
      super.character = value;
    });
  }

  late final _$hasCharacterAtom =
      Atom(name: 'DetailControllerBase.hasCharacter', context: context);

  @override
  bool get hasCharacter {
    _$hasCharacterAtom.reportRead();
    return super.hasCharacter;
  }

  @override
  set hasCharacter(bool value) {
    _$hasCharacterAtom.reportWrite(value, super.hasCharacter, () {
      super.hasCharacter = value;
    });
  }

  late final _$getCharacterAsyncAction =
      AsyncAction('DetailControllerBase.getCharacter', context: context);

  @override
  Future getCharacter(String id) {
    return _$getCharacterAsyncAction.run(() => super.getCharacter(id));
  }

  @override
  String toString() {
    return '''
character: ${character},
hasCharacter: ${hasCharacter}
    ''';
  }
}
