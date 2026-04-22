import { builder } from "./builder.ts";
import type {
  ChoreStatus,
  LootDropStatus,
  LootRarity,
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

export const ChoreStatusEnum = builder.enumType("ChoreStatus", {
  values: ["pending", "submitted", "approved", "rejected"] as const satisfies readonly ChoreStatus[],
});

export const RedemptionStatusEnum = builder.enumType("RedemptionStatus", {
  values: ["requested", "approved", "denied", "fulfilled"] as const satisfies readonly RedemptionStatus[],
});

export const LootRarityEnum = builder.enumType("LootRarity", {
  values: ["common", "rare", "epic", "legendary"] as const satisfies readonly LootRarity[],
});

export const LootDropStatusEnum = builder.enumType("LootDropStatus", {
  values: ["pending", "committed", "voided"] as const satisfies readonly LootDropStatus[],
});
