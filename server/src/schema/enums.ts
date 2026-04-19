import { builder } from "./builder.ts";
import type {
  ChoreKind,
  ChoreStatus,
  RecurrenceType,
  RedemptionStatus,
  UserRole,
} from "../db/generated.ts";

export const RoleEnum = builder.enumType("Role", {
  values: ["adult", "child"] as const satisfies readonly UserRole[],
});

export const RecurrenceEnum = builder.enumType("Recurrence", {
  values: ["one_off", "daily", "weekly"] as const satisfies readonly RecurrenceType[],
});

export const ChoreKindEnum = builder.enumType("ChoreKind", {
  values: ["scheduled", "on_demand"] as const satisfies readonly ChoreKind[],
});

export const ChoreStatusEnum = builder.enumType("ChoreStatus", {
  values: ["pending", "submitted", "approved", "rejected"] as const satisfies readonly ChoreStatus[],
});

export const RedemptionStatusEnum = builder.enumType("RedemptionStatus", {
  values: ["requested", "approved", "denied", "fulfilled"] as const satisfies readonly RedemptionStatus[],
});
