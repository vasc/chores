import '../schema.graphql.dart';
import 'fragments.graphql.dart';
import 'package:chores/graphql/scalars.dart';
import 'package:gql/ast.dart';

class Variables$Mutation$CreateChore {
  factory Variables$Mutation$CreateChore({
    required String title,
    String? description,
    required int tokenValue,
    Enum$ChoreKind? kind,
    Enum$Recurrence? recurrence,
    int? cooldownMinutes,
  }) =>
      Variables$Mutation$CreateChore._({
        r'title': title,
        if (description != null) r'description': description,
        r'tokenValue': tokenValue,
        if (kind != null) r'kind': kind,
        if (recurrence != null) r'recurrence': recurrence,
        if (cooldownMinutes != null) r'cooldownMinutes': cooldownMinutes,
      });

  Variables$Mutation$CreateChore._(this._$data);

  factory Variables$Mutation$CreateChore.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$title = data['title'];
    result$data['title'] = (l$title as String);
    if (data.containsKey('description')) {
      final l$description = data['description'];
      result$data['description'] = (l$description as String?);
    }
    final l$tokenValue = data['tokenValue'];
    result$data['tokenValue'] = (l$tokenValue as int);
    if (data.containsKey('kind')) {
      final l$kind = data['kind'];
      result$data['kind'] =
          l$kind == null ? null : fromJson$Enum$ChoreKind((l$kind as String));
    }
    if (data.containsKey('recurrence')) {
      final l$recurrence = data['recurrence'];
      result$data['recurrence'] = l$recurrence == null
          ? null
          : fromJson$Enum$Recurrence((l$recurrence as String));
    }
    if (data.containsKey('cooldownMinutes')) {
      final l$cooldownMinutes = data['cooldownMinutes'];
      result$data['cooldownMinutes'] = (l$cooldownMinutes as int?);
    }
    return Variables$Mutation$CreateChore._(result$data);
  }

  Map<String, dynamic> _$data;

  String get title => (_$data['title'] as String);

  String? get description => (_$data['description'] as String?);

  int get tokenValue => (_$data['tokenValue'] as int);

  Enum$ChoreKind? get kind => (_$data['kind'] as Enum$ChoreKind?);

  Enum$Recurrence? get recurrence => (_$data['recurrence'] as Enum$Recurrence?);

  int? get cooldownMinutes => (_$data['cooldownMinutes'] as int?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$title = title;
    result$data['title'] = l$title;
    if (_$data.containsKey('description')) {
      final l$description = description;
      result$data['description'] = l$description;
    }
    final l$tokenValue = tokenValue;
    result$data['tokenValue'] = l$tokenValue;
    if (_$data.containsKey('kind')) {
      final l$kind = kind;
      result$data['kind'] =
          l$kind == null ? null : toJson$Enum$ChoreKind(l$kind);
    }
    if (_$data.containsKey('recurrence')) {
      final l$recurrence = recurrence;
      result$data['recurrence'] =
          l$recurrence == null ? null : toJson$Enum$Recurrence(l$recurrence);
    }
    if (_$data.containsKey('cooldownMinutes')) {
      final l$cooldownMinutes = cooldownMinutes;
      result$data['cooldownMinutes'] = l$cooldownMinutes;
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateChore<Variables$Mutation$CreateChore>
      get copyWith => CopyWith$Variables$Mutation$CreateChore(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateChore) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (_$data.containsKey('description') !=
        other._$data.containsKey('description')) {
      return false;
    }
    if (l$description != lOther$description) {
      return false;
    }
    final l$tokenValue = tokenValue;
    final lOther$tokenValue = other.tokenValue;
    if (l$tokenValue != lOther$tokenValue) {
      return false;
    }
    final l$kind = kind;
    final lOther$kind = other.kind;
    if (_$data.containsKey('kind') != other._$data.containsKey('kind')) {
      return false;
    }
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$recurrence = recurrence;
    final lOther$recurrence = other.recurrence;
    if (_$data.containsKey('recurrence') !=
        other._$data.containsKey('recurrence')) {
      return false;
    }
    if (l$recurrence != lOther$recurrence) {
      return false;
    }
    final l$cooldownMinutes = cooldownMinutes;
    final lOther$cooldownMinutes = other.cooldownMinutes;
    if (_$data.containsKey('cooldownMinutes') !=
        other._$data.containsKey('cooldownMinutes')) {
      return false;
    }
    if (l$cooldownMinutes != lOther$cooldownMinutes) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$title = title;
    final l$description = description;
    final l$tokenValue = tokenValue;
    final l$kind = kind;
    final l$recurrence = recurrence;
    final l$cooldownMinutes = cooldownMinutes;
    return Object.hashAll([
      l$title,
      _$data.containsKey('description') ? l$description : const {},
      l$tokenValue,
      _$data.containsKey('kind') ? l$kind : const {},
      _$data.containsKey('recurrence') ? l$recurrence : const {},
      _$data.containsKey('cooldownMinutes') ? l$cooldownMinutes : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateChore<TRes> {
  factory CopyWith$Variables$Mutation$CreateChore(
    Variables$Mutation$CreateChore instance,
    TRes Function(Variables$Mutation$CreateChore) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateChore;

  factory CopyWith$Variables$Mutation$CreateChore.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateChore;

  TRes call({
    String? title,
    String? description,
    int? tokenValue,
    Enum$ChoreKind? kind,
    Enum$Recurrence? recurrence,
    int? cooldownMinutes,
  });
}

class _CopyWithImpl$Variables$Mutation$CreateChore<TRes>
    implements CopyWith$Variables$Mutation$CreateChore<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateChore(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateChore _instance;

  final TRes Function(Variables$Mutation$CreateChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? title = _undefined,
    Object? description = _undefined,
    Object? tokenValue = _undefined,
    Object? kind = _undefined,
    Object? recurrence = _undefined,
    Object? cooldownMinutes = _undefined,
  }) =>
      _then(Variables$Mutation$CreateChore._({
        ..._instance._$data,
        if (title != _undefined && title != null) 'title': (title as String),
        if (description != _undefined) 'description': (description as String?),
        if (tokenValue != _undefined && tokenValue != null)
          'tokenValue': (tokenValue as int),
        if (kind != _undefined) 'kind': (kind as Enum$ChoreKind?),
        if (recurrence != _undefined)
          'recurrence': (recurrence as Enum$Recurrence?),
        if (cooldownMinutes != _undefined)
          'cooldownMinutes': (cooldownMinutes as int?),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateChore<TRes>
    implements CopyWith$Variables$Mutation$CreateChore<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateChore(this._res);

  TRes _res;

  call({
    String? title,
    String? description,
    int? tokenValue,
    Enum$ChoreKind? kind,
    Enum$Recurrence? recurrence,
    int? cooldownMinutes,
  }) =>
      _res;
}

class Mutation$CreateChore {
  Mutation$CreateChore({
    required this.createChore,
    this.$__typename = 'Mutation',
  });

  factory Mutation$CreateChore.fromJson(Map<String, dynamic> json) {
    final l$createChore = json['createChore'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateChore(
      createChore: Fragment$ChoreFields.fromJson(
          (l$createChore as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$ChoreFields createChore;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createChore = createChore;
    _resultData['createChore'] = l$createChore.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createChore = createChore;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createChore,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateChore) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$createChore = createChore;
    final lOther$createChore = other.createChore;
    if (l$createChore != lOther$createChore) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$CreateChore on Mutation$CreateChore {
  CopyWith$Mutation$CreateChore<Mutation$CreateChore> get copyWith =>
      CopyWith$Mutation$CreateChore(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$CreateChore<TRes> {
  factory CopyWith$Mutation$CreateChore(
    Mutation$CreateChore instance,
    TRes Function(Mutation$CreateChore) then,
  ) = _CopyWithImpl$Mutation$CreateChore;

  factory CopyWith$Mutation$CreateChore.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateChore;

  TRes call({
    Fragment$ChoreFields? createChore,
    String? $__typename,
  });
  CopyWith$Fragment$ChoreFields<TRes> get createChore;
}

class _CopyWithImpl$Mutation$CreateChore<TRes>
    implements CopyWith$Mutation$CreateChore<TRes> {
  _CopyWithImpl$Mutation$CreateChore(
    this._instance,
    this._then,
  );

  final Mutation$CreateChore _instance;

  final TRes Function(Mutation$CreateChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createChore = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateChore(
        createChore: createChore == _undefined || createChore == null
            ? _instance.createChore
            : (createChore as Fragment$ChoreFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$ChoreFields<TRes> get createChore {
    final local$createChore = _instance.createChore;
    return CopyWith$Fragment$ChoreFields(
        local$createChore, (e) => call(createChore: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateChore<TRes>
    implements CopyWith$Mutation$CreateChore<TRes> {
  _CopyWithStubImpl$Mutation$CreateChore(this._res);

  TRes _res;

  call({
    Fragment$ChoreFields? createChore,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$ChoreFields<TRes> get createChore =>
      CopyWith$Fragment$ChoreFields.stub(_res);
}

const documentNodeMutationCreateChore = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateChore'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'title')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'description')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'tokenValue')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'kind')),
        type: NamedTypeNode(
          name: NameNode(value: 'ChoreKind'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(
            value: EnumValueNode(name: NameNode(value: 'scheduled'))),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'recurrence')),
        type: NamedTypeNode(
          name: NameNode(value: 'Recurrence'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(
            value: EnumValueNode(name: NameNode(value: 'one_off'))),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'cooldownMinutes')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: IntValueNode(value: '0')),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createChore'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'title'),
            value: VariableNode(name: NameNode(value: 'title')),
          ),
          ArgumentNode(
            name: NameNode(value: 'description'),
            value: VariableNode(name: NameNode(value: 'description')),
          ),
          ArgumentNode(
            name: NameNode(value: 'tokenValue'),
            value: VariableNode(name: NameNode(value: 'tokenValue')),
          ),
          ArgumentNode(
            name: NameNode(value: 'kind'),
            value: VariableNode(name: NameNode(value: 'kind')),
          ),
          ArgumentNode(
            name: NameNode(value: 'recurrence'),
            value: VariableNode(name: NameNode(value: 'recurrence')),
          ),
          ArgumentNode(
            name: NameNode(value: 'cooldownMinutes'),
            value: VariableNode(name: NameNode(value: 'cooldownMinutes')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'ChoreFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionChoreFields,
]);

class Variables$Mutation$ClaimChore {
  factory Variables$Mutation$ClaimChore({required String choreId}) =>
      Variables$Mutation$ClaimChore._({
        r'choreId': choreId,
      });

  Variables$Mutation$ClaimChore._(this._$data);

  factory Variables$Mutation$ClaimChore.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$choreId = data['choreId'];
    result$data['choreId'] = (l$choreId as String);
    return Variables$Mutation$ClaimChore._(result$data);
  }

  Map<String, dynamic> _$data;

  String get choreId => (_$data['choreId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$choreId = choreId;
    result$data['choreId'] = l$choreId;
    return result$data;
  }

  CopyWith$Variables$Mutation$ClaimChore<Variables$Mutation$ClaimChore>
      get copyWith => CopyWith$Variables$Mutation$ClaimChore(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$ClaimChore) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$choreId = choreId;
    final lOther$choreId = other.choreId;
    if (l$choreId != lOther$choreId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$choreId = choreId;
    return Object.hashAll([l$choreId]);
  }
}

abstract class CopyWith$Variables$Mutation$ClaimChore<TRes> {
  factory CopyWith$Variables$Mutation$ClaimChore(
    Variables$Mutation$ClaimChore instance,
    TRes Function(Variables$Mutation$ClaimChore) then,
  ) = _CopyWithImpl$Variables$Mutation$ClaimChore;

  factory CopyWith$Variables$Mutation$ClaimChore.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ClaimChore;

  TRes call({String? choreId});
}

class _CopyWithImpl$Variables$Mutation$ClaimChore<TRes>
    implements CopyWith$Variables$Mutation$ClaimChore<TRes> {
  _CopyWithImpl$Variables$Mutation$ClaimChore(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ClaimChore _instance;

  final TRes Function(Variables$Mutation$ClaimChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? choreId = _undefined}) =>
      _then(Variables$Mutation$ClaimChore._({
        ..._instance._$data,
        if (choreId != _undefined && choreId != null)
          'choreId': (choreId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$ClaimChore<TRes>
    implements CopyWith$Variables$Mutation$ClaimChore<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ClaimChore(this._res);

  TRes _res;

  call({String? choreId}) => _res;
}

class Mutation$ClaimChore {
  Mutation$ClaimChore({
    required this.claimChore,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ClaimChore.fromJson(Map<String, dynamic> json) {
    final l$claimChore = json['claimChore'];
    final l$$__typename = json['__typename'];
    return Mutation$ClaimChore(
      claimChore: Fragment$AssignmentFields.fromJson(
          (l$claimChore as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AssignmentFields claimChore;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$claimChore = claimChore;
    _resultData['claimChore'] = l$claimChore.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$claimChore = claimChore;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$claimChore,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ClaimChore) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$claimChore = claimChore;
    final lOther$claimChore = other.claimChore;
    if (l$claimChore != lOther$claimChore) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$ClaimChore on Mutation$ClaimChore {
  CopyWith$Mutation$ClaimChore<Mutation$ClaimChore> get copyWith =>
      CopyWith$Mutation$ClaimChore(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$ClaimChore<TRes> {
  factory CopyWith$Mutation$ClaimChore(
    Mutation$ClaimChore instance,
    TRes Function(Mutation$ClaimChore) then,
  ) = _CopyWithImpl$Mutation$ClaimChore;

  factory CopyWith$Mutation$ClaimChore.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ClaimChore;

  TRes call({
    Fragment$AssignmentFields? claimChore,
    String? $__typename,
  });
  CopyWith$Fragment$AssignmentFields<TRes> get claimChore;
}

class _CopyWithImpl$Mutation$ClaimChore<TRes>
    implements CopyWith$Mutation$ClaimChore<TRes> {
  _CopyWithImpl$Mutation$ClaimChore(
    this._instance,
    this._then,
  );

  final Mutation$ClaimChore _instance;

  final TRes Function(Mutation$ClaimChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? claimChore = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ClaimChore(
        claimChore: claimChore == _undefined || claimChore == null
            ? _instance.claimChore
            : (claimChore as Fragment$AssignmentFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$AssignmentFields<TRes> get claimChore {
    final local$claimChore = _instance.claimChore;
    return CopyWith$Fragment$AssignmentFields(
        local$claimChore, (e) => call(claimChore: e));
  }
}

class _CopyWithStubImpl$Mutation$ClaimChore<TRes>
    implements CopyWith$Mutation$ClaimChore<TRes> {
  _CopyWithStubImpl$Mutation$ClaimChore(this._res);

  TRes _res;

  call({
    Fragment$AssignmentFields? claimChore,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$AssignmentFields<TRes> get claimChore =>
      CopyWith$Fragment$AssignmentFields.stub(_res);
}

const documentNodeMutationClaimChore = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ClaimChore'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'choreId')),
        type: NamedTypeNode(
          name: NameNode(value: 'UUID'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'claimChore'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'choreId'),
            value: VariableNode(name: NameNode(value: 'choreId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'AssignmentFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionAssignmentFields,
  fragmentDefinitionChoreFields,
  fragmentDefinitionUserFields,
]);

class Variables$Mutation$ArchiveChore {
  factory Variables$Mutation$ArchiveChore({required String id}) =>
      Variables$Mutation$ArchiveChore._({
        r'id': id,
      });

  Variables$Mutation$ArchiveChore._(this._$data);

  factory Variables$Mutation$ArchiveChore.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Mutation$ArchiveChore._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Mutation$ArchiveChore<Variables$Mutation$ArchiveChore>
      get copyWith => CopyWith$Variables$Mutation$ArchiveChore(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$ArchiveChore) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$id = id;
    return Object.hashAll([l$id]);
  }
}

abstract class CopyWith$Variables$Mutation$ArchiveChore<TRes> {
  factory CopyWith$Variables$Mutation$ArchiveChore(
    Variables$Mutation$ArchiveChore instance,
    TRes Function(Variables$Mutation$ArchiveChore) then,
  ) = _CopyWithImpl$Variables$Mutation$ArchiveChore;

  factory CopyWith$Variables$Mutation$ArchiveChore.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ArchiveChore;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Mutation$ArchiveChore<TRes>
    implements CopyWith$Variables$Mutation$ArchiveChore<TRes> {
  _CopyWithImpl$Variables$Mutation$ArchiveChore(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ArchiveChore _instance;

  final TRes Function(Variables$Mutation$ArchiveChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) =>
      _then(Variables$Mutation$ArchiveChore._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$ArchiveChore<TRes>
    implements CopyWith$Variables$Mutation$ArchiveChore<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ArchiveChore(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Mutation$ArchiveChore {
  Mutation$ArchiveChore({
    required this.archiveChore,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ArchiveChore.fromJson(Map<String, dynamic> json) {
    final l$archiveChore = json['archiveChore'];
    final l$$__typename = json['__typename'];
    return Mutation$ArchiveChore(
      archiveChore: Fragment$ChoreFields.fromJson(
          (l$archiveChore as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$ChoreFields archiveChore;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$archiveChore = archiveChore;
    _resultData['archiveChore'] = l$archiveChore.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$archiveChore = archiveChore;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$archiveChore,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ArchiveChore) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$archiveChore = archiveChore;
    final lOther$archiveChore = other.archiveChore;
    if (l$archiveChore != lOther$archiveChore) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$ArchiveChore on Mutation$ArchiveChore {
  CopyWith$Mutation$ArchiveChore<Mutation$ArchiveChore> get copyWith =>
      CopyWith$Mutation$ArchiveChore(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$ArchiveChore<TRes> {
  factory CopyWith$Mutation$ArchiveChore(
    Mutation$ArchiveChore instance,
    TRes Function(Mutation$ArchiveChore) then,
  ) = _CopyWithImpl$Mutation$ArchiveChore;

  factory CopyWith$Mutation$ArchiveChore.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ArchiveChore;

  TRes call({
    Fragment$ChoreFields? archiveChore,
    String? $__typename,
  });
  CopyWith$Fragment$ChoreFields<TRes> get archiveChore;
}

class _CopyWithImpl$Mutation$ArchiveChore<TRes>
    implements CopyWith$Mutation$ArchiveChore<TRes> {
  _CopyWithImpl$Mutation$ArchiveChore(
    this._instance,
    this._then,
  );

  final Mutation$ArchiveChore _instance;

  final TRes Function(Mutation$ArchiveChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? archiveChore = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ArchiveChore(
        archiveChore: archiveChore == _undefined || archiveChore == null
            ? _instance.archiveChore
            : (archiveChore as Fragment$ChoreFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$ChoreFields<TRes> get archiveChore {
    final local$archiveChore = _instance.archiveChore;
    return CopyWith$Fragment$ChoreFields(
        local$archiveChore, (e) => call(archiveChore: e));
  }
}

class _CopyWithStubImpl$Mutation$ArchiveChore<TRes>
    implements CopyWith$Mutation$ArchiveChore<TRes> {
  _CopyWithStubImpl$Mutation$ArchiveChore(this._res);

  TRes _res;

  call({
    Fragment$ChoreFields? archiveChore,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$ChoreFields<TRes> get archiveChore =>
      CopyWith$Fragment$ChoreFields.stub(_res);
}

const documentNodeMutationArchiveChore = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ArchiveChore'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'id')),
        type: NamedTypeNode(
          name: NameNode(value: 'UUID'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'archiveChore'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'id'),
            value: VariableNode(name: NameNode(value: 'id')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'ChoreFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionChoreFields,
]);

class Variables$Mutation$AssignChore {
  factory Variables$Mutation$AssignChore({
    required String choreId,
    required String assignedToUserId,
    DateTime? dueDate,
  }) =>
      Variables$Mutation$AssignChore._({
        r'choreId': choreId,
        r'assignedToUserId': assignedToUserId,
        if (dueDate != null) r'dueDate': dueDate,
      });

  Variables$Mutation$AssignChore._(this._$data);

  factory Variables$Mutation$AssignChore.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$choreId = data['choreId'];
    result$data['choreId'] = (l$choreId as String);
    final l$assignedToUserId = data['assignedToUserId'];
    result$data['assignedToUserId'] = (l$assignedToUserId as String);
    if (data.containsKey('dueDate')) {
      final l$dueDate = data['dueDate'];
      result$data['dueDate'] =
          l$dueDate == null ? null : parseDateTime(l$dueDate);
    }
    return Variables$Mutation$AssignChore._(result$data);
  }

  Map<String, dynamic> _$data;

  String get choreId => (_$data['choreId'] as String);

  String get assignedToUserId => (_$data['assignedToUserId'] as String);

  DateTime? get dueDate => (_$data['dueDate'] as DateTime?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$choreId = choreId;
    result$data['choreId'] = l$choreId;
    final l$assignedToUserId = assignedToUserId;
    result$data['assignedToUserId'] = l$assignedToUserId;
    if (_$data.containsKey('dueDate')) {
      final l$dueDate = dueDate;
      result$data['dueDate'] =
          l$dueDate == null ? null : dateTimeToIso(l$dueDate);
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$AssignChore<Variables$Mutation$AssignChore>
      get copyWith => CopyWith$Variables$Mutation$AssignChore(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$AssignChore) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$choreId = choreId;
    final lOther$choreId = other.choreId;
    if (l$choreId != lOther$choreId) {
      return false;
    }
    final l$assignedToUserId = assignedToUserId;
    final lOther$assignedToUserId = other.assignedToUserId;
    if (l$assignedToUserId != lOther$assignedToUserId) {
      return false;
    }
    final l$dueDate = dueDate;
    final lOther$dueDate = other.dueDate;
    if (_$data.containsKey('dueDate') != other._$data.containsKey('dueDate')) {
      return false;
    }
    if (l$dueDate != lOther$dueDate) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$choreId = choreId;
    final l$assignedToUserId = assignedToUserId;
    final l$dueDate = dueDate;
    return Object.hashAll([
      l$choreId,
      l$assignedToUserId,
      _$data.containsKey('dueDate') ? l$dueDate : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$AssignChore<TRes> {
  factory CopyWith$Variables$Mutation$AssignChore(
    Variables$Mutation$AssignChore instance,
    TRes Function(Variables$Mutation$AssignChore) then,
  ) = _CopyWithImpl$Variables$Mutation$AssignChore;

  factory CopyWith$Variables$Mutation$AssignChore.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$AssignChore;

  TRes call({
    String? choreId,
    String? assignedToUserId,
    DateTime? dueDate,
  });
}

class _CopyWithImpl$Variables$Mutation$AssignChore<TRes>
    implements CopyWith$Variables$Mutation$AssignChore<TRes> {
  _CopyWithImpl$Variables$Mutation$AssignChore(
    this._instance,
    this._then,
  );

  final Variables$Mutation$AssignChore _instance;

  final TRes Function(Variables$Mutation$AssignChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? choreId = _undefined,
    Object? assignedToUserId = _undefined,
    Object? dueDate = _undefined,
  }) =>
      _then(Variables$Mutation$AssignChore._({
        ..._instance._$data,
        if (choreId != _undefined && choreId != null)
          'choreId': (choreId as String),
        if (assignedToUserId != _undefined && assignedToUserId != null)
          'assignedToUserId': (assignedToUserId as String),
        if (dueDate != _undefined) 'dueDate': (dueDate as DateTime?),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$AssignChore<TRes>
    implements CopyWith$Variables$Mutation$AssignChore<TRes> {
  _CopyWithStubImpl$Variables$Mutation$AssignChore(this._res);

  TRes _res;

  call({
    String? choreId,
    String? assignedToUserId,
    DateTime? dueDate,
  }) =>
      _res;
}

class Mutation$AssignChore {
  Mutation$AssignChore({
    required this.assignChore,
    this.$__typename = 'Mutation',
  });

  factory Mutation$AssignChore.fromJson(Map<String, dynamic> json) {
    final l$assignChore = json['assignChore'];
    final l$$__typename = json['__typename'];
    return Mutation$AssignChore(
      assignChore: Fragment$AssignmentFields.fromJson(
          (l$assignChore as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AssignmentFields assignChore;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$assignChore = assignChore;
    _resultData['assignChore'] = l$assignChore.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$assignChore = assignChore;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$assignChore,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$AssignChore) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$assignChore = assignChore;
    final lOther$assignChore = other.assignChore;
    if (l$assignChore != lOther$assignChore) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$AssignChore on Mutation$AssignChore {
  CopyWith$Mutation$AssignChore<Mutation$AssignChore> get copyWith =>
      CopyWith$Mutation$AssignChore(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$AssignChore<TRes> {
  factory CopyWith$Mutation$AssignChore(
    Mutation$AssignChore instance,
    TRes Function(Mutation$AssignChore) then,
  ) = _CopyWithImpl$Mutation$AssignChore;

  factory CopyWith$Mutation$AssignChore.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AssignChore;

  TRes call({
    Fragment$AssignmentFields? assignChore,
    String? $__typename,
  });
  CopyWith$Fragment$AssignmentFields<TRes> get assignChore;
}

class _CopyWithImpl$Mutation$AssignChore<TRes>
    implements CopyWith$Mutation$AssignChore<TRes> {
  _CopyWithImpl$Mutation$AssignChore(
    this._instance,
    this._then,
  );

  final Mutation$AssignChore _instance;

  final TRes Function(Mutation$AssignChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? assignChore = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$AssignChore(
        assignChore: assignChore == _undefined || assignChore == null
            ? _instance.assignChore
            : (assignChore as Fragment$AssignmentFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$AssignmentFields<TRes> get assignChore {
    final local$assignChore = _instance.assignChore;
    return CopyWith$Fragment$AssignmentFields(
        local$assignChore, (e) => call(assignChore: e));
  }
}

class _CopyWithStubImpl$Mutation$AssignChore<TRes>
    implements CopyWith$Mutation$AssignChore<TRes> {
  _CopyWithStubImpl$Mutation$AssignChore(this._res);

  TRes _res;

  call({
    Fragment$AssignmentFields? assignChore,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$AssignmentFields<TRes> get assignChore =>
      CopyWith$Fragment$AssignmentFields.stub(_res);
}

const documentNodeMutationAssignChore = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'AssignChore'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'choreId')),
        type: NamedTypeNode(
          name: NameNode(value: 'UUID'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'assignedToUserId')),
        type: NamedTypeNode(
          name: NameNode(value: 'UUID'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'dueDate')),
        type: NamedTypeNode(
          name: NameNode(value: 'DateTime'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'assignChore'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'choreId'),
            value: VariableNode(name: NameNode(value: 'choreId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'assignedToUserId'),
            value: VariableNode(name: NameNode(value: 'assignedToUserId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'dueDate'),
            value: VariableNode(name: NameNode(value: 'dueDate')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'AssignmentFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionAssignmentFields,
  fragmentDefinitionChoreFields,
  fragmentDefinitionUserFields,
]);

class Variables$Mutation$SubmitChore {
  factory Variables$Mutation$SubmitChore({required String assignmentId}) =>
      Variables$Mutation$SubmitChore._({
        r'assignmentId': assignmentId,
      });

  Variables$Mutation$SubmitChore._(this._$data);

  factory Variables$Mutation$SubmitChore.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$assignmentId = data['assignmentId'];
    result$data['assignmentId'] = (l$assignmentId as String);
    return Variables$Mutation$SubmitChore._(result$data);
  }

  Map<String, dynamic> _$data;

  String get assignmentId => (_$data['assignmentId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$assignmentId = assignmentId;
    result$data['assignmentId'] = l$assignmentId;
    return result$data;
  }

  CopyWith$Variables$Mutation$SubmitChore<Variables$Mutation$SubmitChore>
      get copyWith => CopyWith$Variables$Mutation$SubmitChore(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$SubmitChore) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$assignmentId = assignmentId;
    final lOther$assignmentId = other.assignmentId;
    if (l$assignmentId != lOther$assignmentId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$assignmentId = assignmentId;
    return Object.hashAll([l$assignmentId]);
  }
}

abstract class CopyWith$Variables$Mutation$SubmitChore<TRes> {
  factory CopyWith$Variables$Mutation$SubmitChore(
    Variables$Mutation$SubmitChore instance,
    TRes Function(Variables$Mutation$SubmitChore) then,
  ) = _CopyWithImpl$Variables$Mutation$SubmitChore;

  factory CopyWith$Variables$Mutation$SubmitChore.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$SubmitChore;

  TRes call({String? assignmentId});
}

class _CopyWithImpl$Variables$Mutation$SubmitChore<TRes>
    implements CopyWith$Variables$Mutation$SubmitChore<TRes> {
  _CopyWithImpl$Variables$Mutation$SubmitChore(
    this._instance,
    this._then,
  );

  final Variables$Mutation$SubmitChore _instance;

  final TRes Function(Variables$Mutation$SubmitChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? assignmentId = _undefined}) =>
      _then(Variables$Mutation$SubmitChore._({
        ..._instance._$data,
        if (assignmentId != _undefined && assignmentId != null)
          'assignmentId': (assignmentId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$SubmitChore<TRes>
    implements CopyWith$Variables$Mutation$SubmitChore<TRes> {
  _CopyWithStubImpl$Variables$Mutation$SubmitChore(this._res);

  TRes _res;

  call({String? assignmentId}) => _res;
}

class Mutation$SubmitChore {
  Mutation$SubmitChore({
    required this.submitChore,
    this.$__typename = 'Mutation',
  });

  factory Mutation$SubmitChore.fromJson(Map<String, dynamic> json) {
    final l$submitChore = json['submitChore'];
    final l$$__typename = json['__typename'];
    return Mutation$SubmitChore(
      submitChore: Fragment$AssignmentFields.fromJson(
          (l$submitChore as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AssignmentFields submitChore;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$submitChore = submitChore;
    _resultData['submitChore'] = l$submitChore.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$submitChore = submitChore;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$submitChore,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$SubmitChore) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$submitChore = submitChore;
    final lOther$submitChore = other.submitChore;
    if (l$submitChore != lOther$submitChore) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$SubmitChore on Mutation$SubmitChore {
  CopyWith$Mutation$SubmitChore<Mutation$SubmitChore> get copyWith =>
      CopyWith$Mutation$SubmitChore(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$SubmitChore<TRes> {
  factory CopyWith$Mutation$SubmitChore(
    Mutation$SubmitChore instance,
    TRes Function(Mutation$SubmitChore) then,
  ) = _CopyWithImpl$Mutation$SubmitChore;

  factory CopyWith$Mutation$SubmitChore.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SubmitChore;

  TRes call({
    Fragment$AssignmentFields? submitChore,
    String? $__typename,
  });
  CopyWith$Fragment$AssignmentFields<TRes> get submitChore;
}

class _CopyWithImpl$Mutation$SubmitChore<TRes>
    implements CopyWith$Mutation$SubmitChore<TRes> {
  _CopyWithImpl$Mutation$SubmitChore(
    this._instance,
    this._then,
  );

  final Mutation$SubmitChore _instance;

  final TRes Function(Mutation$SubmitChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? submitChore = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SubmitChore(
        submitChore: submitChore == _undefined || submitChore == null
            ? _instance.submitChore
            : (submitChore as Fragment$AssignmentFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$AssignmentFields<TRes> get submitChore {
    final local$submitChore = _instance.submitChore;
    return CopyWith$Fragment$AssignmentFields(
        local$submitChore, (e) => call(submitChore: e));
  }
}

class _CopyWithStubImpl$Mutation$SubmitChore<TRes>
    implements CopyWith$Mutation$SubmitChore<TRes> {
  _CopyWithStubImpl$Mutation$SubmitChore(this._res);

  TRes _res;

  call({
    Fragment$AssignmentFields? submitChore,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$AssignmentFields<TRes> get submitChore =>
      CopyWith$Fragment$AssignmentFields.stub(_res);
}

const documentNodeMutationSubmitChore = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'SubmitChore'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'assignmentId')),
        type: NamedTypeNode(
          name: NameNode(value: 'UUID'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'submitChore'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'assignmentId'),
            value: VariableNode(name: NameNode(value: 'assignmentId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'AssignmentFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionAssignmentFields,
  fragmentDefinitionChoreFields,
  fragmentDefinitionUserFields,
]);

class Variables$Mutation$ApproveChore {
  factory Variables$Mutation$ApproveChore({required String assignmentId}) =>
      Variables$Mutation$ApproveChore._({
        r'assignmentId': assignmentId,
      });

  Variables$Mutation$ApproveChore._(this._$data);

  factory Variables$Mutation$ApproveChore.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$assignmentId = data['assignmentId'];
    result$data['assignmentId'] = (l$assignmentId as String);
    return Variables$Mutation$ApproveChore._(result$data);
  }

  Map<String, dynamic> _$data;

  String get assignmentId => (_$data['assignmentId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$assignmentId = assignmentId;
    result$data['assignmentId'] = l$assignmentId;
    return result$data;
  }

  CopyWith$Variables$Mutation$ApproveChore<Variables$Mutation$ApproveChore>
      get copyWith => CopyWith$Variables$Mutation$ApproveChore(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$ApproveChore) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$assignmentId = assignmentId;
    final lOther$assignmentId = other.assignmentId;
    if (l$assignmentId != lOther$assignmentId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$assignmentId = assignmentId;
    return Object.hashAll([l$assignmentId]);
  }
}

abstract class CopyWith$Variables$Mutation$ApproveChore<TRes> {
  factory CopyWith$Variables$Mutation$ApproveChore(
    Variables$Mutation$ApproveChore instance,
    TRes Function(Variables$Mutation$ApproveChore) then,
  ) = _CopyWithImpl$Variables$Mutation$ApproveChore;

  factory CopyWith$Variables$Mutation$ApproveChore.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ApproveChore;

  TRes call({String? assignmentId});
}

class _CopyWithImpl$Variables$Mutation$ApproveChore<TRes>
    implements CopyWith$Variables$Mutation$ApproveChore<TRes> {
  _CopyWithImpl$Variables$Mutation$ApproveChore(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ApproveChore _instance;

  final TRes Function(Variables$Mutation$ApproveChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? assignmentId = _undefined}) =>
      _then(Variables$Mutation$ApproveChore._({
        ..._instance._$data,
        if (assignmentId != _undefined && assignmentId != null)
          'assignmentId': (assignmentId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$ApproveChore<TRes>
    implements CopyWith$Variables$Mutation$ApproveChore<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ApproveChore(this._res);

  TRes _res;

  call({String? assignmentId}) => _res;
}

class Mutation$ApproveChore {
  Mutation$ApproveChore({
    required this.approveChore,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ApproveChore.fromJson(Map<String, dynamic> json) {
    final l$approveChore = json['approveChore'];
    final l$$__typename = json['__typename'];
    return Mutation$ApproveChore(
      approveChore: Fragment$AssignmentFields.fromJson(
          (l$approveChore as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AssignmentFields approveChore;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$approveChore = approveChore;
    _resultData['approveChore'] = l$approveChore.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$approveChore = approveChore;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$approveChore,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ApproveChore) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$approveChore = approveChore;
    final lOther$approveChore = other.approveChore;
    if (l$approveChore != lOther$approveChore) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$ApproveChore on Mutation$ApproveChore {
  CopyWith$Mutation$ApproveChore<Mutation$ApproveChore> get copyWith =>
      CopyWith$Mutation$ApproveChore(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$ApproveChore<TRes> {
  factory CopyWith$Mutation$ApproveChore(
    Mutation$ApproveChore instance,
    TRes Function(Mutation$ApproveChore) then,
  ) = _CopyWithImpl$Mutation$ApproveChore;

  factory CopyWith$Mutation$ApproveChore.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ApproveChore;

  TRes call({
    Fragment$AssignmentFields? approveChore,
    String? $__typename,
  });
  CopyWith$Fragment$AssignmentFields<TRes> get approveChore;
}

class _CopyWithImpl$Mutation$ApproveChore<TRes>
    implements CopyWith$Mutation$ApproveChore<TRes> {
  _CopyWithImpl$Mutation$ApproveChore(
    this._instance,
    this._then,
  );

  final Mutation$ApproveChore _instance;

  final TRes Function(Mutation$ApproveChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? approveChore = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ApproveChore(
        approveChore: approveChore == _undefined || approveChore == null
            ? _instance.approveChore
            : (approveChore as Fragment$AssignmentFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$AssignmentFields<TRes> get approveChore {
    final local$approveChore = _instance.approveChore;
    return CopyWith$Fragment$AssignmentFields(
        local$approveChore, (e) => call(approveChore: e));
  }
}

class _CopyWithStubImpl$Mutation$ApproveChore<TRes>
    implements CopyWith$Mutation$ApproveChore<TRes> {
  _CopyWithStubImpl$Mutation$ApproveChore(this._res);

  TRes _res;

  call({
    Fragment$AssignmentFields? approveChore,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$AssignmentFields<TRes> get approveChore =>
      CopyWith$Fragment$AssignmentFields.stub(_res);
}

const documentNodeMutationApproveChore = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ApproveChore'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'assignmentId')),
        type: NamedTypeNode(
          name: NameNode(value: 'UUID'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'approveChore'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'assignmentId'),
            value: VariableNode(name: NameNode(value: 'assignmentId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'AssignmentFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionAssignmentFields,
  fragmentDefinitionChoreFields,
  fragmentDefinitionUserFields,
]);

class Variables$Mutation$RejectChore {
  factory Variables$Mutation$RejectChore({
    required String assignmentId,
    String? reason,
  }) =>
      Variables$Mutation$RejectChore._({
        r'assignmentId': assignmentId,
        if (reason != null) r'reason': reason,
      });

  Variables$Mutation$RejectChore._(this._$data);

  factory Variables$Mutation$RejectChore.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$assignmentId = data['assignmentId'];
    result$data['assignmentId'] = (l$assignmentId as String);
    if (data.containsKey('reason')) {
      final l$reason = data['reason'];
      result$data['reason'] = (l$reason as String?);
    }
    return Variables$Mutation$RejectChore._(result$data);
  }

  Map<String, dynamic> _$data;

  String get assignmentId => (_$data['assignmentId'] as String);

  String? get reason => (_$data['reason'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$assignmentId = assignmentId;
    result$data['assignmentId'] = l$assignmentId;
    if (_$data.containsKey('reason')) {
      final l$reason = reason;
      result$data['reason'] = l$reason;
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$RejectChore<Variables$Mutation$RejectChore>
      get copyWith => CopyWith$Variables$Mutation$RejectChore(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$RejectChore) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$assignmentId = assignmentId;
    final lOther$assignmentId = other.assignmentId;
    if (l$assignmentId != lOther$assignmentId) {
      return false;
    }
    final l$reason = reason;
    final lOther$reason = other.reason;
    if (_$data.containsKey('reason') != other._$data.containsKey('reason')) {
      return false;
    }
    if (l$reason != lOther$reason) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$assignmentId = assignmentId;
    final l$reason = reason;
    return Object.hashAll([
      l$assignmentId,
      _$data.containsKey('reason') ? l$reason : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$RejectChore<TRes> {
  factory CopyWith$Variables$Mutation$RejectChore(
    Variables$Mutation$RejectChore instance,
    TRes Function(Variables$Mutation$RejectChore) then,
  ) = _CopyWithImpl$Variables$Mutation$RejectChore;

  factory CopyWith$Variables$Mutation$RejectChore.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RejectChore;

  TRes call({
    String? assignmentId,
    String? reason,
  });
}

class _CopyWithImpl$Variables$Mutation$RejectChore<TRes>
    implements CopyWith$Variables$Mutation$RejectChore<TRes> {
  _CopyWithImpl$Variables$Mutation$RejectChore(
    this._instance,
    this._then,
  );

  final Variables$Mutation$RejectChore _instance;

  final TRes Function(Variables$Mutation$RejectChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? assignmentId = _undefined,
    Object? reason = _undefined,
  }) =>
      _then(Variables$Mutation$RejectChore._({
        ..._instance._$data,
        if (assignmentId != _undefined && assignmentId != null)
          'assignmentId': (assignmentId as String),
        if (reason != _undefined) 'reason': (reason as String?),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$RejectChore<TRes>
    implements CopyWith$Variables$Mutation$RejectChore<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RejectChore(this._res);

  TRes _res;

  call({
    String? assignmentId,
    String? reason,
  }) =>
      _res;
}

class Mutation$RejectChore {
  Mutation$RejectChore({
    required this.rejectChore,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RejectChore.fromJson(Map<String, dynamic> json) {
    final l$rejectChore = json['rejectChore'];
    final l$$__typename = json['__typename'];
    return Mutation$RejectChore(
      rejectChore: Fragment$AssignmentFields.fromJson(
          (l$rejectChore as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$AssignmentFields rejectChore;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$rejectChore = rejectChore;
    _resultData['rejectChore'] = l$rejectChore.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$rejectChore = rejectChore;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$rejectChore,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RejectChore) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$rejectChore = rejectChore;
    final lOther$rejectChore = other.rejectChore;
    if (l$rejectChore != lOther$rejectChore) {
      return false;
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Mutation$RejectChore on Mutation$RejectChore {
  CopyWith$Mutation$RejectChore<Mutation$RejectChore> get copyWith =>
      CopyWith$Mutation$RejectChore(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$RejectChore<TRes> {
  factory CopyWith$Mutation$RejectChore(
    Mutation$RejectChore instance,
    TRes Function(Mutation$RejectChore) then,
  ) = _CopyWithImpl$Mutation$RejectChore;

  factory CopyWith$Mutation$RejectChore.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RejectChore;

  TRes call({
    Fragment$AssignmentFields? rejectChore,
    String? $__typename,
  });
  CopyWith$Fragment$AssignmentFields<TRes> get rejectChore;
}

class _CopyWithImpl$Mutation$RejectChore<TRes>
    implements CopyWith$Mutation$RejectChore<TRes> {
  _CopyWithImpl$Mutation$RejectChore(
    this._instance,
    this._then,
  );

  final Mutation$RejectChore _instance;

  final TRes Function(Mutation$RejectChore) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? rejectChore = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RejectChore(
        rejectChore: rejectChore == _undefined || rejectChore == null
            ? _instance.rejectChore
            : (rejectChore as Fragment$AssignmentFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$AssignmentFields<TRes> get rejectChore {
    final local$rejectChore = _instance.rejectChore;
    return CopyWith$Fragment$AssignmentFields(
        local$rejectChore, (e) => call(rejectChore: e));
  }
}

class _CopyWithStubImpl$Mutation$RejectChore<TRes>
    implements CopyWith$Mutation$RejectChore<TRes> {
  _CopyWithStubImpl$Mutation$RejectChore(this._res);

  TRes _res;

  call({
    Fragment$AssignmentFields? rejectChore,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$AssignmentFields<TRes> get rejectChore =>
      CopyWith$Fragment$AssignmentFields.stub(_res);
}

const documentNodeMutationRejectChore = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'RejectChore'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'assignmentId')),
        type: NamedTypeNode(
          name: NameNode(value: 'UUID'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'reason')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'rejectChore'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'assignmentId'),
            value: VariableNode(name: NameNode(value: 'assignmentId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'reason'),
            value: VariableNode(name: NameNode(value: 'reason')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'AssignmentFields'),
            directives: [],
          ),
          FieldNode(
            name: NameNode(value: '__typename'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
        ]),
      ),
      FieldNode(
        name: NameNode(value: '__typename'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: null,
      ),
    ]),
  ),
  fragmentDefinitionAssignmentFields,
  fragmentDefinitionChoreFields,
  fragmentDefinitionUserFields,
]);
