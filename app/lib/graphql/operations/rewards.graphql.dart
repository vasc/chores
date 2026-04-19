import 'fragments.graphql.dart';
import 'package:gql/ast.dart';

class Variables$Mutation$CreateReward {
  factory Variables$Mutation$CreateReward({
    required String title,
    String? description,
    required int tokenCost,
  }) =>
      Variables$Mutation$CreateReward._({
        r'title': title,
        if (description != null) r'description': description,
        r'tokenCost': tokenCost,
      });

  Variables$Mutation$CreateReward._(this._$data);

  factory Variables$Mutation$CreateReward.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$title = data['title'];
    result$data['title'] = (l$title as String);
    if (data.containsKey('description')) {
      final l$description = data['description'];
      result$data['description'] = (l$description as String?);
    }
    final l$tokenCost = data['tokenCost'];
    result$data['tokenCost'] = (l$tokenCost as int);
    return Variables$Mutation$CreateReward._(result$data);
  }

  Map<String, dynamic> _$data;

  String get title => (_$data['title'] as String);

  String? get description => (_$data['description'] as String?);

  int get tokenCost => (_$data['tokenCost'] as int);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$title = title;
    result$data['title'] = l$title;
    if (_$data.containsKey('description')) {
      final l$description = description;
      result$data['description'] = l$description;
    }
    final l$tokenCost = tokenCost;
    result$data['tokenCost'] = l$tokenCost;
    return result$data;
  }

  CopyWith$Variables$Mutation$CreateReward<Variables$Mutation$CreateReward>
      get copyWith => CopyWith$Variables$Mutation$CreateReward(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$CreateReward) ||
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
    final l$tokenCost = tokenCost;
    final lOther$tokenCost = other.tokenCost;
    if (l$tokenCost != lOther$tokenCost) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$title = title;
    final l$description = description;
    final l$tokenCost = tokenCost;
    return Object.hashAll([
      l$title,
      _$data.containsKey('description') ? l$description : const {},
      l$tokenCost,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$CreateReward<TRes> {
  factory CopyWith$Variables$Mutation$CreateReward(
    Variables$Mutation$CreateReward instance,
    TRes Function(Variables$Mutation$CreateReward) then,
  ) = _CopyWithImpl$Variables$Mutation$CreateReward;

  factory CopyWith$Variables$Mutation$CreateReward.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$CreateReward;

  TRes call({
    String? title,
    String? description,
    int? tokenCost,
  });
}

class _CopyWithImpl$Variables$Mutation$CreateReward<TRes>
    implements CopyWith$Variables$Mutation$CreateReward<TRes> {
  _CopyWithImpl$Variables$Mutation$CreateReward(
    this._instance,
    this._then,
  );

  final Variables$Mutation$CreateReward _instance;

  final TRes Function(Variables$Mutation$CreateReward) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? title = _undefined,
    Object? description = _undefined,
    Object? tokenCost = _undefined,
  }) =>
      _then(Variables$Mutation$CreateReward._({
        ..._instance._$data,
        if (title != _undefined && title != null) 'title': (title as String),
        if (description != _undefined) 'description': (description as String?),
        if (tokenCost != _undefined && tokenCost != null)
          'tokenCost': (tokenCost as int),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$CreateReward<TRes>
    implements CopyWith$Variables$Mutation$CreateReward<TRes> {
  _CopyWithStubImpl$Variables$Mutation$CreateReward(this._res);

  TRes _res;

  call({
    String? title,
    String? description,
    int? tokenCost,
  }) =>
      _res;
}

class Mutation$CreateReward {
  Mutation$CreateReward({
    required this.createReward,
    this.$__typename = 'Mutation',
  });

  factory Mutation$CreateReward.fromJson(Map<String, dynamic> json) {
    final l$createReward = json['createReward'];
    final l$$__typename = json['__typename'];
    return Mutation$CreateReward(
      createReward: Fragment$RewardFields.fromJson(
          (l$createReward as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$RewardFields createReward;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$createReward = createReward;
    _resultData['createReward'] = l$createReward.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$createReward = createReward;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$createReward,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$CreateReward) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$createReward = createReward;
    final lOther$createReward = other.createReward;
    if (l$createReward != lOther$createReward) {
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

extension UtilityExtension$Mutation$CreateReward on Mutation$CreateReward {
  CopyWith$Mutation$CreateReward<Mutation$CreateReward> get copyWith =>
      CopyWith$Mutation$CreateReward(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$CreateReward<TRes> {
  factory CopyWith$Mutation$CreateReward(
    Mutation$CreateReward instance,
    TRes Function(Mutation$CreateReward) then,
  ) = _CopyWithImpl$Mutation$CreateReward;

  factory CopyWith$Mutation$CreateReward.stub(TRes res) =
      _CopyWithStubImpl$Mutation$CreateReward;

  TRes call({
    Fragment$RewardFields? createReward,
    String? $__typename,
  });
  CopyWith$Fragment$RewardFields<TRes> get createReward;
}

class _CopyWithImpl$Mutation$CreateReward<TRes>
    implements CopyWith$Mutation$CreateReward<TRes> {
  _CopyWithImpl$Mutation$CreateReward(
    this._instance,
    this._then,
  );

  final Mutation$CreateReward _instance;

  final TRes Function(Mutation$CreateReward) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? createReward = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$CreateReward(
        createReward: createReward == _undefined || createReward == null
            ? _instance.createReward
            : (createReward as Fragment$RewardFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$RewardFields<TRes> get createReward {
    final local$createReward = _instance.createReward;
    return CopyWith$Fragment$RewardFields(
        local$createReward, (e) => call(createReward: e));
  }
}

class _CopyWithStubImpl$Mutation$CreateReward<TRes>
    implements CopyWith$Mutation$CreateReward<TRes> {
  _CopyWithStubImpl$Mutation$CreateReward(this._res);

  TRes _res;

  call({
    Fragment$RewardFields? createReward,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$RewardFields<TRes> get createReward =>
      CopyWith$Fragment$RewardFields.stub(_res);
}

const documentNodeMutationCreateReward = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'CreateReward'),
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
        variable: VariableNode(name: NameNode(value: 'tokenCost')),
        type: NamedTypeNode(
          name: NameNode(value: 'Int'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'createReward'),
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
            name: NameNode(value: 'tokenCost'),
            value: VariableNode(name: NameNode(value: 'tokenCost')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'RewardFields'),
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
  fragmentDefinitionRewardFields,
]);

class Variables$Mutation$ArchiveReward {
  factory Variables$Mutation$ArchiveReward({required String id}) =>
      Variables$Mutation$ArchiveReward._({
        r'id': id,
      });

  Variables$Mutation$ArchiveReward._(this._$data);

  factory Variables$Mutation$ArchiveReward.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Mutation$ArchiveReward._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Mutation$ArchiveReward<Variables$Mutation$ArchiveReward>
      get copyWith => CopyWith$Variables$Mutation$ArchiveReward(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$ArchiveReward) ||
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

abstract class CopyWith$Variables$Mutation$ArchiveReward<TRes> {
  factory CopyWith$Variables$Mutation$ArchiveReward(
    Variables$Mutation$ArchiveReward instance,
    TRes Function(Variables$Mutation$ArchiveReward) then,
  ) = _CopyWithImpl$Variables$Mutation$ArchiveReward;

  factory CopyWith$Variables$Mutation$ArchiveReward.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ArchiveReward;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Mutation$ArchiveReward<TRes>
    implements CopyWith$Variables$Mutation$ArchiveReward<TRes> {
  _CopyWithImpl$Variables$Mutation$ArchiveReward(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ArchiveReward _instance;

  final TRes Function(Variables$Mutation$ArchiveReward) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) =>
      _then(Variables$Mutation$ArchiveReward._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$ArchiveReward<TRes>
    implements CopyWith$Variables$Mutation$ArchiveReward<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ArchiveReward(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Mutation$ArchiveReward {
  Mutation$ArchiveReward({
    required this.archiveReward,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ArchiveReward.fromJson(Map<String, dynamic> json) {
    final l$archiveReward = json['archiveReward'];
    final l$$__typename = json['__typename'];
    return Mutation$ArchiveReward(
      archiveReward: Fragment$RewardFields.fromJson(
          (l$archiveReward as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$RewardFields archiveReward;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$archiveReward = archiveReward;
    _resultData['archiveReward'] = l$archiveReward.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$archiveReward = archiveReward;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$archiveReward,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ArchiveReward) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$archiveReward = archiveReward;
    final lOther$archiveReward = other.archiveReward;
    if (l$archiveReward != lOther$archiveReward) {
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

extension UtilityExtension$Mutation$ArchiveReward on Mutation$ArchiveReward {
  CopyWith$Mutation$ArchiveReward<Mutation$ArchiveReward> get copyWith =>
      CopyWith$Mutation$ArchiveReward(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$ArchiveReward<TRes> {
  factory CopyWith$Mutation$ArchiveReward(
    Mutation$ArchiveReward instance,
    TRes Function(Mutation$ArchiveReward) then,
  ) = _CopyWithImpl$Mutation$ArchiveReward;

  factory CopyWith$Mutation$ArchiveReward.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ArchiveReward;

  TRes call({
    Fragment$RewardFields? archiveReward,
    String? $__typename,
  });
  CopyWith$Fragment$RewardFields<TRes> get archiveReward;
}

class _CopyWithImpl$Mutation$ArchiveReward<TRes>
    implements CopyWith$Mutation$ArchiveReward<TRes> {
  _CopyWithImpl$Mutation$ArchiveReward(
    this._instance,
    this._then,
  );

  final Mutation$ArchiveReward _instance;

  final TRes Function(Mutation$ArchiveReward) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? archiveReward = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ArchiveReward(
        archiveReward: archiveReward == _undefined || archiveReward == null
            ? _instance.archiveReward
            : (archiveReward as Fragment$RewardFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$RewardFields<TRes> get archiveReward {
    final local$archiveReward = _instance.archiveReward;
    return CopyWith$Fragment$RewardFields(
        local$archiveReward, (e) => call(archiveReward: e));
  }
}

class _CopyWithStubImpl$Mutation$ArchiveReward<TRes>
    implements CopyWith$Mutation$ArchiveReward<TRes> {
  _CopyWithStubImpl$Mutation$ArchiveReward(this._res);

  TRes _res;

  call({
    Fragment$RewardFields? archiveReward,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$RewardFields<TRes> get archiveReward =>
      CopyWith$Fragment$RewardFields.stub(_res);
}

const documentNodeMutationArchiveReward = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ArchiveReward'),
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
        name: NameNode(value: 'archiveReward'),
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
            name: NameNode(value: 'RewardFields'),
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
  fragmentDefinitionRewardFields,
]);

class Variables$Mutation$RequestRedemption {
  factory Variables$Mutation$RequestRedemption({required String rewardId}) =>
      Variables$Mutation$RequestRedemption._({
        r'rewardId': rewardId,
      });

  Variables$Mutation$RequestRedemption._(this._$data);

  factory Variables$Mutation$RequestRedemption.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$rewardId = data['rewardId'];
    result$data['rewardId'] = (l$rewardId as String);
    return Variables$Mutation$RequestRedemption._(result$data);
  }

  Map<String, dynamic> _$data;

  String get rewardId => (_$data['rewardId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$rewardId = rewardId;
    result$data['rewardId'] = l$rewardId;
    return result$data;
  }

  CopyWith$Variables$Mutation$RequestRedemption<
          Variables$Mutation$RequestRedemption>
      get copyWith => CopyWith$Variables$Mutation$RequestRedemption(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$RequestRedemption) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$rewardId = rewardId;
    final lOther$rewardId = other.rewardId;
    if (l$rewardId != lOther$rewardId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$rewardId = rewardId;
    return Object.hashAll([l$rewardId]);
  }
}

abstract class CopyWith$Variables$Mutation$RequestRedemption<TRes> {
  factory CopyWith$Variables$Mutation$RequestRedemption(
    Variables$Mutation$RequestRedemption instance,
    TRes Function(Variables$Mutation$RequestRedemption) then,
  ) = _CopyWithImpl$Variables$Mutation$RequestRedemption;

  factory CopyWith$Variables$Mutation$RequestRedemption.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$RequestRedemption;

  TRes call({String? rewardId});
}

class _CopyWithImpl$Variables$Mutation$RequestRedemption<TRes>
    implements CopyWith$Variables$Mutation$RequestRedemption<TRes> {
  _CopyWithImpl$Variables$Mutation$RequestRedemption(
    this._instance,
    this._then,
  );

  final Variables$Mutation$RequestRedemption _instance;

  final TRes Function(Variables$Mutation$RequestRedemption) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? rewardId = _undefined}) =>
      _then(Variables$Mutation$RequestRedemption._({
        ..._instance._$data,
        if (rewardId != _undefined && rewardId != null)
          'rewardId': (rewardId as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$RequestRedemption<TRes>
    implements CopyWith$Variables$Mutation$RequestRedemption<TRes> {
  _CopyWithStubImpl$Variables$Mutation$RequestRedemption(this._res);

  TRes _res;

  call({String? rewardId}) => _res;
}

class Mutation$RequestRedemption {
  Mutation$RequestRedemption({
    required this.requestRedemption,
    this.$__typename = 'Mutation',
  });

  factory Mutation$RequestRedemption.fromJson(Map<String, dynamic> json) {
    final l$requestRedemption = json['requestRedemption'];
    final l$$__typename = json['__typename'];
    return Mutation$RequestRedemption(
      requestRedemption: Fragment$RedemptionFields.fromJson(
          (l$requestRedemption as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$RedemptionFields requestRedemption;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$requestRedemption = requestRedemption;
    _resultData['requestRedemption'] = l$requestRedemption.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$requestRedemption = requestRedemption;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$requestRedemption,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$RequestRedemption) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$requestRedemption = requestRedemption;
    final lOther$requestRedemption = other.requestRedemption;
    if (l$requestRedemption != lOther$requestRedemption) {
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

extension UtilityExtension$Mutation$RequestRedemption
    on Mutation$RequestRedemption {
  CopyWith$Mutation$RequestRedemption<Mutation$RequestRedemption>
      get copyWith => CopyWith$Mutation$RequestRedemption(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$RequestRedemption<TRes> {
  factory CopyWith$Mutation$RequestRedemption(
    Mutation$RequestRedemption instance,
    TRes Function(Mutation$RequestRedemption) then,
  ) = _CopyWithImpl$Mutation$RequestRedemption;

  factory CopyWith$Mutation$RequestRedemption.stub(TRes res) =
      _CopyWithStubImpl$Mutation$RequestRedemption;

  TRes call({
    Fragment$RedemptionFields? requestRedemption,
    String? $__typename,
  });
  CopyWith$Fragment$RedemptionFields<TRes> get requestRedemption;
}

class _CopyWithImpl$Mutation$RequestRedemption<TRes>
    implements CopyWith$Mutation$RequestRedemption<TRes> {
  _CopyWithImpl$Mutation$RequestRedemption(
    this._instance,
    this._then,
  );

  final Mutation$RequestRedemption _instance;

  final TRes Function(Mutation$RequestRedemption) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? requestRedemption = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$RequestRedemption(
        requestRedemption:
            requestRedemption == _undefined || requestRedemption == null
                ? _instance.requestRedemption
                : (requestRedemption as Fragment$RedemptionFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$RedemptionFields<TRes> get requestRedemption {
    final local$requestRedemption = _instance.requestRedemption;
    return CopyWith$Fragment$RedemptionFields(
        local$requestRedemption, (e) => call(requestRedemption: e));
  }
}

class _CopyWithStubImpl$Mutation$RequestRedemption<TRes>
    implements CopyWith$Mutation$RequestRedemption<TRes> {
  _CopyWithStubImpl$Mutation$RequestRedemption(this._res);

  TRes _res;

  call({
    Fragment$RedemptionFields? requestRedemption,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$RedemptionFields<TRes> get requestRedemption =>
      CopyWith$Fragment$RedemptionFields.stub(_res);
}

const documentNodeMutationRequestRedemption = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'RequestRedemption'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'rewardId')),
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
        name: NameNode(value: 'requestRedemption'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'rewardId'),
            value: VariableNode(name: NameNode(value: 'rewardId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'RedemptionFields'),
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
  fragmentDefinitionRedemptionFields,
  fragmentDefinitionRewardFields,
  fragmentDefinitionUserFields,
]);

class Variables$Mutation$ApproveRedemption {
  factory Variables$Mutation$ApproveRedemption({required String id}) =>
      Variables$Mutation$ApproveRedemption._({
        r'id': id,
      });

  Variables$Mutation$ApproveRedemption._(this._$data);

  factory Variables$Mutation$ApproveRedemption.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Mutation$ApproveRedemption._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Mutation$ApproveRedemption<
          Variables$Mutation$ApproveRedemption>
      get copyWith => CopyWith$Variables$Mutation$ApproveRedemption(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$ApproveRedemption) ||
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

abstract class CopyWith$Variables$Mutation$ApproveRedemption<TRes> {
  factory CopyWith$Variables$Mutation$ApproveRedemption(
    Variables$Mutation$ApproveRedemption instance,
    TRes Function(Variables$Mutation$ApproveRedemption) then,
  ) = _CopyWithImpl$Variables$Mutation$ApproveRedemption;

  factory CopyWith$Variables$Mutation$ApproveRedemption.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$ApproveRedemption;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Mutation$ApproveRedemption<TRes>
    implements CopyWith$Variables$Mutation$ApproveRedemption<TRes> {
  _CopyWithImpl$Variables$Mutation$ApproveRedemption(
    this._instance,
    this._then,
  );

  final Variables$Mutation$ApproveRedemption _instance;

  final TRes Function(Variables$Mutation$ApproveRedemption) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) =>
      _then(Variables$Mutation$ApproveRedemption._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$ApproveRedemption<TRes>
    implements CopyWith$Variables$Mutation$ApproveRedemption<TRes> {
  _CopyWithStubImpl$Variables$Mutation$ApproveRedemption(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Mutation$ApproveRedemption {
  Mutation$ApproveRedemption({
    required this.approveRedemption,
    this.$__typename = 'Mutation',
  });

  factory Mutation$ApproveRedemption.fromJson(Map<String, dynamic> json) {
    final l$approveRedemption = json['approveRedemption'];
    final l$$__typename = json['__typename'];
    return Mutation$ApproveRedemption(
      approveRedemption: Fragment$RedemptionFields.fromJson(
          (l$approveRedemption as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$RedemptionFields approveRedemption;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$approveRedemption = approveRedemption;
    _resultData['approveRedemption'] = l$approveRedemption.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$approveRedemption = approveRedemption;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$approveRedemption,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$ApproveRedemption) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$approveRedemption = approveRedemption;
    final lOther$approveRedemption = other.approveRedemption;
    if (l$approveRedemption != lOther$approveRedemption) {
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

extension UtilityExtension$Mutation$ApproveRedemption
    on Mutation$ApproveRedemption {
  CopyWith$Mutation$ApproveRedemption<Mutation$ApproveRedemption>
      get copyWith => CopyWith$Mutation$ApproveRedemption(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$ApproveRedemption<TRes> {
  factory CopyWith$Mutation$ApproveRedemption(
    Mutation$ApproveRedemption instance,
    TRes Function(Mutation$ApproveRedemption) then,
  ) = _CopyWithImpl$Mutation$ApproveRedemption;

  factory CopyWith$Mutation$ApproveRedemption.stub(TRes res) =
      _CopyWithStubImpl$Mutation$ApproveRedemption;

  TRes call({
    Fragment$RedemptionFields? approveRedemption,
    String? $__typename,
  });
  CopyWith$Fragment$RedemptionFields<TRes> get approveRedemption;
}

class _CopyWithImpl$Mutation$ApproveRedemption<TRes>
    implements CopyWith$Mutation$ApproveRedemption<TRes> {
  _CopyWithImpl$Mutation$ApproveRedemption(
    this._instance,
    this._then,
  );

  final Mutation$ApproveRedemption _instance;

  final TRes Function(Mutation$ApproveRedemption) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? approveRedemption = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$ApproveRedemption(
        approveRedemption:
            approveRedemption == _undefined || approveRedemption == null
                ? _instance.approveRedemption
                : (approveRedemption as Fragment$RedemptionFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$RedemptionFields<TRes> get approveRedemption {
    final local$approveRedemption = _instance.approveRedemption;
    return CopyWith$Fragment$RedemptionFields(
        local$approveRedemption, (e) => call(approveRedemption: e));
  }
}

class _CopyWithStubImpl$Mutation$ApproveRedemption<TRes>
    implements CopyWith$Mutation$ApproveRedemption<TRes> {
  _CopyWithStubImpl$Mutation$ApproveRedemption(this._res);

  TRes _res;

  call({
    Fragment$RedemptionFields? approveRedemption,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$RedemptionFields<TRes> get approveRedemption =>
      CopyWith$Fragment$RedemptionFields.stub(_res);
}

const documentNodeMutationApproveRedemption = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'ApproveRedemption'),
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
        name: NameNode(value: 'approveRedemption'),
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
            name: NameNode(value: 'RedemptionFields'),
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
  fragmentDefinitionRedemptionFields,
  fragmentDefinitionRewardFields,
  fragmentDefinitionUserFields,
]);

class Variables$Mutation$DenyRedemption {
  factory Variables$Mutation$DenyRedemption({
    required String id,
    String? reason,
  }) =>
      Variables$Mutation$DenyRedemption._({
        r'id': id,
        if (reason != null) r'reason': reason,
      });

  Variables$Mutation$DenyRedemption._(this._$data);

  factory Variables$Mutation$DenyRedemption.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    if (data.containsKey('reason')) {
      final l$reason = data['reason'];
      result$data['reason'] = (l$reason as String?);
    }
    return Variables$Mutation$DenyRedemption._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  String? get reason => (_$data['reason'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    if (_$data.containsKey('reason')) {
      final l$reason = reason;
      result$data['reason'] = l$reason;
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$DenyRedemption<Variables$Mutation$DenyRedemption>
      get copyWith => CopyWith$Variables$Mutation$DenyRedemption(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$DenyRedemption) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
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
    final l$id = id;
    final l$reason = reason;
    return Object.hashAll([
      l$id,
      _$data.containsKey('reason') ? l$reason : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$DenyRedemption<TRes> {
  factory CopyWith$Variables$Mutation$DenyRedemption(
    Variables$Mutation$DenyRedemption instance,
    TRes Function(Variables$Mutation$DenyRedemption) then,
  ) = _CopyWithImpl$Variables$Mutation$DenyRedemption;

  factory CopyWith$Variables$Mutation$DenyRedemption.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$DenyRedemption;

  TRes call({
    String? id,
    String? reason,
  });
}

class _CopyWithImpl$Variables$Mutation$DenyRedemption<TRes>
    implements CopyWith$Variables$Mutation$DenyRedemption<TRes> {
  _CopyWithImpl$Variables$Mutation$DenyRedemption(
    this._instance,
    this._then,
  );

  final Variables$Mutation$DenyRedemption _instance;

  final TRes Function(Variables$Mutation$DenyRedemption) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? reason = _undefined,
  }) =>
      _then(Variables$Mutation$DenyRedemption._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
        if (reason != _undefined) 'reason': (reason as String?),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$DenyRedemption<TRes>
    implements CopyWith$Variables$Mutation$DenyRedemption<TRes> {
  _CopyWithStubImpl$Variables$Mutation$DenyRedemption(this._res);

  TRes _res;

  call({
    String? id,
    String? reason,
  }) =>
      _res;
}

class Mutation$DenyRedemption {
  Mutation$DenyRedemption({
    required this.denyRedemption,
    this.$__typename = 'Mutation',
  });

  factory Mutation$DenyRedemption.fromJson(Map<String, dynamic> json) {
    final l$denyRedemption = json['denyRedemption'];
    final l$$__typename = json['__typename'];
    return Mutation$DenyRedemption(
      denyRedemption: Fragment$RedemptionFields.fromJson(
          (l$denyRedemption as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$RedemptionFields denyRedemption;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$denyRedemption = denyRedemption;
    _resultData['denyRedemption'] = l$denyRedemption.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$denyRedemption = denyRedemption;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$denyRedemption,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$DenyRedemption) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$denyRedemption = denyRedemption;
    final lOther$denyRedemption = other.denyRedemption;
    if (l$denyRedemption != lOther$denyRedemption) {
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

extension UtilityExtension$Mutation$DenyRedemption on Mutation$DenyRedemption {
  CopyWith$Mutation$DenyRedemption<Mutation$DenyRedemption> get copyWith =>
      CopyWith$Mutation$DenyRedemption(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$DenyRedemption<TRes> {
  factory CopyWith$Mutation$DenyRedemption(
    Mutation$DenyRedemption instance,
    TRes Function(Mutation$DenyRedemption) then,
  ) = _CopyWithImpl$Mutation$DenyRedemption;

  factory CopyWith$Mutation$DenyRedemption.stub(TRes res) =
      _CopyWithStubImpl$Mutation$DenyRedemption;

  TRes call({
    Fragment$RedemptionFields? denyRedemption,
    String? $__typename,
  });
  CopyWith$Fragment$RedemptionFields<TRes> get denyRedemption;
}

class _CopyWithImpl$Mutation$DenyRedemption<TRes>
    implements CopyWith$Mutation$DenyRedemption<TRes> {
  _CopyWithImpl$Mutation$DenyRedemption(
    this._instance,
    this._then,
  );

  final Mutation$DenyRedemption _instance;

  final TRes Function(Mutation$DenyRedemption) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? denyRedemption = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$DenyRedemption(
        denyRedemption: denyRedemption == _undefined || denyRedemption == null
            ? _instance.denyRedemption
            : (denyRedemption as Fragment$RedemptionFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$RedemptionFields<TRes> get denyRedemption {
    final local$denyRedemption = _instance.denyRedemption;
    return CopyWith$Fragment$RedemptionFields(
        local$denyRedemption, (e) => call(denyRedemption: e));
  }
}

class _CopyWithStubImpl$Mutation$DenyRedemption<TRes>
    implements CopyWith$Mutation$DenyRedemption<TRes> {
  _CopyWithStubImpl$Mutation$DenyRedemption(this._res);

  TRes _res;

  call({
    Fragment$RedemptionFields? denyRedemption,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$RedemptionFields<TRes> get denyRedemption =>
      CopyWith$Fragment$RedemptionFields.stub(_res);
}

const documentNodeMutationDenyRedemption = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'DenyRedemption'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'id')),
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
        name: NameNode(value: 'denyRedemption'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'id'),
            value: VariableNode(name: NameNode(value: 'id')),
          ),
          ArgumentNode(
            name: NameNode(value: 'reason'),
            value: VariableNode(name: NameNode(value: 'reason')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'RedemptionFields'),
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
  fragmentDefinitionRedemptionFields,
  fragmentDefinitionRewardFields,
  fragmentDefinitionUserFields,
]);

class Variables$Mutation$FulfillRedemption {
  factory Variables$Mutation$FulfillRedemption({required String id}) =>
      Variables$Mutation$FulfillRedemption._({
        r'id': id,
      });

  Variables$Mutation$FulfillRedemption._(this._$data);

  factory Variables$Mutation$FulfillRedemption.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$id = data['id'];
    result$data['id'] = (l$id as String);
    return Variables$Mutation$FulfillRedemption._(result$data);
  }

  Map<String, dynamic> _$data;

  String get id => (_$data['id'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$id = id;
    result$data['id'] = l$id;
    return result$data;
  }

  CopyWith$Variables$Mutation$FulfillRedemption<
          Variables$Mutation$FulfillRedemption>
      get copyWith => CopyWith$Variables$Mutation$FulfillRedemption(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$FulfillRedemption) ||
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

abstract class CopyWith$Variables$Mutation$FulfillRedemption<TRes> {
  factory CopyWith$Variables$Mutation$FulfillRedemption(
    Variables$Mutation$FulfillRedemption instance,
    TRes Function(Variables$Mutation$FulfillRedemption) then,
  ) = _CopyWithImpl$Variables$Mutation$FulfillRedemption;

  factory CopyWith$Variables$Mutation$FulfillRedemption.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$FulfillRedemption;

  TRes call({String? id});
}

class _CopyWithImpl$Variables$Mutation$FulfillRedemption<TRes>
    implements CopyWith$Variables$Mutation$FulfillRedemption<TRes> {
  _CopyWithImpl$Variables$Mutation$FulfillRedemption(
    this._instance,
    this._then,
  );

  final Variables$Mutation$FulfillRedemption _instance;

  final TRes Function(Variables$Mutation$FulfillRedemption) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? id = _undefined}) =>
      _then(Variables$Mutation$FulfillRedemption._({
        ..._instance._$data,
        if (id != _undefined && id != null) 'id': (id as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$FulfillRedemption<TRes>
    implements CopyWith$Variables$Mutation$FulfillRedemption<TRes> {
  _CopyWithStubImpl$Variables$Mutation$FulfillRedemption(this._res);

  TRes _res;

  call({String? id}) => _res;
}

class Mutation$FulfillRedemption {
  Mutation$FulfillRedemption({
    required this.fulfillRedemption,
    this.$__typename = 'Mutation',
  });

  factory Mutation$FulfillRedemption.fromJson(Map<String, dynamic> json) {
    final l$fulfillRedemption = json['fulfillRedemption'];
    final l$$__typename = json['__typename'];
    return Mutation$FulfillRedemption(
      fulfillRedemption: Fragment$RedemptionFields.fromJson(
          (l$fulfillRedemption as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$RedemptionFields fulfillRedemption;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$fulfillRedemption = fulfillRedemption;
    _resultData['fulfillRedemption'] = l$fulfillRedemption.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$fulfillRedemption = fulfillRedemption;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$fulfillRedemption,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$FulfillRedemption) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$fulfillRedemption = fulfillRedemption;
    final lOther$fulfillRedemption = other.fulfillRedemption;
    if (l$fulfillRedemption != lOther$fulfillRedemption) {
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

extension UtilityExtension$Mutation$FulfillRedemption
    on Mutation$FulfillRedemption {
  CopyWith$Mutation$FulfillRedemption<Mutation$FulfillRedemption>
      get copyWith => CopyWith$Mutation$FulfillRedemption(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$FulfillRedemption<TRes> {
  factory CopyWith$Mutation$FulfillRedemption(
    Mutation$FulfillRedemption instance,
    TRes Function(Mutation$FulfillRedemption) then,
  ) = _CopyWithImpl$Mutation$FulfillRedemption;

  factory CopyWith$Mutation$FulfillRedemption.stub(TRes res) =
      _CopyWithStubImpl$Mutation$FulfillRedemption;

  TRes call({
    Fragment$RedemptionFields? fulfillRedemption,
    String? $__typename,
  });
  CopyWith$Fragment$RedemptionFields<TRes> get fulfillRedemption;
}

class _CopyWithImpl$Mutation$FulfillRedemption<TRes>
    implements CopyWith$Mutation$FulfillRedemption<TRes> {
  _CopyWithImpl$Mutation$FulfillRedemption(
    this._instance,
    this._then,
  );

  final Mutation$FulfillRedemption _instance;

  final TRes Function(Mutation$FulfillRedemption) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? fulfillRedemption = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$FulfillRedemption(
        fulfillRedemption:
            fulfillRedemption == _undefined || fulfillRedemption == null
                ? _instance.fulfillRedemption
                : (fulfillRedemption as Fragment$RedemptionFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$RedemptionFields<TRes> get fulfillRedemption {
    final local$fulfillRedemption = _instance.fulfillRedemption;
    return CopyWith$Fragment$RedemptionFields(
        local$fulfillRedemption, (e) => call(fulfillRedemption: e));
  }
}

class _CopyWithStubImpl$Mutation$FulfillRedemption<TRes>
    implements CopyWith$Mutation$FulfillRedemption<TRes> {
  _CopyWithStubImpl$Mutation$FulfillRedemption(this._res);

  TRes _res;

  call({
    Fragment$RedemptionFields? fulfillRedemption,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$RedemptionFields<TRes> get fulfillRedemption =>
      CopyWith$Fragment$RedemptionFields.stub(_res);
}

const documentNodeMutationFulfillRedemption = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'FulfillRedemption'),
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
        name: NameNode(value: 'fulfillRedemption'),
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
            name: NameNode(value: 'RedemptionFields'),
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
  fragmentDefinitionRedemptionFields,
  fragmentDefinitionRewardFields,
  fragmentDefinitionUserFields,
]);
