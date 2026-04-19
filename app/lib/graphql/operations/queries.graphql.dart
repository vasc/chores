import '../schema.graphql.dart';
import 'fragments.graphql.dart';
import 'package:gql/ast.dart';

class Query$Me {
  Query$Me({
    this.me,
    this.$__typename = 'Query',
  });

  factory Query$Me.fromJson(Map<String, dynamic> json) {
    final l$me = json['me'];
    final l$$__typename = json['__typename'];
    return Query$Me(
      me: l$me == null
          ? null
          : Fragment$UserFields.fromJson((l$me as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$UserFields? me;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$me = me;
    _resultData['me'] = l$me?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$me = me;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$me,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Me) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$me = me;
    final lOther$me = other.me;
    if (l$me != lOther$me) {
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

extension UtilityExtension$Query$Me on Query$Me {
  CopyWith$Query$Me<Query$Me> get copyWith => CopyWith$Query$Me(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Me<TRes> {
  factory CopyWith$Query$Me(
    Query$Me instance,
    TRes Function(Query$Me) then,
  ) = _CopyWithImpl$Query$Me;

  factory CopyWith$Query$Me.stub(TRes res) = _CopyWithStubImpl$Query$Me;

  TRes call({
    Fragment$UserFields? me,
    String? $__typename,
  });
  CopyWith$Fragment$UserFields<TRes> get me;
}

class _CopyWithImpl$Query$Me<TRes> implements CopyWith$Query$Me<TRes> {
  _CopyWithImpl$Query$Me(
    this._instance,
    this._then,
  );

  final Query$Me _instance;

  final TRes Function(Query$Me) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? me = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Me(
        me: me == _undefined ? _instance.me : (me as Fragment$UserFields?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$UserFields<TRes> get me {
    final local$me = _instance.me;
    return local$me == null
        ? CopyWith$Fragment$UserFields.stub(_then(_instance))
        : CopyWith$Fragment$UserFields(local$me, (e) => call(me: e));
  }
}

class _CopyWithStubImpl$Query$Me<TRes> implements CopyWith$Query$Me<TRes> {
  _CopyWithStubImpl$Query$Me(this._res);

  TRes _res;

  call({
    Fragment$UserFields? me,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$UserFields<TRes> get me =>
      CopyWith$Fragment$UserFields.stub(_res);
}

const documentNodeQueryMe = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Me'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'me'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'UserFields'),
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
  fragmentDefinitionUserFields,
]);

class Query$Household {
  Query$Household({
    required this.household,
    required this.members,
    this.$__typename = 'Query',
  });

  factory Query$Household.fromJson(Map<String, dynamic> json) {
    final l$household = json['household'];
    final l$members = json['members'];
    final l$$__typename = json['__typename'];
    return Query$Household(
      household: Query$Household$household.fromJson(
          (l$household as Map<String, dynamic>)),
      members: (l$members as List<dynamic>)
          .map((e) => Fragment$UserFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final Query$Household$household household;

  final List<Fragment$UserFields> members;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$household = household;
    _resultData['household'] = l$household.toJson();
    final l$members = members;
    _resultData['members'] = l$members.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$household = household;
    final l$members = members;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$household,
      Object.hashAll(l$members.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Household) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$household = household;
    final lOther$household = other.household;
    if (l$household != lOther$household) {
      return false;
    }
    final l$members = members;
    final lOther$members = other.members;
    if (l$members.length != lOther$members.length) {
      return false;
    }
    for (int i = 0; i < l$members.length; i++) {
      final l$members$entry = l$members[i];
      final lOther$members$entry = lOther$members[i];
      if (l$members$entry != lOther$members$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Household on Query$Household {
  CopyWith$Query$Household<Query$Household> get copyWith =>
      CopyWith$Query$Household(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Household<TRes> {
  factory CopyWith$Query$Household(
    Query$Household instance,
    TRes Function(Query$Household) then,
  ) = _CopyWithImpl$Query$Household;

  factory CopyWith$Query$Household.stub(TRes res) =
      _CopyWithStubImpl$Query$Household;

  TRes call({
    Query$Household$household? household,
    List<Fragment$UserFields>? members,
    String? $__typename,
  });
  CopyWith$Query$Household$household<TRes> get household;
  TRes members(
      Iterable<Fragment$UserFields> Function(
              Iterable<CopyWith$Fragment$UserFields<Fragment$UserFields>>)
          _fn);
}

class _CopyWithImpl$Query$Household<TRes>
    implements CopyWith$Query$Household<TRes> {
  _CopyWithImpl$Query$Household(
    this._instance,
    this._then,
  );

  final Query$Household _instance;

  final TRes Function(Query$Household) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? household = _undefined,
    Object? members = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Household(
        household: household == _undefined || household == null
            ? _instance.household
            : (household as Query$Household$household),
        members: members == _undefined || members == null
            ? _instance.members
            : (members as List<Fragment$UserFields>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Query$Household$household<TRes> get household {
    final local$household = _instance.household;
    return CopyWith$Query$Household$household(
        local$household, (e) => call(household: e));
  }

  TRes members(
          Iterable<Fragment$UserFields> Function(
                  Iterable<CopyWith$Fragment$UserFields<Fragment$UserFields>>)
              _fn) =>
      call(
          members:
              _fn(_instance.members.map((e) => CopyWith$Fragment$UserFields(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$Household<TRes>
    implements CopyWith$Query$Household<TRes> {
  _CopyWithStubImpl$Query$Household(this._res);

  TRes _res;

  call({
    Query$Household$household? household,
    List<Fragment$UserFields>? members,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Query$Household$household<TRes> get household =>
      CopyWith$Query$Household$household.stub(_res);

  members(_fn) => _res;
}

const documentNodeQueryHousehold = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Household'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'household'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'id'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'name'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
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
        name: NameNode(value: 'members'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'UserFields'),
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
  fragmentDefinitionUserFields,
]);

class Query$Household$household {
  Query$Household$household({
    required this.id,
    required this.name,
    this.$__typename = 'Household',
  });

  factory Query$Household$household.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$name = json['name'];
    final l$$__typename = json['__typename'];
    return Query$Household$household(
      id: (l$id as String),
      name: (l$name as String),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String name;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$name = name;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$name,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Household$household) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
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

extension UtilityExtension$Query$Household$household
    on Query$Household$household {
  CopyWith$Query$Household$household<Query$Household$household> get copyWith =>
      CopyWith$Query$Household$household(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Household$household<TRes> {
  factory CopyWith$Query$Household$household(
    Query$Household$household instance,
    TRes Function(Query$Household$household) then,
  ) = _CopyWithImpl$Query$Household$household;

  factory CopyWith$Query$Household$household.stub(TRes res) =
      _CopyWithStubImpl$Query$Household$household;

  TRes call({
    String? id,
    String? name,
    String? $__typename,
  });
}

class _CopyWithImpl$Query$Household$household<TRes>
    implements CopyWith$Query$Household$household<TRes> {
  _CopyWithImpl$Query$Household$household(
    this._instance,
    this._then,
  );

  final Query$Household$household _instance;

  final TRes Function(Query$Household$household) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? name = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Household$household(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Query$Household$household<TRes>
    implements CopyWith$Query$Household$household<TRes> {
  _CopyWithStubImpl$Query$Household$household(this._res);

  TRes _res;

  call({
    String? id,
    String? name,
    String? $__typename,
  }) =>
      _res;
}

class Variables$Query$KidsForLogin {
  factory Variables$Query$KidsForLogin({required String householdId}) =>
      Variables$Query$KidsForLogin._({
        r'householdId': householdId,
      });

  Variables$Query$KidsForLogin._(this._$data);

  factory Variables$Query$KidsForLogin.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$householdId = data['householdId'];
    result$data['householdId'] = (l$householdId as String);
    return Variables$Query$KidsForLogin._(result$data);
  }

  Map<String, dynamic> _$data;

  String get householdId => (_$data['householdId'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$householdId = householdId;
    result$data['householdId'] = l$householdId;
    return result$data;
  }

  CopyWith$Variables$Query$KidsForLogin<Variables$Query$KidsForLogin>
      get copyWith => CopyWith$Variables$Query$KidsForLogin(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$KidsForLogin) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$householdId = householdId;
    final lOther$householdId = other.householdId;
    if (l$householdId != lOther$householdId) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$householdId = householdId;
    return Object.hashAll([l$householdId]);
  }
}

abstract class CopyWith$Variables$Query$KidsForLogin<TRes> {
  factory CopyWith$Variables$Query$KidsForLogin(
    Variables$Query$KidsForLogin instance,
    TRes Function(Variables$Query$KidsForLogin) then,
  ) = _CopyWithImpl$Variables$Query$KidsForLogin;

  factory CopyWith$Variables$Query$KidsForLogin.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$KidsForLogin;

  TRes call({String? householdId});
}

class _CopyWithImpl$Variables$Query$KidsForLogin<TRes>
    implements CopyWith$Variables$Query$KidsForLogin<TRes> {
  _CopyWithImpl$Variables$Query$KidsForLogin(
    this._instance,
    this._then,
  );

  final Variables$Query$KidsForLogin _instance;

  final TRes Function(Variables$Query$KidsForLogin) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? householdId = _undefined}) =>
      _then(Variables$Query$KidsForLogin._({
        ..._instance._$data,
        if (householdId != _undefined && householdId != null)
          'householdId': (householdId as String),
      }));
}

class _CopyWithStubImpl$Variables$Query$KidsForLogin<TRes>
    implements CopyWith$Variables$Query$KidsForLogin<TRes> {
  _CopyWithStubImpl$Variables$Query$KidsForLogin(this._res);

  TRes _res;

  call({String? householdId}) => _res;
}

class Query$KidsForLogin {
  Query$KidsForLogin({
    required this.kidsForLogin,
    this.$__typename = 'Query',
  });

  factory Query$KidsForLogin.fromJson(Map<String, dynamic> json) {
    final l$kidsForLogin = json['kidsForLogin'];
    final l$$__typename = json['__typename'];
    return Query$KidsForLogin(
      kidsForLogin: (l$kidsForLogin as List<dynamic>)
          .map((e) => Fragment$UserFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$UserFields> kidsForLogin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$kidsForLogin = kidsForLogin;
    _resultData['kidsForLogin'] =
        l$kidsForLogin.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$kidsForLogin = kidsForLogin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$kidsForLogin.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$KidsForLogin) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$kidsForLogin = kidsForLogin;
    final lOther$kidsForLogin = other.kidsForLogin;
    if (l$kidsForLogin.length != lOther$kidsForLogin.length) {
      return false;
    }
    for (int i = 0; i < l$kidsForLogin.length; i++) {
      final l$kidsForLogin$entry = l$kidsForLogin[i];
      final lOther$kidsForLogin$entry = lOther$kidsForLogin[i];
      if (l$kidsForLogin$entry != lOther$kidsForLogin$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$KidsForLogin on Query$KidsForLogin {
  CopyWith$Query$KidsForLogin<Query$KidsForLogin> get copyWith =>
      CopyWith$Query$KidsForLogin(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$KidsForLogin<TRes> {
  factory CopyWith$Query$KidsForLogin(
    Query$KidsForLogin instance,
    TRes Function(Query$KidsForLogin) then,
  ) = _CopyWithImpl$Query$KidsForLogin;

  factory CopyWith$Query$KidsForLogin.stub(TRes res) =
      _CopyWithStubImpl$Query$KidsForLogin;

  TRes call({
    List<Fragment$UserFields>? kidsForLogin,
    String? $__typename,
  });
  TRes kidsForLogin(
      Iterable<Fragment$UserFields> Function(
              Iterable<CopyWith$Fragment$UserFields<Fragment$UserFields>>)
          _fn);
}

class _CopyWithImpl$Query$KidsForLogin<TRes>
    implements CopyWith$Query$KidsForLogin<TRes> {
  _CopyWithImpl$Query$KidsForLogin(
    this._instance,
    this._then,
  );

  final Query$KidsForLogin _instance;

  final TRes Function(Query$KidsForLogin) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? kidsForLogin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$KidsForLogin(
        kidsForLogin: kidsForLogin == _undefined || kidsForLogin == null
            ? _instance.kidsForLogin
            : (kidsForLogin as List<Fragment$UserFields>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes kidsForLogin(
          Iterable<Fragment$UserFields> Function(
                  Iterable<CopyWith$Fragment$UserFields<Fragment$UserFields>>)
              _fn) =>
      call(
          kidsForLogin: _fn(
              _instance.kidsForLogin.map((e) => CopyWith$Fragment$UserFields(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$KidsForLogin<TRes>
    implements CopyWith$Query$KidsForLogin<TRes> {
  _CopyWithStubImpl$Query$KidsForLogin(this._res);

  TRes _res;

  call({
    List<Fragment$UserFields>? kidsForLogin,
    String? $__typename,
  }) =>
      _res;

  kidsForLogin(_fn) => _res;
}

const documentNodeQueryKidsForLogin = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'KidsForLogin'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'householdId')),
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
        name: NameNode(value: 'kidsForLogin'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'householdId'),
            value: VariableNode(name: NameNode(value: 'householdId')),
          )
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'UserFields'),
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
  fragmentDefinitionUserFields,
]);

class Variables$Query$Chores {
  factory Variables$Query$Chores({bool? includeArchived}) =>
      Variables$Query$Chores._({
        if (includeArchived != null) r'includeArchived': includeArchived,
      });

  Variables$Query$Chores._(this._$data);

  factory Variables$Query$Chores.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('includeArchived')) {
      final l$includeArchived = data['includeArchived'];
      result$data['includeArchived'] = (l$includeArchived as bool?);
    }
    return Variables$Query$Chores._(result$data);
  }

  Map<String, dynamic> _$data;

  bool? get includeArchived => (_$data['includeArchived'] as bool?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('includeArchived')) {
      final l$includeArchived = includeArchived;
      result$data['includeArchived'] = l$includeArchived;
    }
    return result$data;
  }

  CopyWith$Variables$Query$Chores<Variables$Query$Chores> get copyWith =>
      CopyWith$Variables$Query$Chores(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$Chores) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$includeArchived = includeArchived;
    final lOther$includeArchived = other.includeArchived;
    if (_$data.containsKey('includeArchived') !=
        other._$data.containsKey('includeArchived')) {
      return false;
    }
    if (l$includeArchived != lOther$includeArchived) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$includeArchived = includeArchived;
    return Object.hashAll(
        [_$data.containsKey('includeArchived') ? l$includeArchived : const {}]);
  }
}

abstract class CopyWith$Variables$Query$Chores<TRes> {
  factory CopyWith$Variables$Query$Chores(
    Variables$Query$Chores instance,
    TRes Function(Variables$Query$Chores) then,
  ) = _CopyWithImpl$Variables$Query$Chores;

  factory CopyWith$Variables$Query$Chores.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Chores;

  TRes call({bool? includeArchived});
}

class _CopyWithImpl$Variables$Query$Chores<TRes>
    implements CopyWith$Variables$Query$Chores<TRes> {
  _CopyWithImpl$Variables$Query$Chores(
    this._instance,
    this._then,
  );

  final Variables$Query$Chores _instance;

  final TRes Function(Variables$Query$Chores) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? includeArchived = _undefined}) =>
      _then(Variables$Query$Chores._({
        ..._instance._$data,
        if (includeArchived != _undefined)
          'includeArchived': (includeArchived as bool?),
      }));
}

class _CopyWithStubImpl$Variables$Query$Chores<TRes>
    implements CopyWith$Variables$Query$Chores<TRes> {
  _CopyWithStubImpl$Variables$Query$Chores(this._res);

  TRes _res;

  call({bool? includeArchived}) => _res;
}

class Query$Chores {
  Query$Chores({
    required this.chores,
    this.$__typename = 'Query',
  });

  factory Query$Chores.fromJson(Map<String, dynamic> json) {
    final l$chores = json['chores'];
    final l$$__typename = json['__typename'];
    return Query$Chores(
      chores: (l$chores as List<dynamic>)
          .map(
              (e) => Fragment$ChoreFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$ChoreFields> chores;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$chores = chores;
    _resultData['chores'] = l$chores.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$chores = chores;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$chores.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Chores) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$chores = chores;
    final lOther$chores = other.chores;
    if (l$chores.length != lOther$chores.length) {
      return false;
    }
    for (int i = 0; i < l$chores.length; i++) {
      final l$chores$entry = l$chores[i];
      final lOther$chores$entry = lOther$chores[i];
      if (l$chores$entry != lOther$chores$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Chores on Query$Chores {
  CopyWith$Query$Chores<Query$Chores> get copyWith => CopyWith$Query$Chores(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Chores<TRes> {
  factory CopyWith$Query$Chores(
    Query$Chores instance,
    TRes Function(Query$Chores) then,
  ) = _CopyWithImpl$Query$Chores;

  factory CopyWith$Query$Chores.stub(TRes res) = _CopyWithStubImpl$Query$Chores;

  TRes call({
    List<Fragment$ChoreFields>? chores,
    String? $__typename,
  });
  TRes chores(
      Iterable<Fragment$ChoreFields> Function(
              Iterable<CopyWith$Fragment$ChoreFields<Fragment$ChoreFields>>)
          _fn);
}

class _CopyWithImpl$Query$Chores<TRes> implements CopyWith$Query$Chores<TRes> {
  _CopyWithImpl$Query$Chores(
    this._instance,
    this._then,
  );

  final Query$Chores _instance;

  final TRes Function(Query$Chores) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? chores = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Chores(
        chores: chores == _undefined || chores == null
            ? _instance.chores
            : (chores as List<Fragment$ChoreFields>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes chores(
          Iterable<Fragment$ChoreFields> Function(
                  Iterable<CopyWith$Fragment$ChoreFields<Fragment$ChoreFields>>)
              _fn) =>
      call(
          chores: _fn(_instance.chores.map((e) => CopyWith$Fragment$ChoreFields(
                e,
                (i) => i,
              ))).toList());
}

class _CopyWithStubImpl$Query$Chores<TRes>
    implements CopyWith$Query$Chores<TRes> {
  _CopyWithStubImpl$Query$Chores(this._res);

  TRes _res;

  call({
    List<Fragment$ChoreFields>? chores,
    String? $__typename,
  }) =>
      _res;

  chores(_fn) => _res;
}

const documentNodeQueryChores = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Chores'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'includeArchived')),
        type: NamedTypeNode(
          name: NameNode(value: 'Boolean'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: BooleanValueNode(value: false)),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'chores'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'includeArchived'),
            value: VariableNode(name: NameNode(value: 'includeArchived')),
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

class Variables$Query$Assignments {
  factory Variables$Query$Assignments({
    bool? mineOnly,
    Enum$ChoreStatus? status,
  }) =>
      Variables$Query$Assignments._({
        if (mineOnly != null) r'mineOnly': mineOnly,
        if (status != null) r'status': status,
      });

  Variables$Query$Assignments._(this._$data);

  factory Variables$Query$Assignments.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('mineOnly')) {
      final l$mineOnly = data['mineOnly'];
      result$data['mineOnly'] = (l$mineOnly as bool?);
    }
    if (data.containsKey('status')) {
      final l$status = data['status'];
      result$data['status'] = l$status == null
          ? null
          : fromJson$Enum$ChoreStatus((l$status as String));
    }
    return Variables$Query$Assignments._(result$data);
  }

  Map<String, dynamic> _$data;

  bool? get mineOnly => (_$data['mineOnly'] as bool?);

  Enum$ChoreStatus? get status => (_$data['status'] as Enum$ChoreStatus?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('mineOnly')) {
      final l$mineOnly = mineOnly;
      result$data['mineOnly'] = l$mineOnly;
    }
    if (_$data.containsKey('status')) {
      final l$status = status;
      result$data['status'] =
          l$status == null ? null : toJson$Enum$ChoreStatus(l$status);
    }
    return result$data;
  }

  CopyWith$Variables$Query$Assignments<Variables$Query$Assignments>
      get copyWith => CopyWith$Variables$Query$Assignments(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$Assignments) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$mineOnly = mineOnly;
    final lOther$mineOnly = other.mineOnly;
    if (_$data.containsKey('mineOnly') !=
        other._$data.containsKey('mineOnly')) {
      return false;
    }
    if (l$mineOnly != lOther$mineOnly) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (_$data.containsKey('status') != other._$data.containsKey('status')) {
      return false;
    }
    if (l$status != lOther$status) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$mineOnly = mineOnly;
    final l$status = status;
    return Object.hashAll([
      _$data.containsKey('mineOnly') ? l$mineOnly : const {},
      _$data.containsKey('status') ? l$status : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$Assignments<TRes> {
  factory CopyWith$Variables$Query$Assignments(
    Variables$Query$Assignments instance,
    TRes Function(Variables$Query$Assignments) then,
  ) = _CopyWithImpl$Variables$Query$Assignments;

  factory CopyWith$Variables$Query$Assignments.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Assignments;

  TRes call({
    bool? mineOnly,
    Enum$ChoreStatus? status,
  });
}

class _CopyWithImpl$Variables$Query$Assignments<TRes>
    implements CopyWith$Variables$Query$Assignments<TRes> {
  _CopyWithImpl$Variables$Query$Assignments(
    this._instance,
    this._then,
  );

  final Variables$Query$Assignments _instance;

  final TRes Function(Variables$Query$Assignments) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? mineOnly = _undefined,
    Object? status = _undefined,
  }) =>
      _then(Variables$Query$Assignments._({
        ..._instance._$data,
        if (mineOnly != _undefined) 'mineOnly': (mineOnly as bool?),
        if (status != _undefined) 'status': (status as Enum$ChoreStatus?),
      }));
}

class _CopyWithStubImpl$Variables$Query$Assignments<TRes>
    implements CopyWith$Variables$Query$Assignments<TRes> {
  _CopyWithStubImpl$Variables$Query$Assignments(this._res);

  TRes _res;

  call({
    bool? mineOnly,
    Enum$ChoreStatus? status,
  }) =>
      _res;
}

class Query$Assignments {
  Query$Assignments({
    required this.assignments,
    this.$__typename = 'Query',
  });

  factory Query$Assignments.fromJson(Map<String, dynamic> json) {
    final l$assignments = json['assignments'];
    final l$$__typename = json['__typename'];
    return Query$Assignments(
      assignments: (l$assignments as List<dynamic>)
          .map((e) =>
              Fragment$AssignmentFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$AssignmentFields> assignments;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$assignments = assignments;
    _resultData['assignments'] = l$assignments.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$assignments = assignments;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$assignments.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Assignments) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$assignments = assignments;
    final lOther$assignments = other.assignments;
    if (l$assignments.length != lOther$assignments.length) {
      return false;
    }
    for (int i = 0; i < l$assignments.length; i++) {
      final l$assignments$entry = l$assignments[i];
      final lOther$assignments$entry = lOther$assignments[i];
      if (l$assignments$entry != lOther$assignments$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Assignments on Query$Assignments {
  CopyWith$Query$Assignments<Query$Assignments> get copyWith =>
      CopyWith$Query$Assignments(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Assignments<TRes> {
  factory CopyWith$Query$Assignments(
    Query$Assignments instance,
    TRes Function(Query$Assignments) then,
  ) = _CopyWithImpl$Query$Assignments;

  factory CopyWith$Query$Assignments.stub(TRes res) =
      _CopyWithStubImpl$Query$Assignments;

  TRes call({
    List<Fragment$AssignmentFields>? assignments,
    String? $__typename,
  });
  TRes assignments(
      Iterable<Fragment$AssignmentFields> Function(
              Iterable<
                  CopyWith$Fragment$AssignmentFields<
                      Fragment$AssignmentFields>>)
          _fn);
}

class _CopyWithImpl$Query$Assignments<TRes>
    implements CopyWith$Query$Assignments<TRes> {
  _CopyWithImpl$Query$Assignments(
    this._instance,
    this._then,
  );

  final Query$Assignments _instance;

  final TRes Function(Query$Assignments) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? assignments = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Assignments(
        assignments: assignments == _undefined || assignments == null
            ? _instance.assignments
            : (assignments as List<Fragment$AssignmentFields>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes assignments(
          Iterable<Fragment$AssignmentFields> Function(
                  Iterable<
                      CopyWith$Fragment$AssignmentFields<
                          Fragment$AssignmentFields>>)
              _fn) =>
      call(
          assignments: _fn(_instance.assignments
              .map((e) => CopyWith$Fragment$AssignmentFields(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$Assignments<TRes>
    implements CopyWith$Query$Assignments<TRes> {
  _CopyWithStubImpl$Query$Assignments(this._res);

  TRes _res;

  call({
    List<Fragment$AssignmentFields>? assignments,
    String? $__typename,
  }) =>
      _res;

  assignments(_fn) => _res;
}

const documentNodeQueryAssignments = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Assignments'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'mineOnly')),
        type: NamedTypeNode(
          name: NameNode(value: 'Boolean'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: BooleanValueNode(value: false)),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'status')),
        type: NamedTypeNode(
          name: NameNode(value: 'ChoreStatus'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'assignments'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'mineOnly'),
            value: VariableNode(name: NameNode(value: 'mineOnly')),
          ),
          ArgumentNode(
            name: NameNode(value: 'status'),
            value: VariableNode(name: NameNode(value: 'status')),
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

class Variables$Query$Rewards {
  factory Variables$Query$Rewards({bool? includeArchived}) =>
      Variables$Query$Rewards._({
        if (includeArchived != null) r'includeArchived': includeArchived,
      });

  Variables$Query$Rewards._(this._$data);

  factory Variables$Query$Rewards.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('includeArchived')) {
      final l$includeArchived = data['includeArchived'];
      result$data['includeArchived'] = (l$includeArchived as bool?);
    }
    return Variables$Query$Rewards._(result$data);
  }

  Map<String, dynamic> _$data;

  bool? get includeArchived => (_$data['includeArchived'] as bool?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('includeArchived')) {
      final l$includeArchived = includeArchived;
      result$data['includeArchived'] = l$includeArchived;
    }
    return result$data;
  }

  CopyWith$Variables$Query$Rewards<Variables$Query$Rewards> get copyWith =>
      CopyWith$Variables$Query$Rewards(
        this,
        (i) => i,
      );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$Rewards) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$includeArchived = includeArchived;
    final lOther$includeArchived = other.includeArchived;
    if (_$data.containsKey('includeArchived') !=
        other._$data.containsKey('includeArchived')) {
      return false;
    }
    if (l$includeArchived != lOther$includeArchived) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$includeArchived = includeArchived;
    return Object.hashAll(
        [_$data.containsKey('includeArchived') ? l$includeArchived : const {}]);
  }
}

abstract class CopyWith$Variables$Query$Rewards<TRes> {
  factory CopyWith$Variables$Query$Rewards(
    Variables$Query$Rewards instance,
    TRes Function(Variables$Query$Rewards) then,
  ) = _CopyWithImpl$Variables$Query$Rewards;

  factory CopyWith$Variables$Query$Rewards.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Rewards;

  TRes call({bool? includeArchived});
}

class _CopyWithImpl$Variables$Query$Rewards<TRes>
    implements CopyWith$Variables$Query$Rewards<TRes> {
  _CopyWithImpl$Variables$Query$Rewards(
    this._instance,
    this._then,
  );

  final Variables$Query$Rewards _instance;

  final TRes Function(Variables$Query$Rewards) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({Object? includeArchived = _undefined}) =>
      _then(Variables$Query$Rewards._({
        ..._instance._$data,
        if (includeArchived != _undefined)
          'includeArchived': (includeArchived as bool?),
      }));
}

class _CopyWithStubImpl$Variables$Query$Rewards<TRes>
    implements CopyWith$Variables$Query$Rewards<TRes> {
  _CopyWithStubImpl$Variables$Query$Rewards(this._res);

  TRes _res;

  call({bool? includeArchived}) => _res;
}

class Query$Rewards {
  Query$Rewards({
    required this.rewards,
    this.$__typename = 'Query',
  });

  factory Query$Rewards.fromJson(Map<String, dynamic> json) {
    final l$rewards = json['rewards'];
    final l$$__typename = json['__typename'];
    return Query$Rewards(
      rewards: (l$rewards as List<dynamic>)
          .map((e) =>
              Fragment$RewardFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$RewardFields> rewards;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$rewards = rewards;
    _resultData['rewards'] = l$rewards.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$rewards = rewards;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$rewards.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Rewards) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$rewards = rewards;
    final lOther$rewards = other.rewards;
    if (l$rewards.length != lOther$rewards.length) {
      return false;
    }
    for (int i = 0; i < l$rewards.length; i++) {
      final l$rewards$entry = l$rewards[i];
      final lOther$rewards$entry = lOther$rewards[i];
      if (l$rewards$entry != lOther$rewards$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Rewards on Query$Rewards {
  CopyWith$Query$Rewards<Query$Rewards> get copyWith => CopyWith$Query$Rewards(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Rewards<TRes> {
  factory CopyWith$Query$Rewards(
    Query$Rewards instance,
    TRes Function(Query$Rewards) then,
  ) = _CopyWithImpl$Query$Rewards;

  factory CopyWith$Query$Rewards.stub(TRes res) =
      _CopyWithStubImpl$Query$Rewards;

  TRes call({
    List<Fragment$RewardFields>? rewards,
    String? $__typename,
  });
  TRes rewards(
      Iterable<Fragment$RewardFields> Function(
              Iterable<CopyWith$Fragment$RewardFields<Fragment$RewardFields>>)
          _fn);
}

class _CopyWithImpl$Query$Rewards<TRes>
    implements CopyWith$Query$Rewards<TRes> {
  _CopyWithImpl$Query$Rewards(
    this._instance,
    this._then,
  );

  final Query$Rewards _instance;

  final TRes Function(Query$Rewards) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? rewards = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Rewards(
        rewards: rewards == _undefined || rewards == null
            ? _instance.rewards
            : (rewards as List<Fragment$RewardFields>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes rewards(
          Iterable<Fragment$RewardFields> Function(
                  Iterable<
                      CopyWith$Fragment$RewardFields<Fragment$RewardFields>>)
              _fn) =>
      call(
          rewards:
              _fn(_instance.rewards.map((e) => CopyWith$Fragment$RewardFields(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$Rewards<TRes>
    implements CopyWith$Query$Rewards<TRes> {
  _CopyWithStubImpl$Query$Rewards(this._res);

  TRes _res;

  call({
    List<Fragment$RewardFields>? rewards,
    String? $__typename,
  }) =>
      _res;

  rewards(_fn) => _res;
}

const documentNodeQueryRewards = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Rewards'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'includeArchived')),
        type: NamedTypeNode(
          name: NameNode(value: 'Boolean'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: BooleanValueNode(value: false)),
        directives: [],
      )
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'rewards'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'includeArchived'),
            value: VariableNode(name: NameNode(value: 'includeArchived')),
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

class Variables$Query$Redemptions {
  factory Variables$Query$Redemptions({
    bool? mineOnly,
    Enum$RedemptionStatus? status,
  }) =>
      Variables$Query$Redemptions._({
        if (mineOnly != null) r'mineOnly': mineOnly,
        if (status != null) r'status': status,
      });

  Variables$Query$Redemptions._(this._$data);

  factory Variables$Query$Redemptions.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    if (data.containsKey('mineOnly')) {
      final l$mineOnly = data['mineOnly'];
      result$data['mineOnly'] = (l$mineOnly as bool?);
    }
    if (data.containsKey('status')) {
      final l$status = data['status'];
      result$data['status'] = l$status == null
          ? null
          : fromJson$Enum$RedemptionStatus((l$status as String));
    }
    return Variables$Query$Redemptions._(result$data);
  }

  Map<String, dynamic> _$data;

  bool? get mineOnly => (_$data['mineOnly'] as bool?);

  Enum$RedemptionStatus? get status =>
      (_$data['status'] as Enum$RedemptionStatus?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    if (_$data.containsKey('mineOnly')) {
      final l$mineOnly = mineOnly;
      result$data['mineOnly'] = l$mineOnly;
    }
    if (_$data.containsKey('status')) {
      final l$status = status;
      result$data['status'] =
          l$status == null ? null : toJson$Enum$RedemptionStatus(l$status);
    }
    return result$data;
  }

  CopyWith$Variables$Query$Redemptions<Variables$Query$Redemptions>
      get copyWith => CopyWith$Variables$Query$Redemptions(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Query$Redemptions) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$mineOnly = mineOnly;
    final lOther$mineOnly = other.mineOnly;
    if (_$data.containsKey('mineOnly') !=
        other._$data.containsKey('mineOnly')) {
      return false;
    }
    if (l$mineOnly != lOther$mineOnly) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (_$data.containsKey('status') != other._$data.containsKey('status')) {
      return false;
    }
    if (l$status != lOther$status) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$mineOnly = mineOnly;
    final l$status = status;
    return Object.hashAll([
      _$data.containsKey('mineOnly') ? l$mineOnly : const {},
      _$data.containsKey('status') ? l$status : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Query$Redemptions<TRes> {
  factory CopyWith$Variables$Query$Redemptions(
    Variables$Query$Redemptions instance,
    TRes Function(Variables$Query$Redemptions) then,
  ) = _CopyWithImpl$Variables$Query$Redemptions;

  factory CopyWith$Variables$Query$Redemptions.stub(TRes res) =
      _CopyWithStubImpl$Variables$Query$Redemptions;

  TRes call({
    bool? mineOnly,
    Enum$RedemptionStatus? status,
  });
}

class _CopyWithImpl$Variables$Query$Redemptions<TRes>
    implements CopyWith$Variables$Query$Redemptions<TRes> {
  _CopyWithImpl$Variables$Query$Redemptions(
    this._instance,
    this._then,
  );

  final Variables$Query$Redemptions _instance;

  final TRes Function(Variables$Query$Redemptions) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? mineOnly = _undefined,
    Object? status = _undefined,
  }) =>
      _then(Variables$Query$Redemptions._({
        ..._instance._$data,
        if (mineOnly != _undefined) 'mineOnly': (mineOnly as bool?),
        if (status != _undefined) 'status': (status as Enum$RedemptionStatus?),
      }));
}

class _CopyWithStubImpl$Variables$Query$Redemptions<TRes>
    implements CopyWith$Variables$Query$Redemptions<TRes> {
  _CopyWithStubImpl$Variables$Query$Redemptions(this._res);

  TRes _res;

  call({
    bool? mineOnly,
    Enum$RedemptionStatus? status,
  }) =>
      _res;
}

class Query$Redemptions {
  Query$Redemptions({
    required this.redemptions,
    this.$__typename = 'Query',
  });

  factory Query$Redemptions.fromJson(Map<String, dynamic> json) {
    final l$redemptions = json['redemptions'];
    final l$$__typename = json['__typename'];
    return Query$Redemptions(
      redemptions: (l$redemptions as List<dynamic>)
          .map((e) =>
              Fragment$RedemptionFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$RedemptionFields> redemptions;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$redemptions = redemptions;
    _resultData['redemptions'] = l$redemptions.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$redemptions = redemptions;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$redemptions.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Redemptions) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$redemptions = redemptions;
    final lOther$redemptions = other.redemptions;
    if (l$redemptions.length != lOther$redemptions.length) {
      return false;
    }
    for (int i = 0; i < l$redemptions.length; i++) {
      final l$redemptions$entry = l$redemptions[i];
      final lOther$redemptions$entry = lOther$redemptions[i];
      if (l$redemptions$entry != lOther$redemptions$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Redemptions on Query$Redemptions {
  CopyWith$Query$Redemptions<Query$Redemptions> get copyWith =>
      CopyWith$Query$Redemptions(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Redemptions<TRes> {
  factory CopyWith$Query$Redemptions(
    Query$Redemptions instance,
    TRes Function(Query$Redemptions) then,
  ) = _CopyWithImpl$Query$Redemptions;

  factory CopyWith$Query$Redemptions.stub(TRes res) =
      _CopyWithStubImpl$Query$Redemptions;

  TRes call({
    List<Fragment$RedemptionFields>? redemptions,
    String? $__typename,
  });
  TRes redemptions(
      Iterable<Fragment$RedemptionFields> Function(
              Iterable<
                  CopyWith$Fragment$RedemptionFields<
                      Fragment$RedemptionFields>>)
          _fn);
}

class _CopyWithImpl$Query$Redemptions<TRes>
    implements CopyWith$Query$Redemptions<TRes> {
  _CopyWithImpl$Query$Redemptions(
    this._instance,
    this._then,
  );

  final Query$Redemptions _instance;

  final TRes Function(Query$Redemptions) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? redemptions = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Redemptions(
        redemptions: redemptions == _undefined || redemptions == null
            ? _instance.redemptions
            : (redemptions as List<Fragment$RedemptionFields>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes redemptions(
          Iterable<Fragment$RedemptionFields> Function(
                  Iterable<
                      CopyWith$Fragment$RedemptionFields<
                          Fragment$RedemptionFields>>)
              _fn) =>
      call(
          redemptions: _fn(_instance.redemptions
              .map((e) => CopyWith$Fragment$RedemptionFields(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$Redemptions<TRes>
    implements CopyWith$Query$Redemptions<TRes> {
  _CopyWithStubImpl$Query$Redemptions(this._res);

  TRes _res;

  call({
    List<Fragment$RedemptionFields>? redemptions,
    String? $__typename,
  }) =>
      _res;

  redemptions(_fn) => _res;
}

const documentNodeQueryRedemptions = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Redemptions'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'mineOnly')),
        type: NamedTypeNode(
          name: NameNode(value: 'Boolean'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: BooleanValueNode(value: false)),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'status')),
        type: NamedTypeNode(
          name: NameNode(value: 'RedemptionStatus'),
          isNonNull: false,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'redemptions'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'mineOnly'),
            value: VariableNode(name: NameNode(value: 'mineOnly')),
          ),
          ArgumentNode(
            name: NameNode(value: 'status'),
            value: VariableNode(name: NameNode(value: 'status')),
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

class Query$PendingApprovals {
  Query$PendingApprovals({
    required this.pendingApprovals,
    required this.pendingRedemptions,
    this.$__typename = 'Query',
  });

  factory Query$PendingApprovals.fromJson(Map<String, dynamic> json) {
    final l$pendingApprovals = json['pendingApprovals'];
    final l$pendingRedemptions = json['pendingRedemptions'];
    final l$$__typename = json['__typename'];
    return Query$PendingApprovals(
      pendingApprovals: (l$pendingApprovals as List<dynamic>)
          .map((e) =>
              Fragment$AssignmentFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      pendingRedemptions: (l$pendingRedemptions as List<dynamic>)
          .map((e) =>
              Fragment$RedemptionFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$AssignmentFields> pendingApprovals;

  final List<Fragment$RedemptionFields> pendingRedemptions;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$pendingApprovals = pendingApprovals;
    _resultData['pendingApprovals'] =
        l$pendingApprovals.map((e) => e.toJson()).toList();
    final l$pendingRedemptions = pendingRedemptions;
    _resultData['pendingRedemptions'] =
        l$pendingRedemptions.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$pendingApprovals = pendingApprovals;
    final l$pendingRedemptions = pendingRedemptions;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$pendingApprovals.map((v) => v)),
      Object.hashAll(l$pendingRedemptions.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$PendingApprovals) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$pendingApprovals = pendingApprovals;
    final lOther$pendingApprovals = other.pendingApprovals;
    if (l$pendingApprovals.length != lOther$pendingApprovals.length) {
      return false;
    }
    for (int i = 0; i < l$pendingApprovals.length; i++) {
      final l$pendingApprovals$entry = l$pendingApprovals[i];
      final lOther$pendingApprovals$entry = lOther$pendingApprovals[i];
      if (l$pendingApprovals$entry != lOther$pendingApprovals$entry) {
        return false;
      }
    }
    final l$pendingRedemptions = pendingRedemptions;
    final lOther$pendingRedemptions = other.pendingRedemptions;
    if (l$pendingRedemptions.length != lOther$pendingRedemptions.length) {
      return false;
    }
    for (int i = 0; i < l$pendingRedemptions.length; i++) {
      final l$pendingRedemptions$entry = l$pendingRedemptions[i];
      final lOther$pendingRedemptions$entry = lOther$pendingRedemptions[i];
      if (l$pendingRedemptions$entry != lOther$pendingRedemptions$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$PendingApprovals on Query$PendingApprovals {
  CopyWith$Query$PendingApprovals<Query$PendingApprovals> get copyWith =>
      CopyWith$Query$PendingApprovals(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$PendingApprovals<TRes> {
  factory CopyWith$Query$PendingApprovals(
    Query$PendingApprovals instance,
    TRes Function(Query$PendingApprovals) then,
  ) = _CopyWithImpl$Query$PendingApprovals;

  factory CopyWith$Query$PendingApprovals.stub(TRes res) =
      _CopyWithStubImpl$Query$PendingApprovals;

  TRes call({
    List<Fragment$AssignmentFields>? pendingApprovals,
    List<Fragment$RedemptionFields>? pendingRedemptions,
    String? $__typename,
  });
  TRes pendingApprovals(
      Iterable<Fragment$AssignmentFields> Function(
              Iterable<
                  CopyWith$Fragment$AssignmentFields<
                      Fragment$AssignmentFields>>)
          _fn);
  TRes pendingRedemptions(
      Iterable<Fragment$RedemptionFields> Function(
              Iterable<
                  CopyWith$Fragment$RedemptionFields<
                      Fragment$RedemptionFields>>)
          _fn);
}

class _CopyWithImpl$Query$PendingApprovals<TRes>
    implements CopyWith$Query$PendingApprovals<TRes> {
  _CopyWithImpl$Query$PendingApprovals(
    this._instance,
    this._then,
  );

  final Query$PendingApprovals _instance;

  final TRes Function(Query$PendingApprovals) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? pendingApprovals = _undefined,
    Object? pendingRedemptions = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$PendingApprovals(
        pendingApprovals:
            pendingApprovals == _undefined || pendingApprovals == null
                ? _instance.pendingApprovals
                : (pendingApprovals as List<Fragment$AssignmentFields>),
        pendingRedemptions:
            pendingRedemptions == _undefined || pendingRedemptions == null
                ? _instance.pendingRedemptions
                : (pendingRedemptions as List<Fragment$RedemptionFields>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes pendingApprovals(
          Iterable<Fragment$AssignmentFields> Function(
                  Iterable<
                      CopyWith$Fragment$AssignmentFields<
                          Fragment$AssignmentFields>>)
              _fn) =>
      call(
          pendingApprovals: _fn(_instance.pendingApprovals
              .map((e) => CopyWith$Fragment$AssignmentFields(
                    e,
                    (i) => i,
                  ))).toList());

  TRes pendingRedemptions(
          Iterable<Fragment$RedemptionFields> Function(
                  Iterable<
                      CopyWith$Fragment$RedemptionFields<
                          Fragment$RedemptionFields>>)
              _fn) =>
      call(
          pendingRedemptions: _fn(_instance.pendingRedemptions
              .map((e) => CopyWith$Fragment$RedemptionFields(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$PendingApprovals<TRes>
    implements CopyWith$Query$PendingApprovals<TRes> {
  _CopyWithStubImpl$Query$PendingApprovals(this._res);

  TRes _res;

  call({
    List<Fragment$AssignmentFields>? pendingApprovals,
    List<Fragment$RedemptionFields>? pendingRedemptions,
    String? $__typename,
  }) =>
      _res;

  pendingApprovals(_fn) => _res;

  pendingRedemptions(_fn) => _res;
}

const documentNodeQueryPendingApprovals = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'PendingApprovals'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'pendingApprovals'),
        alias: null,
        arguments: [],
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
        name: NameNode(value: 'pendingRedemptions'),
        alias: null,
        arguments: [],
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
  fragmentDefinitionAssignmentFields,
  fragmentDefinitionChoreFields,
  fragmentDefinitionUserFields,
  fragmentDefinitionRedemptionFields,
  fragmentDefinitionRewardFields,
]);

class Query$Leaderboard {
  Query$Leaderboard({
    required this.leaderboard,
    this.$__typename = 'Query',
  });

  factory Query$Leaderboard.fromJson(Map<String, dynamic> json) {
    final l$leaderboard = json['leaderboard'];
    final l$$__typename = json['__typename'];
    return Query$Leaderboard(
      leaderboard: (l$leaderboard as List<dynamic>)
          .map((e) => Fragment$UserFields.fromJson((e as Map<String, dynamic>)))
          .toList(),
      $__typename: (l$$__typename as String),
    );
  }

  final List<Fragment$UserFields> leaderboard;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$leaderboard = leaderboard;
    _resultData['leaderboard'] = l$leaderboard.map((e) => e.toJson()).toList();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$leaderboard = leaderboard;
    final l$$__typename = $__typename;
    return Object.hashAll([
      Object.hashAll(l$leaderboard.map((v) => v)),
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Query$Leaderboard) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$leaderboard = leaderboard;
    final lOther$leaderboard = other.leaderboard;
    if (l$leaderboard.length != lOther$leaderboard.length) {
      return false;
    }
    for (int i = 0; i < l$leaderboard.length; i++) {
      final l$leaderboard$entry = l$leaderboard[i];
      final lOther$leaderboard$entry = lOther$leaderboard[i];
      if (l$leaderboard$entry != lOther$leaderboard$entry) {
        return false;
      }
    }
    final l$$__typename = $__typename;
    final lOther$$__typename = other.$__typename;
    if (l$$__typename != lOther$$__typename) {
      return false;
    }
    return true;
  }
}

extension UtilityExtension$Query$Leaderboard on Query$Leaderboard {
  CopyWith$Query$Leaderboard<Query$Leaderboard> get copyWith =>
      CopyWith$Query$Leaderboard(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Query$Leaderboard<TRes> {
  factory CopyWith$Query$Leaderboard(
    Query$Leaderboard instance,
    TRes Function(Query$Leaderboard) then,
  ) = _CopyWithImpl$Query$Leaderboard;

  factory CopyWith$Query$Leaderboard.stub(TRes res) =
      _CopyWithStubImpl$Query$Leaderboard;

  TRes call({
    List<Fragment$UserFields>? leaderboard,
    String? $__typename,
  });
  TRes leaderboard(
      Iterable<Fragment$UserFields> Function(
              Iterable<CopyWith$Fragment$UserFields<Fragment$UserFields>>)
          _fn);
}

class _CopyWithImpl$Query$Leaderboard<TRes>
    implements CopyWith$Query$Leaderboard<TRes> {
  _CopyWithImpl$Query$Leaderboard(
    this._instance,
    this._then,
  );

  final Query$Leaderboard _instance;

  final TRes Function(Query$Leaderboard) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? leaderboard = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Query$Leaderboard(
        leaderboard: leaderboard == _undefined || leaderboard == null
            ? _instance.leaderboard
            : (leaderboard as List<Fragment$UserFields>),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  TRes leaderboard(
          Iterable<Fragment$UserFields> Function(
                  Iterable<CopyWith$Fragment$UserFields<Fragment$UserFields>>)
              _fn) =>
      call(
          leaderboard:
              _fn(_instance.leaderboard.map((e) => CopyWith$Fragment$UserFields(
                    e,
                    (i) => i,
                  ))).toList());
}

class _CopyWithStubImpl$Query$Leaderboard<TRes>
    implements CopyWith$Query$Leaderboard<TRes> {
  _CopyWithStubImpl$Query$Leaderboard(this._res);

  TRes _res;

  call({
    List<Fragment$UserFields>? leaderboard,
    String? $__typename,
  }) =>
      _res;

  leaderboard(_fn) => _res;
}

const documentNodeQueryLeaderboard = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.query,
    name: NameNode(value: 'Leaderboard'),
    variableDefinitions: [],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'leaderboard'),
        alias: null,
        arguments: [],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FragmentSpreadNode(
            name: NameNode(value: 'UserFields'),
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
  fragmentDefinitionUserFields,
]);
