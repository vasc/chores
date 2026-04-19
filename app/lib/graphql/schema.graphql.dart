enum Enum$ChoreKind {
  on_demand,
  scheduled,
  $unknown;

  factory Enum$ChoreKind.fromJson(String value) =>
      fromJson$Enum$ChoreKind(value);

  String toJson() => toJson$Enum$ChoreKind(this);
}

String toJson$Enum$ChoreKind(Enum$ChoreKind e) {
  switch (e) {
    case Enum$ChoreKind.on_demand:
      return r'on_demand';
    case Enum$ChoreKind.scheduled:
      return r'scheduled';
    case Enum$ChoreKind.$unknown:
      return r'$unknown';
  }
}

Enum$ChoreKind fromJson$Enum$ChoreKind(String value) {
  switch (value) {
    case r'on_demand':
      return Enum$ChoreKind.on_demand;
    case r'scheduled':
      return Enum$ChoreKind.scheduled;
    default:
      return Enum$ChoreKind.$unknown;
  }
}

enum Enum$ChoreStatus {
  approved,
  pending,
  rejected,
  submitted,
  $unknown;

  factory Enum$ChoreStatus.fromJson(String value) =>
      fromJson$Enum$ChoreStatus(value);

  String toJson() => toJson$Enum$ChoreStatus(this);
}

String toJson$Enum$ChoreStatus(Enum$ChoreStatus e) {
  switch (e) {
    case Enum$ChoreStatus.approved:
      return r'approved';
    case Enum$ChoreStatus.pending:
      return r'pending';
    case Enum$ChoreStatus.rejected:
      return r'rejected';
    case Enum$ChoreStatus.submitted:
      return r'submitted';
    case Enum$ChoreStatus.$unknown:
      return r'$unknown';
  }
}

Enum$ChoreStatus fromJson$Enum$ChoreStatus(String value) {
  switch (value) {
    case r'approved':
      return Enum$ChoreStatus.approved;
    case r'pending':
      return Enum$ChoreStatus.pending;
    case r'rejected':
      return Enum$ChoreStatus.rejected;
    case r'submitted':
      return Enum$ChoreStatus.submitted;
    default:
      return Enum$ChoreStatus.$unknown;
  }
}

enum Enum$Recurrence {
  daily,
  one_off,
  weekly,
  $unknown;

  factory Enum$Recurrence.fromJson(String value) =>
      fromJson$Enum$Recurrence(value);

  String toJson() => toJson$Enum$Recurrence(this);
}

String toJson$Enum$Recurrence(Enum$Recurrence e) {
  switch (e) {
    case Enum$Recurrence.daily:
      return r'daily';
    case Enum$Recurrence.one_off:
      return r'one_off';
    case Enum$Recurrence.weekly:
      return r'weekly';
    case Enum$Recurrence.$unknown:
      return r'$unknown';
  }
}

Enum$Recurrence fromJson$Enum$Recurrence(String value) {
  switch (value) {
    case r'daily':
      return Enum$Recurrence.daily;
    case r'one_off':
      return Enum$Recurrence.one_off;
    case r'weekly':
      return Enum$Recurrence.weekly;
    default:
      return Enum$Recurrence.$unknown;
  }
}

enum Enum$RedemptionStatus {
  approved,
  denied,
  fulfilled,
  requested,
  $unknown;

  factory Enum$RedemptionStatus.fromJson(String value) =>
      fromJson$Enum$RedemptionStatus(value);

  String toJson() => toJson$Enum$RedemptionStatus(this);
}

String toJson$Enum$RedemptionStatus(Enum$RedemptionStatus e) {
  switch (e) {
    case Enum$RedemptionStatus.approved:
      return r'approved';
    case Enum$RedemptionStatus.denied:
      return r'denied';
    case Enum$RedemptionStatus.fulfilled:
      return r'fulfilled';
    case Enum$RedemptionStatus.requested:
      return r'requested';
    case Enum$RedemptionStatus.$unknown:
      return r'$unknown';
  }
}

Enum$RedemptionStatus fromJson$Enum$RedemptionStatus(String value) {
  switch (value) {
    case r'approved':
      return Enum$RedemptionStatus.approved;
    case r'denied':
      return Enum$RedemptionStatus.denied;
    case r'fulfilled':
      return Enum$RedemptionStatus.fulfilled;
    case r'requested':
      return Enum$RedemptionStatus.requested;
    default:
      return Enum$RedemptionStatus.$unknown;
  }
}

enum Enum$Role {
  adult,
  child,
  $unknown;

  factory Enum$Role.fromJson(String value) => fromJson$Enum$Role(value);

  String toJson() => toJson$Enum$Role(this);
}

String toJson$Enum$Role(Enum$Role e) {
  switch (e) {
    case Enum$Role.adult:
      return r'adult';
    case Enum$Role.child:
      return r'child';
    case Enum$Role.$unknown:
      return r'$unknown';
  }
}

Enum$Role fromJson$Enum$Role(String value) {
  switch (value) {
    case r'adult':
      return Enum$Role.adult;
    case r'child':
      return Enum$Role.child;
    default:
      return Enum$Role.$unknown;
  }
}

enum Enum$__TypeKind {
  SCALAR,
  OBJECT,
  INTERFACE,
  UNION,
  ENUM,
  INPUT_OBJECT,
  LIST,
  NON_NULL,
  $unknown;

  factory Enum$__TypeKind.fromJson(String value) =>
      fromJson$Enum$__TypeKind(value);

  String toJson() => toJson$Enum$__TypeKind(this);
}

String toJson$Enum$__TypeKind(Enum$__TypeKind e) {
  switch (e) {
    case Enum$__TypeKind.SCALAR:
      return r'SCALAR';
    case Enum$__TypeKind.OBJECT:
      return r'OBJECT';
    case Enum$__TypeKind.INTERFACE:
      return r'INTERFACE';
    case Enum$__TypeKind.UNION:
      return r'UNION';
    case Enum$__TypeKind.ENUM:
      return r'ENUM';
    case Enum$__TypeKind.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__TypeKind.LIST:
      return r'LIST';
    case Enum$__TypeKind.NON_NULL:
      return r'NON_NULL';
    case Enum$__TypeKind.$unknown:
      return r'$unknown';
  }
}

Enum$__TypeKind fromJson$Enum$__TypeKind(String value) {
  switch (value) {
    case r'SCALAR':
      return Enum$__TypeKind.SCALAR;
    case r'OBJECT':
      return Enum$__TypeKind.OBJECT;
    case r'INTERFACE':
      return Enum$__TypeKind.INTERFACE;
    case r'UNION':
      return Enum$__TypeKind.UNION;
    case r'ENUM':
      return Enum$__TypeKind.ENUM;
    case r'INPUT_OBJECT':
      return Enum$__TypeKind.INPUT_OBJECT;
    case r'LIST':
      return Enum$__TypeKind.LIST;
    case r'NON_NULL':
      return Enum$__TypeKind.NON_NULL;
    default:
      return Enum$__TypeKind.$unknown;
  }
}

enum Enum$__DirectiveLocation {
  QUERY,
  MUTATION,
  SUBSCRIPTION,
  FIELD,
  FRAGMENT_DEFINITION,
  FRAGMENT_SPREAD,
  INLINE_FRAGMENT,
  VARIABLE_DEFINITION,
  SCHEMA,
  SCALAR,
  OBJECT,
  FIELD_DEFINITION,
  ARGUMENT_DEFINITION,
  INTERFACE,
  UNION,
  ENUM,
  ENUM_VALUE,
  INPUT_OBJECT,
  INPUT_FIELD_DEFINITION,
  $unknown;

  factory Enum$__DirectiveLocation.fromJson(String value) =>
      fromJson$Enum$__DirectiveLocation(value);

  String toJson() => toJson$Enum$__DirectiveLocation(this);
}

String toJson$Enum$__DirectiveLocation(Enum$__DirectiveLocation e) {
  switch (e) {
    case Enum$__DirectiveLocation.QUERY:
      return r'QUERY';
    case Enum$__DirectiveLocation.MUTATION:
      return r'MUTATION';
    case Enum$__DirectiveLocation.SUBSCRIPTION:
      return r'SUBSCRIPTION';
    case Enum$__DirectiveLocation.FIELD:
      return r'FIELD';
    case Enum$__DirectiveLocation.FRAGMENT_DEFINITION:
      return r'FRAGMENT_DEFINITION';
    case Enum$__DirectiveLocation.FRAGMENT_SPREAD:
      return r'FRAGMENT_SPREAD';
    case Enum$__DirectiveLocation.INLINE_FRAGMENT:
      return r'INLINE_FRAGMENT';
    case Enum$__DirectiveLocation.VARIABLE_DEFINITION:
      return r'VARIABLE_DEFINITION';
    case Enum$__DirectiveLocation.SCHEMA:
      return r'SCHEMA';
    case Enum$__DirectiveLocation.SCALAR:
      return r'SCALAR';
    case Enum$__DirectiveLocation.OBJECT:
      return r'OBJECT';
    case Enum$__DirectiveLocation.FIELD_DEFINITION:
      return r'FIELD_DEFINITION';
    case Enum$__DirectiveLocation.ARGUMENT_DEFINITION:
      return r'ARGUMENT_DEFINITION';
    case Enum$__DirectiveLocation.INTERFACE:
      return r'INTERFACE';
    case Enum$__DirectiveLocation.UNION:
      return r'UNION';
    case Enum$__DirectiveLocation.ENUM:
      return r'ENUM';
    case Enum$__DirectiveLocation.ENUM_VALUE:
      return r'ENUM_VALUE';
    case Enum$__DirectiveLocation.INPUT_OBJECT:
      return r'INPUT_OBJECT';
    case Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION:
      return r'INPUT_FIELD_DEFINITION';
    case Enum$__DirectiveLocation.$unknown:
      return r'$unknown';
  }
}

Enum$__DirectiveLocation fromJson$Enum$__DirectiveLocation(String value) {
  switch (value) {
    case r'QUERY':
      return Enum$__DirectiveLocation.QUERY;
    case r'MUTATION':
      return Enum$__DirectiveLocation.MUTATION;
    case r'SUBSCRIPTION':
      return Enum$__DirectiveLocation.SUBSCRIPTION;
    case r'FIELD':
      return Enum$__DirectiveLocation.FIELD;
    case r'FRAGMENT_DEFINITION':
      return Enum$__DirectiveLocation.FRAGMENT_DEFINITION;
    case r'FRAGMENT_SPREAD':
      return Enum$__DirectiveLocation.FRAGMENT_SPREAD;
    case r'INLINE_FRAGMENT':
      return Enum$__DirectiveLocation.INLINE_FRAGMENT;
    case r'VARIABLE_DEFINITION':
      return Enum$__DirectiveLocation.VARIABLE_DEFINITION;
    case r'SCHEMA':
      return Enum$__DirectiveLocation.SCHEMA;
    case r'SCALAR':
      return Enum$__DirectiveLocation.SCALAR;
    case r'OBJECT':
      return Enum$__DirectiveLocation.OBJECT;
    case r'FIELD_DEFINITION':
      return Enum$__DirectiveLocation.FIELD_DEFINITION;
    case r'ARGUMENT_DEFINITION':
      return Enum$__DirectiveLocation.ARGUMENT_DEFINITION;
    case r'INTERFACE':
      return Enum$__DirectiveLocation.INTERFACE;
    case r'UNION':
      return Enum$__DirectiveLocation.UNION;
    case r'ENUM':
      return Enum$__DirectiveLocation.ENUM;
    case r'ENUM_VALUE':
      return Enum$__DirectiveLocation.ENUM_VALUE;
    case r'INPUT_OBJECT':
      return Enum$__DirectiveLocation.INPUT_OBJECT;
    case r'INPUT_FIELD_DEFINITION':
      return Enum$__DirectiveLocation.INPUT_FIELD_DEFINITION;
    default:
      return Enum$__DirectiveLocation.$unknown;
  }
}

const possibleTypesMap = <String, Set<String>>{};
