import 'fragments.graphql.dart';
import 'package:gql/ast.dart';

class Variables$Mutation$SignUpHousehold {
  factory Variables$Mutation$SignUpHousehold({
    required String householdName,
    required String adultName,
    required String email,
    required String password,
  }) =>
      Variables$Mutation$SignUpHousehold._({
        r'householdName': householdName,
        r'adultName': adultName,
        r'email': email,
        r'password': password,
      });

  Variables$Mutation$SignUpHousehold._(this._$data);

  factory Variables$Mutation$SignUpHousehold.fromJson(
      Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$householdName = data['householdName'];
    result$data['householdName'] = (l$householdName as String);
    final l$adultName = data['adultName'];
    result$data['adultName'] = (l$adultName as String);
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Variables$Mutation$SignUpHousehold._(result$data);
  }

  Map<String, dynamic> _$data;

  String get householdName => (_$data['householdName'] as String);

  String get adultName => (_$data['adultName'] as String);

  String get email => (_$data['email'] as String);

  String get password => (_$data['password'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$householdName = householdName;
    result$data['householdName'] = l$householdName;
    final l$adultName = adultName;
    result$data['adultName'] = l$adultName;
    final l$email = email;
    result$data['email'] = l$email;
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  CopyWith$Variables$Mutation$SignUpHousehold<
          Variables$Mutation$SignUpHousehold>
      get copyWith => CopyWith$Variables$Mutation$SignUpHousehold(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$SignUpHousehold) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$householdName = householdName;
    final lOther$householdName = other.householdName;
    if (l$householdName != lOther$householdName) {
      return false;
    }
    final l$adultName = adultName;
    final lOther$adultName = other.adultName;
    if (l$adultName != lOther$adultName) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$householdName = householdName;
    final l$adultName = adultName;
    final l$email = email;
    final l$password = password;
    return Object.hashAll([
      l$householdName,
      l$adultName,
      l$email,
      l$password,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$SignUpHousehold<TRes> {
  factory CopyWith$Variables$Mutation$SignUpHousehold(
    Variables$Mutation$SignUpHousehold instance,
    TRes Function(Variables$Mutation$SignUpHousehold) then,
  ) = _CopyWithImpl$Variables$Mutation$SignUpHousehold;

  factory CopyWith$Variables$Mutation$SignUpHousehold.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$SignUpHousehold;

  TRes call({
    String? householdName,
    String? adultName,
    String? email,
    String? password,
  });
}

class _CopyWithImpl$Variables$Mutation$SignUpHousehold<TRes>
    implements CopyWith$Variables$Mutation$SignUpHousehold<TRes> {
  _CopyWithImpl$Variables$Mutation$SignUpHousehold(
    this._instance,
    this._then,
  );

  final Variables$Mutation$SignUpHousehold _instance;

  final TRes Function(Variables$Mutation$SignUpHousehold) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? householdName = _undefined,
    Object? adultName = _undefined,
    Object? email = _undefined,
    Object? password = _undefined,
  }) =>
      _then(Variables$Mutation$SignUpHousehold._({
        ..._instance._$data,
        if (householdName != _undefined && householdName != null)
          'householdName': (householdName as String),
        if (adultName != _undefined && adultName != null)
          'adultName': (adultName as String),
        if (email != _undefined && email != null) 'email': (email as String),
        if (password != _undefined && password != null)
          'password': (password as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$SignUpHousehold<TRes>
    implements CopyWith$Variables$Mutation$SignUpHousehold<TRes> {
  _CopyWithStubImpl$Variables$Mutation$SignUpHousehold(this._res);

  TRes _res;

  call({
    String? householdName,
    String? adultName,
    String? email,
    String? password,
  }) =>
      _res;
}

class Mutation$SignUpHousehold {
  Mutation$SignUpHousehold({
    required this.signUpHousehold,
    this.$__typename = 'Mutation',
  });

  factory Mutation$SignUpHousehold.fromJson(Map<String, dynamic> json) {
    final l$signUpHousehold = json['signUpHousehold'];
    final l$$__typename = json['__typename'];
    return Mutation$SignUpHousehold(
      signUpHousehold: Mutation$SignUpHousehold$signUpHousehold.fromJson(
          (l$signUpHousehold as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$SignUpHousehold$signUpHousehold signUpHousehold;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$signUpHousehold = signUpHousehold;
    _resultData['signUpHousehold'] = l$signUpHousehold.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$signUpHousehold = signUpHousehold;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$signUpHousehold,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$SignUpHousehold) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$signUpHousehold = signUpHousehold;
    final lOther$signUpHousehold = other.signUpHousehold;
    if (l$signUpHousehold != lOther$signUpHousehold) {
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

extension UtilityExtension$Mutation$SignUpHousehold
    on Mutation$SignUpHousehold {
  CopyWith$Mutation$SignUpHousehold<Mutation$SignUpHousehold> get copyWith =>
      CopyWith$Mutation$SignUpHousehold(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$SignUpHousehold<TRes> {
  factory CopyWith$Mutation$SignUpHousehold(
    Mutation$SignUpHousehold instance,
    TRes Function(Mutation$SignUpHousehold) then,
  ) = _CopyWithImpl$Mutation$SignUpHousehold;

  factory CopyWith$Mutation$SignUpHousehold.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SignUpHousehold;

  TRes call({
    Mutation$SignUpHousehold$signUpHousehold? signUpHousehold,
    String? $__typename,
  });
  CopyWith$Mutation$SignUpHousehold$signUpHousehold<TRes> get signUpHousehold;
}

class _CopyWithImpl$Mutation$SignUpHousehold<TRes>
    implements CopyWith$Mutation$SignUpHousehold<TRes> {
  _CopyWithImpl$Mutation$SignUpHousehold(
    this._instance,
    this._then,
  );

  final Mutation$SignUpHousehold _instance;

  final TRes Function(Mutation$SignUpHousehold) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? signUpHousehold = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SignUpHousehold(
        signUpHousehold:
            signUpHousehold == _undefined || signUpHousehold == null
                ? _instance.signUpHousehold
                : (signUpHousehold as Mutation$SignUpHousehold$signUpHousehold),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$SignUpHousehold$signUpHousehold<TRes> get signUpHousehold {
    final local$signUpHousehold = _instance.signUpHousehold;
    return CopyWith$Mutation$SignUpHousehold$signUpHousehold(
        local$signUpHousehold, (e) => call(signUpHousehold: e));
  }
}

class _CopyWithStubImpl$Mutation$SignUpHousehold<TRes>
    implements CopyWith$Mutation$SignUpHousehold<TRes> {
  _CopyWithStubImpl$Mutation$SignUpHousehold(this._res);

  TRes _res;

  call({
    Mutation$SignUpHousehold$signUpHousehold? signUpHousehold,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$SignUpHousehold$signUpHousehold<TRes> get signUpHousehold =>
      CopyWith$Mutation$SignUpHousehold$signUpHousehold.stub(_res);
}

const documentNodeMutationSignUpHousehold = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'SignUpHousehold'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'householdName')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'adultName')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'email')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'password')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'signUpHousehold'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'householdName'),
            value: VariableNode(name: NameNode(value: 'householdName')),
          ),
          ArgumentNode(
            name: NameNode(value: 'adultName'),
            value: VariableNode(name: NameNode(value: 'adultName')),
          ),
          ArgumentNode(
            name: NameNode(value: 'email'),
            value: VariableNode(name: NameNode(value: 'email')),
          ),
          ArgumentNode(
            name: NameNode(value: 'password'),
            value: VariableNode(name: NameNode(value: 'password')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'token'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'user'),
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

class Mutation$SignUpHousehold$signUpHousehold {
  Mutation$SignUpHousehold$signUpHousehold({
    required this.token,
    required this.user,
    this.$__typename = 'AuthPayload',
  });

  factory Mutation$SignUpHousehold$signUpHousehold.fromJson(
      Map<String, dynamic> json) {
    final l$token = json['token'];
    final l$user = json['user'];
    final l$$__typename = json['__typename'];
    return Mutation$SignUpHousehold$signUpHousehold(
      token: (l$token as String),
      user: Fragment$UserFields.fromJson((l$user as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String token;

  final Fragment$UserFields user;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$token = token;
    _resultData['token'] = l$token;
    final l$user = user;
    _resultData['user'] = l$user.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$token = token;
    final l$user = user;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$token,
      l$user,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$SignUpHousehold$signUpHousehold) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
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

extension UtilityExtension$Mutation$SignUpHousehold$signUpHousehold
    on Mutation$SignUpHousehold$signUpHousehold {
  CopyWith$Mutation$SignUpHousehold$signUpHousehold<
          Mutation$SignUpHousehold$signUpHousehold>
      get copyWith => CopyWith$Mutation$SignUpHousehold$signUpHousehold(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$SignUpHousehold$signUpHousehold<TRes> {
  factory CopyWith$Mutation$SignUpHousehold$signUpHousehold(
    Mutation$SignUpHousehold$signUpHousehold instance,
    TRes Function(Mutation$SignUpHousehold$signUpHousehold) then,
  ) = _CopyWithImpl$Mutation$SignUpHousehold$signUpHousehold;

  factory CopyWith$Mutation$SignUpHousehold$signUpHousehold.stub(TRes res) =
      _CopyWithStubImpl$Mutation$SignUpHousehold$signUpHousehold;

  TRes call({
    String? token,
    Fragment$UserFields? user,
    String? $__typename,
  });
  CopyWith$Fragment$UserFields<TRes> get user;
}

class _CopyWithImpl$Mutation$SignUpHousehold$signUpHousehold<TRes>
    implements CopyWith$Mutation$SignUpHousehold$signUpHousehold<TRes> {
  _CopyWithImpl$Mutation$SignUpHousehold$signUpHousehold(
    this._instance,
    this._then,
  );

  final Mutation$SignUpHousehold$signUpHousehold _instance;

  final TRes Function(Mutation$SignUpHousehold$signUpHousehold) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? token = _undefined,
    Object? user = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$SignUpHousehold$signUpHousehold(
        token: token == _undefined || token == null
            ? _instance.token
            : (token as String),
        user: user == _undefined || user == null
            ? _instance.user
            : (user as Fragment$UserFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$UserFields<TRes> get user {
    final local$user = _instance.user;
    return CopyWith$Fragment$UserFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$SignUpHousehold$signUpHousehold<TRes>
    implements CopyWith$Mutation$SignUpHousehold$signUpHousehold<TRes> {
  _CopyWithStubImpl$Mutation$SignUpHousehold$signUpHousehold(this._res);

  TRes _res;

  call({
    String? token,
    Fragment$UserFields? user,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$UserFields<TRes> get user =>
      CopyWith$Fragment$UserFields.stub(_res);
}

class Variables$Mutation$LoginAdult {
  factory Variables$Mutation$LoginAdult({
    required String email,
    required String password,
  }) =>
      Variables$Mutation$LoginAdult._({
        r'email': email,
        r'password': password,
      });

  Variables$Mutation$LoginAdult._(this._$data);

  factory Variables$Mutation$LoginAdult.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Variables$Mutation$LoginAdult._(result$data);
  }

  Map<String, dynamic> _$data;

  String get email => (_$data['email'] as String);

  String get password => (_$data['password'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$email = email;
    result$data['email'] = l$email;
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  CopyWith$Variables$Mutation$LoginAdult<Variables$Mutation$LoginAdult>
      get copyWith => CopyWith$Variables$Mutation$LoginAdult(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$LoginAdult) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$email = email;
    final l$password = password;
    return Object.hashAll([
      l$email,
      l$password,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$LoginAdult<TRes> {
  factory CopyWith$Variables$Mutation$LoginAdult(
    Variables$Mutation$LoginAdult instance,
    TRes Function(Variables$Mutation$LoginAdult) then,
  ) = _CopyWithImpl$Variables$Mutation$LoginAdult;

  factory CopyWith$Variables$Mutation$LoginAdult.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$LoginAdult;

  TRes call({
    String? email,
    String? password,
  });
}

class _CopyWithImpl$Variables$Mutation$LoginAdult<TRes>
    implements CopyWith$Variables$Mutation$LoginAdult<TRes> {
  _CopyWithImpl$Variables$Mutation$LoginAdult(
    this._instance,
    this._then,
  );

  final Variables$Mutation$LoginAdult _instance;

  final TRes Function(Variables$Mutation$LoginAdult) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? email = _undefined,
    Object? password = _undefined,
  }) =>
      _then(Variables$Mutation$LoginAdult._({
        ..._instance._$data,
        if (email != _undefined && email != null) 'email': (email as String),
        if (password != _undefined && password != null)
          'password': (password as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$LoginAdult<TRes>
    implements CopyWith$Variables$Mutation$LoginAdult<TRes> {
  _CopyWithStubImpl$Variables$Mutation$LoginAdult(this._res);

  TRes _res;

  call({
    String? email,
    String? password,
  }) =>
      _res;
}

class Mutation$LoginAdult {
  Mutation$LoginAdult({
    required this.loginAdult,
    this.$__typename = 'Mutation',
  });

  factory Mutation$LoginAdult.fromJson(Map<String, dynamic> json) {
    final l$loginAdult = json['loginAdult'];
    final l$$__typename = json['__typename'];
    return Mutation$LoginAdult(
      loginAdult: Mutation$LoginAdult$loginAdult.fromJson(
          (l$loginAdult as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$LoginAdult$loginAdult loginAdult;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$loginAdult = loginAdult;
    _resultData['loginAdult'] = l$loginAdult.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$loginAdult = loginAdult;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$loginAdult,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$LoginAdult) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$loginAdult = loginAdult;
    final lOther$loginAdult = other.loginAdult;
    if (l$loginAdult != lOther$loginAdult) {
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

extension UtilityExtension$Mutation$LoginAdult on Mutation$LoginAdult {
  CopyWith$Mutation$LoginAdult<Mutation$LoginAdult> get copyWith =>
      CopyWith$Mutation$LoginAdult(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$LoginAdult<TRes> {
  factory CopyWith$Mutation$LoginAdult(
    Mutation$LoginAdult instance,
    TRes Function(Mutation$LoginAdult) then,
  ) = _CopyWithImpl$Mutation$LoginAdult;

  factory CopyWith$Mutation$LoginAdult.stub(TRes res) =
      _CopyWithStubImpl$Mutation$LoginAdult;

  TRes call({
    Mutation$LoginAdult$loginAdult? loginAdult,
    String? $__typename,
  });
  CopyWith$Mutation$LoginAdult$loginAdult<TRes> get loginAdult;
}

class _CopyWithImpl$Mutation$LoginAdult<TRes>
    implements CopyWith$Mutation$LoginAdult<TRes> {
  _CopyWithImpl$Mutation$LoginAdult(
    this._instance,
    this._then,
  );

  final Mutation$LoginAdult _instance;

  final TRes Function(Mutation$LoginAdult) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? loginAdult = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$LoginAdult(
        loginAdult: loginAdult == _undefined || loginAdult == null
            ? _instance.loginAdult
            : (loginAdult as Mutation$LoginAdult$loginAdult),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$LoginAdult$loginAdult<TRes> get loginAdult {
    final local$loginAdult = _instance.loginAdult;
    return CopyWith$Mutation$LoginAdult$loginAdult(
        local$loginAdult, (e) => call(loginAdult: e));
  }
}

class _CopyWithStubImpl$Mutation$LoginAdult<TRes>
    implements CopyWith$Mutation$LoginAdult<TRes> {
  _CopyWithStubImpl$Mutation$LoginAdult(this._res);

  TRes _res;

  call({
    Mutation$LoginAdult$loginAdult? loginAdult,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$LoginAdult$loginAdult<TRes> get loginAdult =>
      CopyWith$Mutation$LoginAdult$loginAdult.stub(_res);
}

const documentNodeMutationLoginAdult = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'LoginAdult'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'email')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'password')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'loginAdult'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'email'),
            value: VariableNode(name: NameNode(value: 'email')),
          ),
          ArgumentNode(
            name: NameNode(value: 'password'),
            value: VariableNode(name: NameNode(value: 'password')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'token'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'user'),
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

class Mutation$LoginAdult$loginAdult {
  Mutation$LoginAdult$loginAdult({
    required this.token,
    required this.user,
    this.$__typename = 'AuthPayload',
  });

  factory Mutation$LoginAdult$loginAdult.fromJson(Map<String, dynamic> json) {
    final l$token = json['token'];
    final l$user = json['user'];
    final l$$__typename = json['__typename'];
    return Mutation$LoginAdult$loginAdult(
      token: (l$token as String),
      user: Fragment$UserFields.fromJson((l$user as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String token;

  final Fragment$UserFields user;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$token = token;
    _resultData['token'] = l$token;
    final l$user = user;
    _resultData['user'] = l$user.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$token = token;
    final l$user = user;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$token,
      l$user,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$LoginAdult$loginAdult) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
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

extension UtilityExtension$Mutation$LoginAdult$loginAdult
    on Mutation$LoginAdult$loginAdult {
  CopyWith$Mutation$LoginAdult$loginAdult<Mutation$LoginAdult$loginAdult>
      get copyWith => CopyWith$Mutation$LoginAdult$loginAdult(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$LoginAdult$loginAdult<TRes> {
  factory CopyWith$Mutation$LoginAdult$loginAdult(
    Mutation$LoginAdult$loginAdult instance,
    TRes Function(Mutation$LoginAdult$loginAdult) then,
  ) = _CopyWithImpl$Mutation$LoginAdult$loginAdult;

  factory CopyWith$Mutation$LoginAdult$loginAdult.stub(TRes res) =
      _CopyWithStubImpl$Mutation$LoginAdult$loginAdult;

  TRes call({
    String? token,
    Fragment$UserFields? user,
    String? $__typename,
  });
  CopyWith$Fragment$UserFields<TRes> get user;
}

class _CopyWithImpl$Mutation$LoginAdult$loginAdult<TRes>
    implements CopyWith$Mutation$LoginAdult$loginAdult<TRes> {
  _CopyWithImpl$Mutation$LoginAdult$loginAdult(
    this._instance,
    this._then,
  );

  final Mutation$LoginAdult$loginAdult _instance;

  final TRes Function(Mutation$LoginAdult$loginAdult) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? token = _undefined,
    Object? user = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$LoginAdult$loginAdult(
        token: token == _undefined || token == null
            ? _instance.token
            : (token as String),
        user: user == _undefined || user == null
            ? _instance.user
            : (user as Fragment$UserFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$UserFields<TRes> get user {
    final local$user = _instance.user;
    return CopyWith$Fragment$UserFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$LoginAdult$loginAdult<TRes>
    implements CopyWith$Mutation$LoginAdult$loginAdult<TRes> {
  _CopyWithStubImpl$Mutation$LoginAdult$loginAdult(this._res);

  TRes _res;

  call({
    String? token,
    Fragment$UserFields? user,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$UserFields<TRes> get user =>
      CopyWith$Fragment$UserFields.stub(_res);
}

class Variables$Mutation$KidLogin {
  factory Variables$Mutation$KidLogin({
    required String userId,
    required String pin,
  }) =>
      Variables$Mutation$KidLogin._({
        r'userId': userId,
        r'pin': pin,
      });

  Variables$Mutation$KidLogin._(this._$data);

  factory Variables$Mutation$KidLogin.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$userId = data['userId'];
    result$data['userId'] = (l$userId as String);
    final l$pin = data['pin'];
    result$data['pin'] = (l$pin as String);
    return Variables$Mutation$KidLogin._(result$data);
  }

  Map<String, dynamic> _$data;

  String get userId => (_$data['userId'] as String);

  String get pin => (_$data['pin'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$userId = userId;
    result$data['userId'] = l$userId;
    final l$pin = pin;
    result$data['pin'] = l$pin;
    return result$data;
  }

  CopyWith$Variables$Mutation$KidLogin<Variables$Mutation$KidLogin>
      get copyWith => CopyWith$Variables$Mutation$KidLogin(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$KidLogin) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$userId = userId;
    final lOther$userId = other.userId;
    if (l$userId != lOther$userId) {
      return false;
    }
    final l$pin = pin;
    final lOther$pin = other.pin;
    if (l$pin != lOther$pin) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$userId = userId;
    final l$pin = pin;
    return Object.hashAll([
      l$userId,
      l$pin,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$KidLogin<TRes> {
  factory CopyWith$Variables$Mutation$KidLogin(
    Variables$Mutation$KidLogin instance,
    TRes Function(Variables$Mutation$KidLogin) then,
  ) = _CopyWithImpl$Variables$Mutation$KidLogin;

  factory CopyWith$Variables$Mutation$KidLogin.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$KidLogin;

  TRes call({
    String? userId,
    String? pin,
  });
}

class _CopyWithImpl$Variables$Mutation$KidLogin<TRes>
    implements CopyWith$Variables$Mutation$KidLogin<TRes> {
  _CopyWithImpl$Variables$Mutation$KidLogin(
    this._instance,
    this._then,
  );

  final Variables$Mutation$KidLogin _instance;

  final TRes Function(Variables$Mutation$KidLogin) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? userId = _undefined,
    Object? pin = _undefined,
  }) =>
      _then(Variables$Mutation$KidLogin._({
        ..._instance._$data,
        if (userId != _undefined && userId != null)
          'userId': (userId as String),
        if (pin != _undefined && pin != null) 'pin': (pin as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$KidLogin<TRes>
    implements CopyWith$Variables$Mutation$KidLogin<TRes> {
  _CopyWithStubImpl$Variables$Mutation$KidLogin(this._res);

  TRes _res;

  call({
    String? userId,
    String? pin,
  }) =>
      _res;
}

class Mutation$KidLogin {
  Mutation$KidLogin({
    required this.kidLogin,
    this.$__typename = 'Mutation',
  });

  factory Mutation$KidLogin.fromJson(Map<String, dynamic> json) {
    final l$kidLogin = json['kidLogin'];
    final l$$__typename = json['__typename'];
    return Mutation$KidLogin(
      kidLogin: Mutation$KidLogin$kidLogin.fromJson(
          (l$kidLogin as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Mutation$KidLogin$kidLogin kidLogin;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$kidLogin = kidLogin;
    _resultData['kidLogin'] = l$kidLogin.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$kidLogin = kidLogin;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$kidLogin,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$KidLogin) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$kidLogin = kidLogin;
    final lOther$kidLogin = other.kidLogin;
    if (l$kidLogin != lOther$kidLogin) {
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

extension UtilityExtension$Mutation$KidLogin on Mutation$KidLogin {
  CopyWith$Mutation$KidLogin<Mutation$KidLogin> get copyWith =>
      CopyWith$Mutation$KidLogin(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$KidLogin<TRes> {
  factory CopyWith$Mutation$KidLogin(
    Mutation$KidLogin instance,
    TRes Function(Mutation$KidLogin) then,
  ) = _CopyWithImpl$Mutation$KidLogin;

  factory CopyWith$Mutation$KidLogin.stub(TRes res) =
      _CopyWithStubImpl$Mutation$KidLogin;

  TRes call({
    Mutation$KidLogin$kidLogin? kidLogin,
    String? $__typename,
  });
  CopyWith$Mutation$KidLogin$kidLogin<TRes> get kidLogin;
}

class _CopyWithImpl$Mutation$KidLogin<TRes>
    implements CopyWith$Mutation$KidLogin<TRes> {
  _CopyWithImpl$Mutation$KidLogin(
    this._instance,
    this._then,
  );

  final Mutation$KidLogin _instance;

  final TRes Function(Mutation$KidLogin) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? kidLogin = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$KidLogin(
        kidLogin: kidLogin == _undefined || kidLogin == null
            ? _instance.kidLogin
            : (kidLogin as Mutation$KidLogin$kidLogin),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Mutation$KidLogin$kidLogin<TRes> get kidLogin {
    final local$kidLogin = _instance.kidLogin;
    return CopyWith$Mutation$KidLogin$kidLogin(
        local$kidLogin, (e) => call(kidLogin: e));
  }
}

class _CopyWithStubImpl$Mutation$KidLogin<TRes>
    implements CopyWith$Mutation$KidLogin<TRes> {
  _CopyWithStubImpl$Mutation$KidLogin(this._res);

  TRes _res;

  call({
    Mutation$KidLogin$kidLogin? kidLogin,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Mutation$KidLogin$kidLogin<TRes> get kidLogin =>
      CopyWith$Mutation$KidLogin$kidLogin.stub(_res);
}

const documentNodeMutationKidLogin = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'KidLogin'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'userId')),
        type: NamedTypeNode(
          name: NameNode(value: 'UUID'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'pin')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'kidLogin'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'userId'),
            value: VariableNode(name: NameNode(value: 'userId')),
          ),
          ArgumentNode(
            name: NameNode(value: 'pin'),
            value: VariableNode(name: NameNode(value: 'pin')),
          ),
        ],
        directives: [],
        selectionSet: SelectionSetNode(selections: [
          FieldNode(
            name: NameNode(value: 'token'),
            alias: null,
            arguments: [],
            directives: [],
            selectionSet: null,
          ),
          FieldNode(
            name: NameNode(value: 'user'),
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

class Mutation$KidLogin$kidLogin {
  Mutation$KidLogin$kidLogin({
    required this.token,
    required this.user,
    this.$__typename = 'AuthPayload',
  });

  factory Mutation$KidLogin$kidLogin.fromJson(Map<String, dynamic> json) {
    final l$token = json['token'];
    final l$user = json['user'];
    final l$$__typename = json['__typename'];
    return Mutation$KidLogin$kidLogin(
      token: (l$token as String),
      user: Fragment$UserFields.fromJson((l$user as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String token;

  final Fragment$UserFields user;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$token = token;
    _resultData['token'] = l$token;
    final l$user = user;
    _resultData['user'] = l$user.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$token = token;
    final l$user = user;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$token,
      l$user,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$KidLogin$kidLogin) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$token = token;
    final lOther$token = other.token;
    if (l$token != lOther$token) {
      return false;
    }
    final l$user = user;
    final lOther$user = other.user;
    if (l$user != lOther$user) {
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

extension UtilityExtension$Mutation$KidLogin$kidLogin
    on Mutation$KidLogin$kidLogin {
  CopyWith$Mutation$KidLogin$kidLogin<Mutation$KidLogin$kidLogin>
      get copyWith => CopyWith$Mutation$KidLogin$kidLogin(
            this,
            (i) => i,
          );
}

abstract class CopyWith$Mutation$KidLogin$kidLogin<TRes> {
  factory CopyWith$Mutation$KidLogin$kidLogin(
    Mutation$KidLogin$kidLogin instance,
    TRes Function(Mutation$KidLogin$kidLogin) then,
  ) = _CopyWithImpl$Mutation$KidLogin$kidLogin;

  factory CopyWith$Mutation$KidLogin$kidLogin.stub(TRes res) =
      _CopyWithStubImpl$Mutation$KidLogin$kidLogin;

  TRes call({
    String? token,
    Fragment$UserFields? user,
    String? $__typename,
  });
  CopyWith$Fragment$UserFields<TRes> get user;
}

class _CopyWithImpl$Mutation$KidLogin$kidLogin<TRes>
    implements CopyWith$Mutation$KidLogin$kidLogin<TRes> {
  _CopyWithImpl$Mutation$KidLogin$kidLogin(
    this._instance,
    this._then,
  );

  final Mutation$KidLogin$kidLogin _instance;

  final TRes Function(Mutation$KidLogin$kidLogin) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? token = _undefined,
    Object? user = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$KidLogin$kidLogin(
        token: token == _undefined || token == null
            ? _instance.token
            : (token as String),
        user: user == _undefined || user == null
            ? _instance.user
            : (user as Fragment$UserFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$UserFields<TRes> get user {
    final local$user = _instance.user;
    return CopyWith$Fragment$UserFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Mutation$KidLogin$kidLogin<TRes>
    implements CopyWith$Mutation$KidLogin$kidLogin<TRes> {
  _CopyWithStubImpl$Mutation$KidLogin$kidLogin(this._res);

  TRes _res;

  call({
    String? token,
    Fragment$UserFields? user,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$UserFields<TRes> get user =>
      CopyWith$Fragment$UserFields.stub(_res);
}

class Variables$Mutation$AddChild {
  factory Variables$Mutation$AddChild({
    required String name,
    required String pin,
    String? avatarEmoji,
  }) =>
      Variables$Mutation$AddChild._({
        r'name': name,
        r'pin': pin,
        if (avatarEmoji != null) r'avatarEmoji': avatarEmoji,
      });

  Variables$Mutation$AddChild._(this._$data);

  factory Variables$Mutation$AddChild.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$pin = data['pin'];
    result$data['pin'] = (l$pin as String);
    if (data.containsKey('avatarEmoji')) {
      final l$avatarEmoji = data['avatarEmoji'];
      result$data['avatarEmoji'] = (l$avatarEmoji as String?);
    }
    return Variables$Mutation$AddChild._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  String get pin => (_$data['pin'] as String);

  String? get avatarEmoji => (_$data['avatarEmoji'] as String?);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    final l$pin = pin;
    result$data['pin'] = l$pin;
    if (_$data.containsKey('avatarEmoji')) {
      final l$avatarEmoji = avatarEmoji;
      result$data['avatarEmoji'] = l$avatarEmoji;
    }
    return result$data;
  }

  CopyWith$Variables$Mutation$AddChild<Variables$Mutation$AddChild>
      get copyWith => CopyWith$Variables$Mutation$AddChild(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$AddChild) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$pin = pin;
    final lOther$pin = other.pin;
    if (l$pin != lOther$pin) {
      return false;
    }
    final l$avatarEmoji = avatarEmoji;
    final lOther$avatarEmoji = other.avatarEmoji;
    if (_$data.containsKey('avatarEmoji') !=
        other._$data.containsKey('avatarEmoji')) {
      return false;
    }
    if (l$avatarEmoji != lOther$avatarEmoji) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$pin = pin;
    final l$avatarEmoji = avatarEmoji;
    return Object.hashAll([
      l$name,
      l$pin,
      _$data.containsKey('avatarEmoji') ? l$avatarEmoji : const {},
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$AddChild<TRes> {
  factory CopyWith$Variables$Mutation$AddChild(
    Variables$Mutation$AddChild instance,
    TRes Function(Variables$Mutation$AddChild) then,
  ) = _CopyWithImpl$Variables$Mutation$AddChild;

  factory CopyWith$Variables$Mutation$AddChild.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$AddChild;

  TRes call({
    String? name,
    String? pin,
    String? avatarEmoji,
  });
}

class _CopyWithImpl$Variables$Mutation$AddChild<TRes>
    implements CopyWith$Variables$Mutation$AddChild<TRes> {
  _CopyWithImpl$Variables$Mutation$AddChild(
    this._instance,
    this._then,
  );

  final Variables$Mutation$AddChild _instance;

  final TRes Function(Variables$Mutation$AddChild) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? name = _undefined,
    Object? pin = _undefined,
    Object? avatarEmoji = _undefined,
  }) =>
      _then(Variables$Mutation$AddChild._({
        ..._instance._$data,
        if (name != _undefined && name != null) 'name': (name as String),
        if (pin != _undefined && pin != null) 'pin': (pin as String),
        if (avatarEmoji != _undefined) 'avatarEmoji': (avatarEmoji as String?),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$AddChild<TRes>
    implements CopyWith$Variables$Mutation$AddChild<TRes> {
  _CopyWithStubImpl$Variables$Mutation$AddChild(this._res);

  TRes _res;

  call({
    String? name,
    String? pin,
    String? avatarEmoji,
  }) =>
      _res;
}

class Mutation$AddChild {
  Mutation$AddChild({
    required this.addChild,
    this.$__typename = 'Mutation',
  });

  factory Mutation$AddChild.fromJson(Map<String, dynamic> json) {
    final l$addChild = json['addChild'];
    final l$$__typename = json['__typename'];
    return Mutation$AddChild(
      addChild:
          Fragment$UserFields.fromJson((l$addChild as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$UserFields addChild;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$addChild = addChild;
    _resultData['addChild'] = l$addChild.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$addChild = addChild;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$addChild,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$AddChild) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$addChild = addChild;
    final lOther$addChild = other.addChild;
    if (l$addChild != lOther$addChild) {
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

extension UtilityExtension$Mutation$AddChild on Mutation$AddChild {
  CopyWith$Mutation$AddChild<Mutation$AddChild> get copyWith =>
      CopyWith$Mutation$AddChild(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$AddChild<TRes> {
  factory CopyWith$Mutation$AddChild(
    Mutation$AddChild instance,
    TRes Function(Mutation$AddChild) then,
  ) = _CopyWithImpl$Mutation$AddChild;

  factory CopyWith$Mutation$AddChild.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddChild;

  TRes call({
    Fragment$UserFields? addChild,
    String? $__typename,
  });
  CopyWith$Fragment$UserFields<TRes> get addChild;
}

class _CopyWithImpl$Mutation$AddChild<TRes>
    implements CopyWith$Mutation$AddChild<TRes> {
  _CopyWithImpl$Mutation$AddChild(
    this._instance,
    this._then,
  );

  final Mutation$AddChild _instance;

  final TRes Function(Mutation$AddChild) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? addChild = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$AddChild(
        addChild: addChild == _undefined || addChild == null
            ? _instance.addChild
            : (addChild as Fragment$UserFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$UserFields<TRes> get addChild {
    final local$addChild = _instance.addChild;
    return CopyWith$Fragment$UserFields(
        local$addChild, (e) => call(addChild: e));
  }
}

class _CopyWithStubImpl$Mutation$AddChild<TRes>
    implements CopyWith$Mutation$AddChild<TRes> {
  _CopyWithStubImpl$Mutation$AddChild(this._res);

  TRes _res;

  call({
    Fragment$UserFields? addChild,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$UserFields<TRes> get addChild =>
      CopyWith$Fragment$UserFields.stub(_res);
}

const documentNodeMutationAddChild = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'AddChild'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'name')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'pin')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'avatarEmoji')),
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
        name: NameNode(value: 'addChild'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'name'),
            value: VariableNode(name: NameNode(value: 'name')),
          ),
          ArgumentNode(
            name: NameNode(value: 'pin'),
            value: VariableNode(name: NameNode(value: 'pin')),
          ),
          ArgumentNode(
            name: NameNode(value: 'avatarEmoji'),
            value: VariableNode(name: NameNode(value: 'avatarEmoji')),
          ),
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

class Variables$Mutation$AddAdult {
  factory Variables$Mutation$AddAdult({
    required String name,
    required String email,
    required String password,
  }) =>
      Variables$Mutation$AddAdult._({
        r'name': name,
        r'email': email,
        r'password': password,
      });

  Variables$Mutation$AddAdult._(this._$data);

  factory Variables$Mutation$AddAdult.fromJson(Map<String, dynamic> data) {
    final result$data = <String, dynamic>{};
    final l$name = data['name'];
    result$data['name'] = (l$name as String);
    final l$email = data['email'];
    result$data['email'] = (l$email as String);
    final l$password = data['password'];
    result$data['password'] = (l$password as String);
    return Variables$Mutation$AddAdult._(result$data);
  }

  Map<String, dynamic> _$data;

  String get name => (_$data['name'] as String);

  String get email => (_$data['email'] as String);

  String get password => (_$data['password'] as String);

  Map<String, dynamic> toJson() {
    final result$data = <String, dynamic>{};
    final l$name = name;
    result$data['name'] = l$name;
    final l$email = email;
    result$data['email'] = l$email;
    final l$password = password;
    result$data['password'] = l$password;
    return result$data;
  }

  CopyWith$Variables$Mutation$AddAdult<Variables$Mutation$AddAdult>
      get copyWith => CopyWith$Variables$Mutation$AddAdult(
            this,
            (i) => i,
          );

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Variables$Mutation$AddAdult) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
      return false;
    }
    final l$password = password;
    final lOther$password = other.password;
    if (l$password != lOther$password) {
      return false;
    }
    return true;
  }

  @override
  int get hashCode {
    final l$name = name;
    final l$email = email;
    final l$password = password;
    return Object.hashAll([
      l$name,
      l$email,
      l$password,
    ]);
  }
}

abstract class CopyWith$Variables$Mutation$AddAdult<TRes> {
  factory CopyWith$Variables$Mutation$AddAdult(
    Variables$Mutation$AddAdult instance,
    TRes Function(Variables$Mutation$AddAdult) then,
  ) = _CopyWithImpl$Variables$Mutation$AddAdult;

  factory CopyWith$Variables$Mutation$AddAdult.stub(TRes res) =
      _CopyWithStubImpl$Variables$Mutation$AddAdult;

  TRes call({
    String? name,
    String? email,
    String? password,
  });
}

class _CopyWithImpl$Variables$Mutation$AddAdult<TRes>
    implements CopyWith$Variables$Mutation$AddAdult<TRes> {
  _CopyWithImpl$Variables$Mutation$AddAdult(
    this._instance,
    this._then,
  );

  final Variables$Mutation$AddAdult _instance;

  final TRes Function(Variables$Mutation$AddAdult) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? name = _undefined,
    Object? email = _undefined,
    Object? password = _undefined,
  }) =>
      _then(Variables$Mutation$AddAdult._({
        ..._instance._$data,
        if (name != _undefined && name != null) 'name': (name as String),
        if (email != _undefined && email != null) 'email': (email as String),
        if (password != _undefined && password != null)
          'password': (password as String),
      }));
}

class _CopyWithStubImpl$Variables$Mutation$AddAdult<TRes>
    implements CopyWith$Variables$Mutation$AddAdult<TRes> {
  _CopyWithStubImpl$Variables$Mutation$AddAdult(this._res);

  TRes _res;

  call({
    String? name,
    String? email,
    String? password,
  }) =>
      _res;
}

class Mutation$AddAdult {
  Mutation$AddAdult({
    required this.addAdult,
    this.$__typename = 'Mutation',
  });

  factory Mutation$AddAdult.fromJson(Map<String, dynamic> json) {
    final l$addAdult = json['addAdult'];
    final l$$__typename = json['__typename'];
    return Mutation$AddAdult(
      addAdult:
          Fragment$UserFields.fromJson((l$addAdult as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final Fragment$UserFields addAdult;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$addAdult = addAdult;
    _resultData['addAdult'] = l$addAdult.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$addAdult = addAdult;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$addAdult,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Mutation$AddAdult) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$addAdult = addAdult;
    final lOther$addAdult = other.addAdult;
    if (l$addAdult != lOther$addAdult) {
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

extension UtilityExtension$Mutation$AddAdult on Mutation$AddAdult {
  CopyWith$Mutation$AddAdult<Mutation$AddAdult> get copyWith =>
      CopyWith$Mutation$AddAdult(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Mutation$AddAdult<TRes> {
  factory CopyWith$Mutation$AddAdult(
    Mutation$AddAdult instance,
    TRes Function(Mutation$AddAdult) then,
  ) = _CopyWithImpl$Mutation$AddAdult;

  factory CopyWith$Mutation$AddAdult.stub(TRes res) =
      _CopyWithStubImpl$Mutation$AddAdult;

  TRes call({
    Fragment$UserFields? addAdult,
    String? $__typename,
  });
  CopyWith$Fragment$UserFields<TRes> get addAdult;
}

class _CopyWithImpl$Mutation$AddAdult<TRes>
    implements CopyWith$Mutation$AddAdult<TRes> {
  _CopyWithImpl$Mutation$AddAdult(
    this._instance,
    this._then,
  );

  final Mutation$AddAdult _instance;

  final TRes Function(Mutation$AddAdult) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? addAdult = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Mutation$AddAdult(
        addAdult: addAdult == _undefined || addAdult == null
            ? _instance.addAdult
            : (addAdult as Fragment$UserFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$UserFields<TRes> get addAdult {
    final local$addAdult = _instance.addAdult;
    return CopyWith$Fragment$UserFields(
        local$addAdult, (e) => call(addAdult: e));
  }
}

class _CopyWithStubImpl$Mutation$AddAdult<TRes>
    implements CopyWith$Mutation$AddAdult<TRes> {
  _CopyWithStubImpl$Mutation$AddAdult(this._res);

  TRes _res;

  call({
    Fragment$UserFields? addAdult,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$UserFields<TRes> get addAdult =>
      CopyWith$Fragment$UserFields.stub(_res);
}

const documentNodeMutationAddAdult = DocumentNode(definitions: [
  OperationDefinitionNode(
    type: OperationType.mutation,
    name: NameNode(value: 'AddAdult'),
    variableDefinitions: [
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'name')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'email')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
      VariableDefinitionNode(
        variable: VariableNode(name: NameNode(value: 'password')),
        type: NamedTypeNode(
          name: NameNode(value: 'String'),
          isNonNull: true,
        ),
        defaultValue: DefaultValueNode(value: null),
        directives: [],
      ),
    ],
    directives: [],
    selectionSet: SelectionSetNode(selections: [
      FieldNode(
        name: NameNode(value: 'addAdult'),
        alias: null,
        arguments: [
          ArgumentNode(
            name: NameNode(value: 'name'),
            value: VariableNode(name: NameNode(value: 'name')),
          ),
          ArgumentNode(
            name: NameNode(value: 'email'),
            value: VariableNode(name: NameNode(value: 'email')),
          ),
          ArgumentNode(
            name: NameNode(value: 'password'),
            value: VariableNode(name: NameNode(value: 'password')),
          ),
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
