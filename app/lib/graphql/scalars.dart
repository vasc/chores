/// Top-level helpers exposed to graphql_codegen for serializing scalars.
String dateTimeToIso(DateTime value) => value.toIso8601String();

DateTime parseDateTime(String value) => DateTime.parse(value);
