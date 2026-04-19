import { builder } from "./builder.ts";
import type { ChoreStatus, RedemptionStatus, Recurrence, Role } from "../db/types.ts";

export const RoleEnum = builder.enumType("Role", {
  values: ["adult", "child"] as const satisfies readonly Role[],
});

export const RecurrenceEnum = builder.enumType("Recurrence", {
  values: ["one_off", "daily", "weekly"] as const satisfies readonly Recurrence[],
});

export const ChoreStatusEnum = builder.enumType("ChoreStatus", {
  values: ["pending", "submitted", "approved", "rejected"] as const satisfies readonly ChoreStatus[],
});

export const RedemptionStatusEnum = builder.enumType("RedemptionStatus", {
  values: ["requested", "approved", "denied", "fulfilled"] as const satisfies readonly RedemptionStatus[],
});
