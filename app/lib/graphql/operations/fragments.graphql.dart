import '../schema.graphql.dart';
import 'package:chores/graphql/scalars.dart';
import 'package:gql/ast.dart';

class Fragment$UserFields {
  Fragment$UserFields({
    required this.id,
    required this.householdId,
    required this.name,
    required this.role,
    required this.avatarEmoji,
    required this.tokenBalance,
    this.email,
    this.$__typename = 'User',
  });

  factory Fragment$UserFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$householdId = json['householdId'];
    final l$name = json['name'];
    final l$role = json['role'];
    final l$avatarEmoji = json['avatarEmoji'];
    final l$tokenBalance = json['tokenBalance'];
    final l$email = json['email'];
    final l$$__typename = json['__typename'];
    return Fragment$UserFields(
      id: (l$id as String),
      householdId: (l$householdId as String),
      name: (l$name as String),
      role: fromJson$Enum$Role((l$role as String)),
      avatarEmoji: (l$avatarEmoji as String),
      tokenBalance: (l$tokenBalance as int),
      email: (l$email as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String householdId;

  final String name;

  final Enum$Role role;

  final String avatarEmoji;

  final int tokenBalance;

  final String? email;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$householdId = householdId;
    _resultData['householdId'] = l$householdId;
    final l$name = name;
    _resultData['name'] = l$name;
    final l$role = role;
    _resultData['role'] = toJson$Enum$Role(l$role);
    final l$avatarEmoji = avatarEmoji;
    _resultData['avatarEmoji'] = l$avatarEmoji;
    final l$tokenBalance = tokenBalance;
    _resultData['tokenBalance'] = l$tokenBalance;
    final l$email = email;
    _resultData['email'] = l$email;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$householdId = householdId;
    final l$name = name;
    final l$role = role;
    final l$avatarEmoji = avatarEmoji;
    final l$tokenBalance = tokenBalance;
    final l$email = email;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$householdId,
      l$name,
      l$role,
      l$avatarEmoji,
      l$tokenBalance,
      l$email,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$UserFields) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$householdId = householdId;
    final lOther$householdId = other.householdId;
    if (l$householdId != lOther$householdId) {
      return false;
    }
    final l$name = name;
    final lOther$name = other.name;
    if (l$name != lOther$name) {
      return false;
    }
    final l$role = role;
    final lOther$role = other.role;
    if (l$role != lOther$role) {
      return false;
    }
    final l$avatarEmoji = avatarEmoji;
    final lOther$avatarEmoji = other.avatarEmoji;
    if (l$avatarEmoji != lOther$avatarEmoji) {
      return false;
    }
    final l$tokenBalance = tokenBalance;
    final lOther$tokenBalance = other.tokenBalance;
    if (l$tokenBalance != lOther$tokenBalance) {
      return false;
    }
    final l$email = email;
    final lOther$email = other.email;
    if (l$email != lOther$email) {
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

extension UtilityExtension$Fragment$UserFields on Fragment$UserFields {
  CopyWith$Fragment$UserFields<Fragment$UserFields> get copyWith =>
      CopyWith$Fragment$UserFields(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$UserFields<TRes> {
  factory CopyWith$Fragment$UserFields(
    Fragment$UserFields instance,
    TRes Function(Fragment$UserFields) then,
  ) = _CopyWithImpl$Fragment$UserFields;

  factory CopyWith$Fragment$UserFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$UserFields;

  TRes call({
    String? id,
    String? householdId,
    String? name,
    Enum$Role? role,
    String? avatarEmoji,
    int? tokenBalance,
    String? email,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$UserFields<TRes>
    implements CopyWith$Fragment$UserFields<TRes> {
  _CopyWithImpl$Fragment$UserFields(
    this._instance,
    this._then,
  );

  final Fragment$UserFields _instance;

  final TRes Function(Fragment$UserFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? householdId = _undefined,
    Object? name = _undefined,
    Object? role = _undefined,
    Object? avatarEmoji = _undefined,
    Object? tokenBalance = _undefined,
    Object? email = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$UserFields(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        householdId: householdId == _undefined || householdId == null
            ? _instance.householdId
            : (householdId as String),
        name: name == _undefined || name == null
            ? _instance.name
            : (name as String),
        role: role == _undefined || role == null
            ? _instance.role
            : (role as Enum$Role),
        avatarEmoji: avatarEmoji == _undefined || avatarEmoji == null
            ? _instance.avatarEmoji
            : (avatarEmoji as String),
        tokenBalance: tokenBalance == _undefined || tokenBalance == null
            ? _instance.tokenBalance
            : (tokenBalance as int),
        email: email == _undefined ? _instance.email : (email as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$UserFields<TRes>
    implements CopyWith$Fragment$UserFields<TRes> {
  _CopyWithStubImpl$Fragment$UserFields(this._res);

  TRes _res;

  call({
    String? id,
    String? householdId,
    String? name,
    Enum$Role? role,
    String? avatarEmoji,
    int? tokenBalance,
    String? email,
    String? $__typename,
  }) =>
      _res;
}

const fragmentDefinitionUserFields = FragmentDefinitionNode(
  name: NameNode(value: 'UserFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'User'),
    isNonNull: false,
  )),
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
      name: NameNode(value: 'householdId'),
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
      name: NameNode(value: 'role'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'avatarEmoji'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'tokenBalance'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'email'),
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
);
const documentNodeFragmentUserFields = DocumentNode(definitions: [
  fragmentDefinitionUserFields,
]);

class Fragment$ChoreFields {
  Fragment$ChoreFields({
    required this.id,
    required this.title,
    this.description,
    required this.tokenValue,
    required this.kind,
    required this.recurrence,
    required this.cooldownMinutes,
    required this.archived,
    required this.createdAt,
    this.$__typename = 'Chore',
  });

  factory Fragment$ChoreFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$description = json['description'];
    final l$tokenValue = json['tokenValue'];
    final l$kind = json['kind'];
    final l$recurrence = json['recurrence'];
    final l$cooldownMinutes = json['cooldownMinutes'];
    final l$archived = json['archived'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return Fragment$ChoreFields(
      id: (l$id as String),
      title: (l$title as String),
      description: (l$description as String?),
      tokenValue: (l$tokenValue as int),
      kind: fromJson$Enum$ChoreKind((l$kind as String)),
      recurrence: fromJson$Enum$Recurrence((l$recurrence as String)),
      cooldownMinutes: (l$cooldownMinutes as int),
      archived: (l$archived as bool),
      createdAt: parseDateTime(l$createdAt),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final String? description;

  final int tokenValue;

  final Enum$ChoreKind kind;

  final Enum$Recurrence recurrence;

  final int cooldownMinutes;

  final bool archived;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$tokenValue = tokenValue;
    _resultData['tokenValue'] = l$tokenValue;
    final l$kind = kind;
    _resultData['kind'] = toJson$Enum$ChoreKind(l$kind);
    final l$recurrence = recurrence;
    _resultData['recurrence'] = toJson$Enum$Recurrence(l$recurrence);
    final l$cooldownMinutes = cooldownMinutes;
    _resultData['cooldownMinutes'] = l$cooldownMinutes;
    final l$archived = archived;
    _resultData['archived'] = l$archived;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = dateTimeToIso(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$description = description;
    final l$tokenValue = tokenValue;
    final l$kind = kind;
    final l$recurrence = recurrence;
    final l$cooldownMinutes = cooldownMinutes;
    final l$archived = archived;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$description,
      l$tokenValue,
      l$kind,
      l$recurrence,
      l$cooldownMinutes,
      l$archived,
      l$createdAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$ChoreFields) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
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
    if (l$kind != lOther$kind) {
      return false;
    }
    final l$recurrence = recurrence;
    final lOther$recurrence = other.recurrence;
    if (l$recurrence != lOther$recurrence) {
      return false;
    }
    final l$cooldownMinutes = cooldownMinutes;
    final lOther$cooldownMinutes = other.cooldownMinutes;
    if (l$cooldownMinutes != lOther$cooldownMinutes) {
      return false;
    }
    final l$archived = archived;
    final lOther$archived = other.archived;
    if (l$archived != lOther$archived) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
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

extension UtilityExtension$Fragment$ChoreFields on Fragment$ChoreFields {
  CopyWith$Fragment$ChoreFields<Fragment$ChoreFields> get copyWith =>
      CopyWith$Fragment$ChoreFields(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$ChoreFields<TRes> {
  factory CopyWith$Fragment$ChoreFields(
    Fragment$ChoreFields instance,
    TRes Function(Fragment$ChoreFields) then,
  ) = _CopyWithImpl$Fragment$ChoreFields;

  factory CopyWith$Fragment$ChoreFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$ChoreFields;

  TRes call({
    String? id,
    String? title,
    String? description,
    int? tokenValue,
    Enum$ChoreKind? kind,
    Enum$Recurrence? recurrence,
    int? cooldownMinutes,
    bool? archived,
    DateTime? createdAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$ChoreFields<TRes>
    implements CopyWith$Fragment$ChoreFields<TRes> {
  _CopyWithImpl$Fragment$ChoreFields(
    this._instance,
    this._then,
  );

  final Fragment$ChoreFields _instance;

  final TRes Function(Fragment$ChoreFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? tokenValue = _undefined,
    Object? kind = _undefined,
    Object? recurrence = _undefined,
    Object? cooldownMinutes = _undefined,
    Object? archived = _undefined,
    Object? createdAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$ChoreFields(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        description: description == _undefined
            ? _instance.description
            : (description as String?),
        tokenValue: tokenValue == _undefined || tokenValue == null
            ? _instance.tokenValue
            : (tokenValue as int),
        kind: kind == _undefined || kind == null
            ? _instance.kind
            : (kind as Enum$ChoreKind),
        recurrence: recurrence == _undefined || recurrence == null
            ? _instance.recurrence
            : (recurrence as Enum$Recurrence),
        cooldownMinutes:
            cooldownMinutes == _undefined || cooldownMinutes == null
                ? _instance.cooldownMinutes
                : (cooldownMinutes as int),
        archived: archived == _undefined || archived == null
            ? _instance.archived
            : (archived as bool),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as DateTime),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$ChoreFields<TRes>
    implements CopyWith$Fragment$ChoreFields<TRes> {
  _CopyWithStubImpl$Fragment$ChoreFields(this._res);

  TRes _res;

  call({
    String? id,
    String? title,
    String? description,
    int? tokenValue,
    Enum$ChoreKind? kind,
    Enum$Recurrence? recurrence,
    int? cooldownMinutes,
    bool? archived,
    DateTime? createdAt,
    String? $__typename,
  }) =>
      _res;
}

const fragmentDefinitionChoreFields = FragmentDefinitionNode(
  name: NameNode(value: 'ChoreFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'Chore'),
    isNonNull: false,
  )),
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
      name: NameNode(value: 'title'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'description'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'tokenValue'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'kind'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'recurrence'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'cooldownMinutes'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'archived'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'createdAt'),
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
);
const documentNodeFragmentChoreFields = DocumentNode(definitions: [
  fragmentDefinitionChoreFields,
]);

class Fragment$AssignmentFields {
  Fragment$AssignmentFields({
    required this.id,
    required this.status,
    this.dueDate,
    this.submittedAt,
    this.approvedAt,
    this.rejectReason,
    required this.createdAt,
    required this.chore,
    required this.assignedTo,
    this.$__typename = 'ChoreAssignment',
  });

  factory Fragment$AssignmentFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$status = json['status'];
    final l$dueDate = json['dueDate'];
    final l$submittedAt = json['submittedAt'];
    final l$approvedAt = json['approvedAt'];
    final l$rejectReason = json['rejectReason'];
    final l$createdAt = json['createdAt'];
    final l$chore = json['chore'];
    final l$assignedTo = json['assignedTo'];
    final l$$__typename = json['__typename'];
    return Fragment$AssignmentFields(
      id: (l$id as String),
      status: fromJson$Enum$ChoreStatus((l$status as String)),
      dueDate: l$dueDate == null ? null : parseDateTime(l$dueDate),
      submittedAt: l$submittedAt == null ? null : parseDateTime(l$submittedAt),
      approvedAt: l$approvedAt == null ? null : parseDateTime(l$approvedAt),
      rejectReason: (l$rejectReason as String?),
      createdAt: parseDateTime(l$createdAt),
      chore: Fragment$ChoreFields.fromJson((l$chore as Map<String, dynamic>)),
      assignedTo:
          Fragment$UserFields.fromJson((l$assignedTo as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Enum$ChoreStatus status;

  final DateTime? dueDate;

  final DateTime? submittedAt;

  final DateTime? approvedAt;

  final String? rejectReason;

  final DateTime createdAt;

  final Fragment$ChoreFields chore;

  final Fragment$UserFields assignedTo;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$status = status;
    _resultData['status'] = toJson$Enum$ChoreStatus(l$status);
    final l$dueDate = dueDate;
    _resultData['dueDate'] =
        l$dueDate == null ? null : dateTimeToIso(l$dueDate);
    final l$submittedAt = submittedAt;
    _resultData['submittedAt'] =
        l$submittedAt == null ? null : dateTimeToIso(l$submittedAt);
    final l$approvedAt = approvedAt;
    _resultData['approvedAt'] =
        l$approvedAt == null ? null : dateTimeToIso(l$approvedAt);
    final l$rejectReason = rejectReason;
    _resultData['rejectReason'] = l$rejectReason;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = dateTimeToIso(l$createdAt);
    final l$chore = chore;
    _resultData['chore'] = l$chore.toJson();
    final l$assignedTo = assignedTo;
    _resultData['assignedTo'] = l$assignedTo.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$status = status;
    final l$dueDate = dueDate;
    final l$submittedAt = submittedAt;
    final l$approvedAt = approvedAt;
    final l$rejectReason = rejectReason;
    final l$createdAt = createdAt;
    final l$chore = chore;
    final l$assignedTo = assignedTo;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$status,
      l$dueDate,
      l$submittedAt,
      l$approvedAt,
      l$rejectReason,
      l$createdAt,
      l$chore,
      l$assignedTo,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$AssignmentFields) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$dueDate = dueDate;
    final lOther$dueDate = other.dueDate;
    if (l$dueDate != lOther$dueDate) {
      return false;
    }
    final l$submittedAt = submittedAt;
    final lOther$submittedAt = other.submittedAt;
    if (l$submittedAt != lOther$submittedAt) {
      return false;
    }
    final l$approvedAt = approvedAt;
    final lOther$approvedAt = other.approvedAt;
    if (l$approvedAt != lOther$approvedAt) {
      return false;
    }
    final l$rejectReason = rejectReason;
    final lOther$rejectReason = other.rejectReason;
    if (l$rejectReason != lOther$rejectReason) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$chore = chore;
    final lOther$chore = other.chore;
    if (l$chore != lOther$chore) {
      return false;
    }
    final l$assignedTo = assignedTo;
    final lOther$assignedTo = other.assignedTo;
    if (l$assignedTo != lOther$assignedTo) {
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

extension UtilityExtension$Fragment$AssignmentFields
    on Fragment$AssignmentFields {
  CopyWith$Fragment$AssignmentFields<Fragment$AssignmentFields> get copyWith =>
      CopyWith$Fragment$AssignmentFields(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$AssignmentFields<TRes> {
  factory CopyWith$Fragment$AssignmentFields(
    Fragment$AssignmentFields instance,
    TRes Function(Fragment$AssignmentFields) then,
  ) = _CopyWithImpl$Fragment$AssignmentFields;

  factory CopyWith$Fragment$AssignmentFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$AssignmentFields;

  TRes call({
    String? id,
    Enum$ChoreStatus? status,
    DateTime? dueDate,
    DateTime? submittedAt,
    DateTime? approvedAt,
    String? rejectReason,
    DateTime? createdAt,
    Fragment$ChoreFields? chore,
    Fragment$UserFields? assignedTo,
    String? $__typename,
  });
  CopyWith$Fragment$ChoreFields<TRes> get chore;
  CopyWith$Fragment$UserFields<TRes> get assignedTo;
}

class _CopyWithImpl$Fragment$AssignmentFields<TRes>
    implements CopyWith$Fragment$AssignmentFields<TRes> {
  _CopyWithImpl$Fragment$AssignmentFields(
    this._instance,
    this._then,
  );

  final Fragment$AssignmentFields _instance;

  final TRes Function(Fragment$AssignmentFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? status = _undefined,
    Object? dueDate = _undefined,
    Object? submittedAt = _undefined,
    Object? approvedAt = _undefined,
    Object? rejectReason = _undefined,
    Object? createdAt = _undefined,
    Object? chore = _undefined,
    Object? assignedTo = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$AssignmentFields(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as Enum$ChoreStatus),
        dueDate:
            dueDate == _undefined ? _instance.dueDate : (dueDate as DateTime?),
        submittedAt: submittedAt == _undefined
            ? _instance.submittedAt
            : (submittedAt as DateTime?),
        approvedAt: approvedAt == _undefined
            ? _instance.approvedAt
            : (approvedAt as DateTime?),
        rejectReason: rejectReason == _undefined
            ? _instance.rejectReason
            : (rejectReason as String?),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as DateTime),
        chore: chore == _undefined || chore == null
            ? _instance.chore
            : (chore as Fragment$ChoreFields),
        assignedTo: assignedTo == _undefined || assignedTo == null
            ? _instance.assignedTo
            : (assignedTo as Fragment$UserFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$ChoreFields<TRes> get chore {
    final local$chore = _instance.chore;
    return CopyWith$Fragment$ChoreFields(local$chore, (e) => call(chore: e));
  }

  CopyWith$Fragment$UserFields<TRes> get assignedTo {
    final local$assignedTo = _instance.assignedTo;
    return CopyWith$Fragment$UserFields(
        local$assignedTo, (e) => call(assignedTo: e));
  }
}

class _CopyWithStubImpl$Fragment$AssignmentFields<TRes>
    implements CopyWith$Fragment$AssignmentFields<TRes> {
  _CopyWithStubImpl$Fragment$AssignmentFields(this._res);

  TRes _res;

  call({
    String? id,
    Enum$ChoreStatus? status,
    DateTime? dueDate,
    DateTime? submittedAt,
    DateTime? approvedAt,
    String? rejectReason,
    DateTime? createdAt,
    Fragment$ChoreFields? chore,
    Fragment$UserFields? assignedTo,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$ChoreFields<TRes> get chore =>
      CopyWith$Fragment$ChoreFields.stub(_res);

  CopyWith$Fragment$UserFields<TRes> get assignedTo =>
      CopyWith$Fragment$UserFields.stub(_res);
}

const fragmentDefinitionAssignmentFields = FragmentDefinitionNode(
  name: NameNode(value: 'AssignmentFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'ChoreAssignment'),
    isNonNull: false,
  )),
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
      name: NameNode(value: 'status'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'dueDate'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'submittedAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'approvedAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'rejectReason'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'createdAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'chore'),
      alias: null,
      arguments: [],
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
      name: NameNode(value: 'assignedTo'),
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
);
const documentNodeFragmentAssignmentFields = DocumentNode(definitions: [
  fragmentDefinitionAssignmentFields,
  fragmentDefinitionChoreFields,
  fragmentDefinitionUserFields,
]);

class Fragment$RewardFields {
  Fragment$RewardFields({
    required this.id,
    required this.title,
    this.description,
    required this.tokenCost,
    required this.archived,
    required this.createdAt,
    this.$__typename = 'Reward',
  });

  factory Fragment$RewardFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$description = json['description'];
    final l$tokenCost = json['tokenCost'];
    final l$archived = json['archived'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return Fragment$RewardFields(
      id: (l$id as String),
      title: (l$title as String),
      description: (l$description as String?),
      tokenCost: (l$tokenCost as int),
      archived: (l$archived as bool),
      createdAt: parseDateTime(l$createdAt),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final String? description;

  final int tokenCost;

  final bool archived;

  final DateTime createdAt;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$title = title;
    _resultData['title'] = l$title;
    final l$description = description;
    _resultData['description'] = l$description;
    final l$tokenCost = tokenCost;
    _resultData['tokenCost'] = l$tokenCost;
    final l$archived = archived;
    _resultData['archived'] = l$archived;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = dateTimeToIso(l$createdAt);
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$title = title;
    final l$description = description;
    final l$tokenCost = tokenCost;
    final l$archived = archived;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$description,
      l$tokenCost,
      l$archived,
      l$createdAt,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$RewardFields) || runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$title = title;
    final lOther$title = other.title;
    if (l$title != lOther$title) {
      return false;
    }
    final l$description = description;
    final lOther$description = other.description;
    if (l$description != lOther$description) {
      return false;
    }
    final l$tokenCost = tokenCost;
    final lOther$tokenCost = other.tokenCost;
    if (l$tokenCost != lOther$tokenCost) {
      return false;
    }
    final l$archived = archived;
    final lOther$archived = other.archived;
    if (l$archived != lOther$archived) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
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

extension UtilityExtension$Fragment$RewardFields on Fragment$RewardFields {
  CopyWith$Fragment$RewardFields<Fragment$RewardFields> get copyWith =>
      CopyWith$Fragment$RewardFields(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$RewardFields<TRes> {
  factory CopyWith$Fragment$RewardFields(
    Fragment$RewardFields instance,
    TRes Function(Fragment$RewardFields) then,
  ) = _CopyWithImpl$Fragment$RewardFields;

  factory CopyWith$Fragment$RewardFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$RewardFields;

  TRes call({
    String? id,
    String? title,
    String? description,
    int? tokenCost,
    bool? archived,
    DateTime? createdAt,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$RewardFields<TRes>
    implements CopyWith$Fragment$RewardFields<TRes> {
  _CopyWithImpl$Fragment$RewardFields(
    this._instance,
    this._then,
  );

  final Fragment$RewardFields _instance;

  final TRes Function(Fragment$RewardFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? title = _undefined,
    Object? description = _undefined,
    Object? tokenCost = _undefined,
    Object? archived = _undefined,
    Object? createdAt = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$RewardFields(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        title: title == _undefined || title == null
            ? _instance.title
            : (title as String),
        description: description == _undefined
            ? _instance.description
            : (description as String?),
        tokenCost: tokenCost == _undefined || tokenCost == null
            ? _instance.tokenCost
            : (tokenCost as int),
        archived: archived == _undefined || archived == null
            ? _instance.archived
            : (archived as bool),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as DateTime),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$RewardFields<TRes>
    implements CopyWith$Fragment$RewardFields<TRes> {
  _CopyWithStubImpl$Fragment$RewardFields(this._res);

  TRes _res;

  call({
    String? id,
    String? title,
    String? description,
    int? tokenCost,
    bool? archived,
    DateTime? createdAt,
    String? $__typename,
  }) =>
      _res;
}

const fragmentDefinitionRewardFields = FragmentDefinitionNode(
  name: NameNode(value: 'RewardFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'Reward'),
    isNonNull: false,
  )),
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
      name: NameNode(value: 'title'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'description'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'tokenCost'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'archived'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'createdAt'),
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
);
const documentNodeFragmentRewardFields = DocumentNode(definitions: [
  fragmentDefinitionRewardFields,
]);

class Fragment$RedemptionFields {
  Fragment$RedemptionFields({
    required this.id,
    required this.status,
    required this.tokensSpent,
    required this.requestedAt,
    this.decidedAt,
    this.decisionReason,
    required this.reward,
    required this.user,
    this.$__typename = 'Redemption',
  });

  factory Fragment$RedemptionFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$status = json['status'];
    final l$tokensSpent = json['tokensSpent'];
    final l$requestedAt = json['requestedAt'];
    final l$decidedAt = json['decidedAt'];
    final l$decisionReason = json['decisionReason'];
    final l$reward = json['reward'];
    final l$user = json['user'];
    final l$$__typename = json['__typename'];
    return Fragment$RedemptionFields(
      id: (l$id as String),
      status: fromJson$Enum$RedemptionStatus((l$status as String)),
      tokensSpent: (l$tokensSpent as int),
      requestedAt: parseDateTime(l$requestedAt),
      decidedAt: l$decidedAt == null ? null : parseDateTime(l$decidedAt),
      decisionReason: (l$decisionReason as String?),
      reward:
          Fragment$RewardFields.fromJson((l$reward as Map<String, dynamic>)),
      user: Fragment$UserFields.fromJson((l$user as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Enum$RedemptionStatus status;

  final int tokensSpent;

  final DateTime requestedAt;

  final DateTime? decidedAt;

  final String? decisionReason;

  final Fragment$RewardFields reward;

  final Fragment$UserFields user;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$status = status;
    _resultData['status'] = toJson$Enum$RedemptionStatus(l$status);
    final l$tokensSpent = tokensSpent;
    _resultData['tokensSpent'] = l$tokensSpent;
    final l$requestedAt = requestedAt;
    _resultData['requestedAt'] = dateTimeToIso(l$requestedAt);
    final l$decidedAt = decidedAt;
    _resultData['decidedAt'] =
        l$decidedAt == null ? null : dateTimeToIso(l$decidedAt);
    final l$decisionReason = decisionReason;
    _resultData['decisionReason'] = l$decisionReason;
    final l$reward = reward;
    _resultData['reward'] = l$reward.toJson();
    final l$user = user;
    _resultData['user'] = l$user.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$status = status;
    final l$tokensSpent = tokensSpent;
    final l$requestedAt = requestedAt;
    final l$decidedAt = decidedAt;
    final l$decisionReason = decisionReason;
    final l$reward = reward;
    final l$user = user;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$status,
      l$tokensSpent,
      l$requestedAt,
      l$decidedAt,
      l$decisionReason,
      l$reward,
      l$user,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$RedemptionFields) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$tokensSpent = tokensSpent;
    final lOther$tokensSpent = other.tokensSpent;
    if (l$tokensSpent != lOther$tokensSpent) {
      return false;
    }
    final l$requestedAt = requestedAt;
    final lOther$requestedAt = other.requestedAt;
    if (l$requestedAt != lOther$requestedAt) {
      return false;
    }
    final l$decidedAt = decidedAt;
    final lOther$decidedAt = other.decidedAt;
    if (l$decidedAt != lOther$decidedAt) {
      return false;
    }
    final l$decisionReason = decisionReason;
    final lOther$decisionReason = other.decisionReason;
    if (l$decisionReason != lOther$decisionReason) {
      return false;
    }
    final l$reward = reward;
    final lOther$reward = other.reward;
    if (l$reward != lOther$reward) {
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

extension UtilityExtension$Fragment$RedemptionFields
    on Fragment$RedemptionFields {
  CopyWith$Fragment$RedemptionFields<Fragment$RedemptionFields> get copyWith =>
      CopyWith$Fragment$RedemptionFields(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$RedemptionFields<TRes> {
  factory CopyWith$Fragment$RedemptionFields(
    Fragment$RedemptionFields instance,
    TRes Function(Fragment$RedemptionFields) then,
  ) = _CopyWithImpl$Fragment$RedemptionFields;

  factory CopyWith$Fragment$RedemptionFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$RedemptionFields;

  TRes call({
    String? id,
    Enum$RedemptionStatus? status,
    int? tokensSpent,
    DateTime? requestedAt,
    DateTime? decidedAt,
    String? decisionReason,
    Fragment$RewardFields? reward,
    Fragment$UserFields? user,
    String? $__typename,
  });
  CopyWith$Fragment$RewardFields<TRes> get reward;
  CopyWith$Fragment$UserFields<TRes> get user;
}

class _CopyWithImpl$Fragment$RedemptionFields<TRes>
    implements CopyWith$Fragment$RedemptionFields<TRes> {
  _CopyWithImpl$Fragment$RedemptionFields(
    this._instance,
    this._then,
  );

  final Fragment$RedemptionFields _instance;

  final TRes Function(Fragment$RedemptionFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? status = _undefined,
    Object? tokensSpent = _undefined,
    Object? requestedAt = _undefined,
    Object? decidedAt = _undefined,
    Object? decisionReason = _undefined,
    Object? reward = _undefined,
    Object? user = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$RedemptionFields(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as Enum$RedemptionStatus),
        tokensSpent: tokensSpent == _undefined || tokensSpent == null
            ? _instance.tokensSpent
            : (tokensSpent as int),
        requestedAt: requestedAt == _undefined || requestedAt == null
            ? _instance.requestedAt
            : (requestedAt as DateTime),
        decidedAt: decidedAt == _undefined
            ? _instance.decidedAt
            : (decidedAt as DateTime?),
        decisionReason: decisionReason == _undefined
            ? _instance.decisionReason
            : (decisionReason as String?),
        reward: reward == _undefined || reward == null
            ? _instance.reward
            : (reward as Fragment$RewardFields),
        user: user == _undefined || user == null
            ? _instance.user
            : (user as Fragment$UserFields),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$RewardFields<TRes> get reward {
    final local$reward = _instance.reward;
    return CopyWith$Fragment$RewardFields(local$reward, (e) => call(reward: e));
  }

  CopyWith$Fragment$UserFields<TRes> get user {
    final local$user = _instance.user;
    return CopyWith$Fragment$UserFields(local$user, (e) => call(user: e));
  }
}

class _CopyWithStubImpl$Fragment$RedemptionFields<TRes>
    implements CopyWith$Fragment$RedemptionFields<TRes> {
  _CopyWithStubImpl$Fragment$RedemptionFields(this._res);

  TRes _res;

  call({
    String? id,
    Enum$RedemptionStatus? status,
    int? tokensSpent,
    DateTime? requestedAt,
    DateTime? decidedAt,
    String? decisionReason,
    Fragment$RewardFields? reward,
    Fragment$UserFields? user,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$RewardFields<TRes> get reward =>
      CopyWith$Fragment$RewardFields.stub(_res);

  CopyWith$Fragment$UserFields<TRes> get user =>
      CopyWith$Fragment$UserFields.stub(_res);
}

const fragmentDefinitionRedemptionFields = FragmentDefinitionNode(
  name: NameNode(value: 'RedemptionFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'Redemption'),
    isNonNull: false,
  )),
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
      name: NameNode(value: 'status'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'tokensSpent'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'requestedAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'decidedAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'decisionReason'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'reward'),
      alias: null,
      arguments: [],
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
);
const documentNodeFragmentRedemptionFields = DocumentNode(definitions: [
  fragmentDefinitionRedemptionFields,
  fragmentDefinitionRewardFields,
  fragmentDefinitionUserFields,
]);
