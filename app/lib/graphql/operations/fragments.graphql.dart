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
    required this.xp,
    required this.level,
    required this.xpIntoLevel,
    required this.xpForNextLevel,
    required this.streakDays,
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
    final l$xp = json['xp'];
    final l$level = json['level'];
    final l$xpIntoLevel = json['xpIntoLevel'];
    final l$xpForNextLevel = json['xpForNextLevel'];
    final l$streakDays = json['streakDays'];
    final l$email = json['email'];
    final l$$__typename = json['__typename'];
    return Fragment$UserFields(
      id: (l$id as String),
      householdId: (l$householdId as String),
      name: (l$name as String),
      role: fromJson$Enum$Role((l$role as String)),
      avatarEmoji: (l$avatarEmoji as String),
      tokenBalance: (l$tokenBalance as int),
      xp: (l$xp as int),
      level: (l$level as int),
      xpIntoLevel: (l$xpIntoLevel as int),
      xpForNextLevel: (l$xpForNextLevel as int),
      streakDays: (l$streakDays as int),
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

  final int xp;

  final int level;

  final int xpIntoLevel;

  final int xpForNextLevel;

  final int streakDays;

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
    final l$xp = xp;
    _resultData['xp'] = l$xp;
    final l$level = level;
    _resultData['level'] = l$level;
    final l$xpIntoLevel = xpIntoLevel;
    _resultData['xpIntoLevel'] = l$xpIntoLevel;
    final l$xpForNextLevel = xpForNextLevel;
    _resultData['xpForNextLevel'] = l$xpForNextLevel;
    final l$streakDays = streakDays;
    _resultData['streakDays'] = l$streakDays;
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
    final l$xp = xp;
    final l$level = level;
    final l$xpIntoLevel = xpIntoLevel;
    final l$xpForNextLevel = xpForNextLevel;
    final l$streakDays = streakDays;
    final l$email = email;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$householdId,
      l$name,
      l$role,
      l$avatarEmoji,
      l$tokenBalance,
      l$xp,
      l$level,
      l$xpIntoLevel,
      l$xpForNextLevel,
      l$streakDays,
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
    final l$xp = xp;
    final lOther$xp = other.xp;
    if (l$xp != lOther$xp) {
      return false;
    }
    final l$level = level;
    final lOther$level = other.level;
    if (l$level != lOther$level) {
      return false;
    }
    final l$xpIntoLevel = xpIntoLevel;
    final lOther$xpIntoLevel = other.xpIntoLevel;
    if (l$xpIntoLevel != lOther$xpIntoLevel) {
      return false;
    }
    final l$xpForNextLevel = xpForNextLevel;
    final lOther$xpForNextLevel = other.xpForNextLevel;
    if (l$xpForNextLevel != lOther$xpForNextLevel) {
      return false;
    }
    final l$streakDays = streakDays;
    final lOther$streakDays = other.streakDays;
    if (l$streakDays != lOther$streakDays) {
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
    int? xp,
    int? level,
    int? xpIntoLevel,
    int? xpForNextLevel,
    int? streakDays,
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
    Object? xp = _undefined,
    Object? level = _undefined,
    Object? xpIntoLevel = _undefined,
    Object? xpForNextLevel = _undefined,
    Object? streakDays = _undefined,
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
        xp: xp == _undefined || xp == null ? _instance.xp : (xp as int),
        level: level == _undefined || level == null
            ? _instance.level
            : (level as int),
        xpIntoLevel: xpIntoLevel == _undefined || xpIntoLevel == null
            ? _instance.xpIntoLevel
            : (xpIntoLevel as int),
        xpForNextLevel: xpForNextLevel == _undefined || xpForNextLevel == null
            ? _instance.xpForNextLevel
            : (xpForNextLevel as int),
        streakDays: streakDays == _undefined || streakDays == null
            ? _instance.streakDays
            : (streakDays as int),
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
    int? xp,
    int? level,
    int? xpIntoLevel,
    int? xpForNextLevel,
    int? streakDays,
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
      name: NameNode(value: 'xp'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'level'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'xpIntoLevel'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'xpForNextLevel'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'streakDays'),
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
    required this.xpValue,
    required this.recurrence,
    required this.archived,
    required this.createdAt,
    this.$__typename = 'Chore',
  });

  factory Fragment$ChoreFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$title = json['title'];
    final l$description = json['description'];
    final l$tokenValue = json['tokenValue'];
    final l$xpValue = json['xpValue'];
    final l$recurrence = json['recurrence'];
    final l$archived = json['archived'];
    final l$createdAt = json['createdAt'];
    final l$$__typename = json['__typename'];
    return Fragment$ChoreFields(
      id: (l$id as String),
      title: (l$title as String),
      description: (l$description as String?),
      tokenValue: (l$tokenValue as int),
      xpValue: (l$xpValue as int),
      recurrence: fromJson$Enum$Recurrence((l$recurrence as String)),
      archived: (l$archived as bool),
      createdAt: parseDateTime(l$createdAt),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final String title;

  final String? description;

  final int tokenValue;

  final int xpValue;

  final Enum$Recurrence recurrence;

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
    final l$xpValue = xpValue;
    _resultData['xpValue'] = l$xpValue;
    final l$recurrence = recurrence;
    _resultData['recurrence'] = toJson$Enum$Recurrence(l$recurrence);
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
    final l$xpValue = xpValue;
    final l$recurrence = recurrence;
    final l$archived = archived;
    final l$createdAt = createdAt;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$title,
      l$description,
      l$tokenValue,
      l$xpValue,
      l$recurrence,
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
    final l$xpValue = xpValue;
    final lOther$xpValue = other.xpValue;
    if (l$xpValue != lOther$xpValue) {
      return false;
    }
    final l$recurrence = recurrence;
    final lOther$recurrence = other.recurrence;
    if (l$recurrence != lOther$recurrence) {
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
    int? xpValue,
    Enum$Recurrence? recurrence,
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
    Object? xpValue = _undefined,
    Object? recurrence = _undefined,
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
        xpValue: xpValue == _undefined || xpValue == null
            ? _instance.xpValue
            : (xpValue as int),
        recurrence: recurrence == _undefined || recurrence == null
            ? _instance.recurrence
            : (recurrence as Enum$Recurrence),
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
    int? xpValue,
    Enum$Recurrence? recurrence,
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
      name: NameNode(value: 'xpValue'),
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
    required this.combo,
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
    final l$combo = json['combo'];
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
      combo: (l$combo as int),
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

  final int combo;

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
    final l$combo = combo;
    _resultData['combo'] = l$combo;
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
    final l$combo = combo;
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
      l$combo,
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
    final l$combo = combo;
    final lOther$combo = other.combo;
    if (l$combo != lOther$combo) {
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
    int? combo,
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
    Object? combo = _undefined,
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
        combo: combo == _undefined || combo == null
            ? _instance.combo
            : (combo as int),
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
    int? combo,
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
      name: NameNode(value: 'combo'),
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

class Fragment$LootDropFields {
  Fragment$LootDropFields({
    required this.id,
    required this.rarity,
    required this.status,
    required this.isQuestBonus,
    required this.itemEmoji,
    required this.itemLabel,
    required this.itemDescription,
    required this.createdAt,
    this.committedAt,
    this.assignmentId,
    this.$__typename = 'LootDrop',
  });

  factory Fragment$LootDropFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$rarity = json['rarity'];
    final l$status = json['status'];
    final l$isQuestBonus = json['isQuestBonus'];
    final l$itemEmoji = json['itemEmoji'];
    final l$itemLabel = json['itemLabel'];
    final l$itemDescription = json['itemDescription'];
    final l$createdAt = json['createdAt'];
    final l$committedAt = json['committedAt'];
    final l$assignmentId = json['assignmentId'];
    final l$$__typename = json['__typename'];
    return Fragment$LootDropFields(
      id: (l$id as String),
      rarity: fromJson$Enum$LootRarity((l$rarity as String)),
      status: fromJson$Enum$LootDropStatus((l$status as String)),
      isQuestBonus: (l$isQuestBonus as bool),
      itemEmoji: (l$itemEmoji as String),
      itemLabel: (l$itemLabel as String),
      itemDescription: (l$itemDescription as String),
      createdAt: parseDateTime(l$createdAt),
      committedAt: l$committedAt == null ? null : parseDateTime(l$committedAt),
      assignmentId: (l$assignmentId as String?),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final Enum$LootRarity rarity;

  final Enum$LootDropStatus status;

  final bool isQuestBonus;

  final String itemEmoji;

  final String itemLabel;

  final String itemDescription;

  final DateTime createdAt;

  final DateTime? committedAt;

  final String? assignmentId;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$rarity = rarity;
    _resultData['rarity'] = toJson$Enum$LootRarity(l$rarity);
    final l$status = status;
    _resultData['status'] = toJson$Enum$LootDropStatus(l$status);
    final l$isQuestBonus = isQuestBonus;
    _resultData['isQuestBonus'] = l$isQuestBonus;
    final l$itemEmoji = itemEmoji;
    _resultData['itemEmoji'] = l$itemEmoji;
    final l$itemLabel = itemLabel;
    _resultData['itemLabel'] = l$itemLabel;
    final l$itemDescription = itemDescription;
    _resultData['itemDescription'] = l$itemDescription;
    final l$createdAt = createdAt;
    _resultData['createdAt'] = dateTimeToIso(l$createdAt);
    final l$committedAt = committedAt;
    _resultData['committedAt'] =
        l$committedAt == null ? null : dateTimeToIso(l$committedAt);
    final l$assignmentId = assignmentId;
    _resultData['assignmentId'] = l$assignmentId;
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$rarity = rarity;
    final l$status = status;
    final l$isQuestBonus = isQuestBonus;
    final l$itemEmoji = itemEmoji;
    final l$itemLabel = itemLabel;
    final l$itemDescription = itemDescription;
    final l$createdAt = createdAt;
    final l$committedAt = committedAt;
    final l$assignmentId = assignmentId;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$rarity,
      l$status,
      l$isQuestBonus,
      l$itemEmoji,
      l$itemLabel,
      l$itemDescription,
      l$createdAt,
      l$committedAt,
      l$assignmentId,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$LootDropFields) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$rarity = rarity;
    final lOther$rarity = other.rarity;
    if (l$rarity != lOther$rarity) {
      return false;
    }
    final l$status = status;
    final lOther$status = other.status;
    if (l$status != lOther$status) {
      return false;
    }
    final l$isQuestBonus = isQuestBonus;
    final lOther$isQuestBonus = other.isQuestBonus;
    if (l$isQuestBonus != lOther$isQuestBonus) {
      return false;
    }
    final l$itemEmoji = itemEmoji;
    final lOther$itemEmoji = other.itemEmoji;
    if (l$itemEmoji != lOther$itemEmoji) {
      return false;
    }
    final l$itemLabel = itemLabel;
    final lOther$itemLabel = other.itemLabel;
    if (l$itemLabel != lOther$itemLabel) {
      return false;
    }
    final l$itemDescription = itemDescription;
    final lOther$itemDescription = other.itemDescription;
    if (l$itemDescription != lOther$itemDescription) {
      return false;
    }
    final l$createdAt = createdAt;
    final lOther$createdAt = other.createdAt;
    if (l$createdAt != lOther$createdAt) {
      return false;
    }
    final l$committedAt = committedAt;
    final lOther$committedAt = other.committedAt;
    if (l$committedAt != lOther$committedAt) {
      return false;
    }
    final l$assignmentId = assignmentId;
    final lOther$assignmentId = other.assignmentId;
    if (l$assignmentId != lOther$assignmentId) {
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

extension UtilityExtension$Fragment$LootDropFields on Fragment$LootDropFields {
  CopyWith$Fragment$LootDropFields<Fragment$LootDropFields> get copyWith =>
      CopyWith$Fragment$LootDropFields(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$LootDropFields<TRes> {
  factory CopyWith$Fragment$LootDropFields(
    Fragment$LootDropFields instance,
    TRes Function(Fragment$LootDropFields) then,
  ) = _CopyWithImpl$Fragment$LootDropFields;

  factory CopyWith$Fragment$LootDropFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$LootDropFields;

  TRes call({
    String? id,
    Enum$LootRarity? rarity,
    Enum$LootDropStatus? status,
    bool? isQuestBonus,
    String? itemEmoji,
    String? itemLabel,
    String? itemDescription,
    DateTime? createdAt,
    DateTime? committedAt,
    String? assignmentId,
    String? $__typename,
  });
}

class _CopyWithImpl$Fragment$LootDropFields<TRes>
    implements CopyWith$Fragment$LootDropFields<TRes> {
  _CopyWithImpl$Fragment$LootDropFields(
    this._instance,
    this._then,
  );

  final Fragment$LootDropFields _instance;

  final TRes Function(Fragment$LootDropFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? rarity = _undefined,
    Object? status = _undefined,
    Object? isQuestBonus = _undefined,
    Object? itemEmoji = _undefined,
    Object? itemLabel = _undefined,
    Object? itemDescription = _undefined,
    Object? createdAt = _undefined,
    Object? committedAt = _undefined,
    Object? assignmentId = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$LootDropFields(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        rarity: rarity == _undefined || rarity == null
            ? _instance.rarity
            : (rarity as Enum$LootRarity),
        status: status == _undefined || status == null
            ? _instance.status
            : (status as Enum$LootDropStatus),
        isQuestBonus: isQuestBonus == _undefined || isQuestBonus == null
            ? _instance.isQuestBonus
            : (isQuestBonus as bool),
        itemEmoji: itemEmoji == _undefined || itemEmoji == null
            ? _instance.itemEmoji
            : (itemEmoji as String),
        itemLabel: itemLabel == _undefined || itemLabel == null
            ? _instance.itemLabel
            : (itemLabel as String),
        itemDescription:
            itemDescription == _undefined || itemDescription == null
                ? _instance.itemDescription
                : (itemDescription as String),
        createdAt: createdAt == _undefined || createdAt == null
            ? _instance.createdAt
            : (createdAt as DateTime),
        committedAt: committedAt == _undefined
            ? _instance.committedAt
            : (committedAt as DateTime?),
        assignmentId: assignmentId == _undefined
            ? _instance.assignmentId
            : (assignmentId as String?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));
}

class _CopyWithStubImpl$Fragment$LootDropFields<TRes>
    implements CopyWith$Fragment$LootDropFields<TRes> {
  _CopyWithStubImpl$Fragment$LootDropFields(this._res);

  TRes _res;

  call({
    String? id,
    Enum$LootRarity? rarity,
    Enum$LootDropStatus? status,
    bool? isQuestBonus,
    String? itemEmoji,
    String? itemLabel,
    String? itemDescription,
    DateTime? createdAt,
    DateTime? committedAt,
    String? assignmentId,
    String? $__typename,
  }) =>
      _res;
}

const fragmentDefinitionLootDropFields = FragmentDefinitionNode(
  name: NameNode(value: 'LootDropFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'LootDrop'),
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
      name: NameNode(value: 'rarity'),
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
      name: NameNode(value: 'isQuestBonus'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'itemEmoji'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'itemLabel'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'itemDescription'),
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
      name: NameNode(value: 'committedAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'assignmentId'),
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
const documentNodeFragmentLootDropFields = DocumentNode(definitions: [
  fragmentDefinitionLootDropFields,
]);

class Fragment$DailyQuestFields {
  Fragment$DailyQuestFields({
    required this.id,
    required this.questDate,
    required this.goal,
    required this.progress,
    this.rewardClaimedAt,
    this.rewardDrop,
    this.$__typename = 'DailyQuest',
  });

  factory Fragment$DailyQuestFields.fromJson(Map<String, dynamic> json) {
    final l$id = json['id'];
    final l$questDate = json['questDate'];
    final l$goal = json['goal'];
    final l$progress = json['progress'];
    final l$rewardClaimedAt = json['rewardClaimedAt'];
    final l$rewardDrop = json['rewardDrop'];
    final l$$__typename = json['__typename'];
    return Fragment$DailyQuestFields(
      id: (l$id as String),
      questDate: parseDateTime(l$questDate),
      goal: (l$goal as int),
      progress: (l$progress as int),
      rewardClaimedAt:
          l$rewardClaimedAt == null ? null : parseDateTime(l$rewardClaimedAt),
      rewardDrop: l$rewardDrop == null
          ? null
          : Fragment$LootDropFields.fromJson(
              (l$rewardDrop as Map<String, dynamic>)),
      $__typename: (l$$__typename as String),
    );
  }

  final String id;

  final DateTime questDate;

  final int goal;

  final int progress;

  final DateTime? rewardClaimedAt;

  final Fragment$LootDropFields? rewardDrop;

  final String $__typename;

  Map<String, dynamic> toJson() {
    final _resultData = <String, dynamic>{};
    final l$id = id;
    _resultData['id'] = l$id;
    final l$questDate = questDate;
    _resultData['questDate'] = dateTimeToIso(l$questDate);
    final l$goal = goal;
    _resultData['goal'] = l$goal;
    final l$progress = progress;
    _resultData['progress'] = l$progress;
    final l$rewardClaimedAt = rewardClaimedAt;
    _resultData['rewardClaimedAt'] =
        l$rewardClaimedAt == null ? null : dateTimeToIso(l$rewardClaimedAt);
    final l$rewardDrop = rewardDrop;
    _resultData['rewardDrop'] = l$rewardDrop?.toJson();
    final l$$__typename = $__typename;
    _resultData['__typename'] = l$$__typename;
    return _resultData;
  }

  @override
  int get hashCode {
    final l$id = id;
    final l$questDate = questDate;
    final l$goal = goal;
    final l$progress = progress;
    final l$rewardClaimedAt = rewardClaimedAt;
    final l$rewardDrop = rewardDrop;
    final l$$__typename = $__typename;
    return Object.hashAll([
      l$id,
      l$questDate,
      l$goal,
      l$progress,
      l$rewardClaimedAt,
      l$rewardDrop,
      l$$__typename,
    ]);
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    if (!(other is Fragment$DailyQuestFields) ||
        runtimeType != other.runtimeType) {
      return false;
    }
    final l$id = id;
    final lOther$id = other.id;
    if (l$id != lOther$id) {
      return false;
    }
    final l$questDate = questDate;
    final lOther$questDate = other.questDate;
    if (l$questDate != lOther$questDate) {
      return false;
    }
    final l$goal = goal;
    final lOther$goal = other.goal;
    if (l$goal != lOther$goal) {
      return false;
    }
    final l$progress = progress;
    final lOther$progress = other.progress;
    if (l$progress != lOther$progress) {
      return false;
    }
    final l$rewardClaimedAt = rewardClaimedAt;
    final lOther$rewardClaimedAt = other.rewardClaimedAt;
    if (l$rewardClaimedAt != lOther$rewardClaimedAt) {
      return false;
    }
    final l$rewardDrop = rewardDrop;
    final lOther$rewardDrop = other.rewardDrop;
    if (l$rewardDrop != lOther$rewardDrop) {
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

extension UtilityExtension$Fragment$DailyQuestFields
    on Fragment$DailyQuestFields {
  CopyWith$Fragment$DailyQuestFields<Fragment$DailyQuestFields> get copyWith =>
      CopyWith$Fragment$DailyQuestFields(
        this,
        (i) => i,
      );
}

abstract class CopyWith$Fragment$DailyQuestFields<TRes> {
  factory CopyWith$Fragment$DailyQuestFields(
    Fragment$DailyQuestFields instance,
    TRes Function(Fragment$DailyQuestFields) then,
  ) = _CopyWithImpl$Fragment$DailyQuestFields;

  factory CopyWith$Fragment$DailyQuestFields.stub(TRes res) =
      _CopyWithStubImpl$Fragment$DailyQuestFields;

  TRes call({
    String? id,
    DateTime? questDate,
    int? goal,
    int? progress,
    DateTime? rewardClaimedAt,
    Fragment$LootDropFields? rewardDrop,
    String? $__typename,
  });
  CopyWith$Fragment$LootDropFields<TRes> get rewardDrop;
}

class _CopyWithImpl$Fragment$DailyQuestFields<TRes>
    implements CopyWith$Fragment$DailyQuestFields<TRes> {
  _CopyWithImpl$Fragment$DailyQuestFields(
    this._instance,
    this._then,
  );

  final Fragment$DailyQuestFields _instance;

  final TRes Function(Fragment$DailyQuestFields) _then;

  static const _undefined = <dynamic, dynamic>{};

  TRes call({
    Object? id = _undefined,
    Object? questDate = _undefined,
    Object? goal = _undefined,
    Object? progress = _undefined,
    Object? rewardClaimedAt = _undefined,
    Object? rewardDrop = _undefined,
    Object? $__typename = _undefined,
  }) =>
      _then(Fragment$DailyQuestFields(
        id: id == _undefined || id == null ? _instance.id : (id as String),
        questDate: questDate == _undefined || questDate == null
            ? _instance.questDate
            : (questDate as DateTime),
        goal:
            goal == _undefined || goal == null ? _instance.goal : (goal as int),
        progress: progress == _undefined || progress == null
            ? _instance.progress
            : (progress as int),
        rewardClaimedAt: rewardClaimedAt == _undefined
            ? _instance.rewardClaimedAt
            : (rewardClaimedAt as DateTime?),
        rewardDrop: rewardDrop == _undefined
            ? _instance.rewardDrop
            : (rewardDrop as Fragment$LootDropFields?),
        $__typename: $__typename == _undefined || $__typename == null
            ? _instance.$__typename
            : ($__typename as String),
      ));

  CopyWith$Fragment$LootDropFields<TRes> get rewardDrop {
    final local$rewardDrop = _instance.rewardDrop;
    return local$rewardDrop == null
        ? CopyWith$Fragment$LootDropFields.stub(_then(_instance))
        : CopyWith$Fragment$LootDropFields(
            local$rewardDrop, (e) => call(rewardDrop: e));
  }
}

class _CopyWithStubImpl$Fragment$DailyQuestFields<TRes>
    implements CopyWith$Fragment$DailyQuestFields<TRes> {
  _CopyWithStubImpl$Fragment$DailyQuestFields(this._res);

  TRes _res;

  call({
    String? id,
    DateTime? questDate,
    int? goal,
    int? progress,
    DateTime? rewardClaimedAt,
    Fragment$LootDropFields? rewardDrop,
    String? $__typename,
  }) =>
      _res;

  CopyWith$Fragment$LootDropFields<TRes> get rewardDrop =>
      CopyWith$Fragment$LootDropFields.stub(_res);
}

const fragmentDefinitionDailyQuestFields = FragmentDefinitionNode(
  name: NameNode(value: 'DailyQuestFields'),
  typeCondition: TypeConditionNode(
      on: NamedTypeNode(
    name: NameNode(value: 'DailyQuest'),
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
      name: NameNode(value: 'questDate'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'goal'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'progress'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'rewardClaimedAt'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: null,
    ),
    FieldNode(
      name: NameNode(value: 'rewardDrop'),
      alias: null,
      arguments: [],
      directives: [],
      selectionSet: SelectionSetNode(selections: [
        FragmentSpreadNode(
          name: NameNode(value: 'LootDropFields'),
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
const documentNodeFragmentDailyQuestFields = DocumentNode(definitions: [
  fragmentDefinitionDailyQuestFields,
  fragmentDefinitionLootDropFields,
]);
