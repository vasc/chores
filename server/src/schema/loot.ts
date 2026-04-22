import type { LootRarity } from "../db/generated.ts";

export type LootItem = {
  emoji: string;
  label: string;
  description: string;
};

/**
 * Flat catalog of possible loot items per rarity. Server picks one at random
 * when a drop is rolled.
 */
export const LOOT_CATALOG: Record<LootRarity, LootItem[]> = {
  common: [
    { emoji: "🌿", label: "Grass patch", description: "A fresh clump of savanna grass" },
    { emoji: "🌱", label: "Green sprout", description: "Tender and just starting out" },
    { emoji: "🍎", label: "Crisp apple", description: "A crunchy afternoon snack" },
    { emoji: "🪨", label: "Sunset pebble", description: "Smooth warm stone from the riverbed" },
  ],
  rare: [
    { emoji: "💧", label: "Water bowl", description: "Your buddy drinks happily" },
    { emoji: "🐝", label: "Buzzing bee", description: "A pollinating companion" },
    { emoji: "🪺", label: "Bird's nest", description: "Cozy woven twig house" },
    { emoji: "🍯", label: "Honey pot", description: "Sticky sweet boost" },
  ],
  epic: [
    { emoji: "🦓", label: "Zebra friend", description: "New companion unlocked!" },
    { emoji: "🌴", label: "Palm tree", description: "Shady midday hangout" },
    { emoji: "🦋", label: "Butterfly crown", description: "Flutter through the plains" },
    { emoji: "🔥", label: "Campfire", description: "Tell stories into the night" },
  ],
  legendary: [
    { emoji: "👑", label: "Golden mane", description: "Legendary cosmetic!" },
    { emoji: "🌟", label: "Star necklace", description: "Shines in the savanna night" },
    { emoji: "🏆", label: "Savanna trophy", description: "Champion of the herd" },
  ],
};

type RarityWeights = Record<LootRarity, number>;

const REGULAR_WEIGHTS: RarityWeights = {
  common: 50,
  rare: 30,
  epic: 15,
  legendary: 5,
};

const QUEST_BONUS_WEIGHTS: RarityWeights = {
  common: 20,
  rare: 40,
  epic: 30,
  legendary: 10,
};

export function rollRarity(opts: { boosted: boolean }): LootRarity {
  const weights = opts.boosted ? QUEST_BONUS_WEIGHTS : REGULAR_WEIGHTS;
  const total = Object.values(weights).reduce((a, b) => a + b, 0);
  let n = Math.random() * total;
  for (const [rarity, w] of Object.entries(weights) as [LootRarity, number][]) {
    if (n < w) return rarity;
    n -= w;
  }
  return "common";
}

export function pickItem(rarity: LootRarity): LootItem {
  const pool = LOOT_CATALOG[rarity];
  return pool[Math.floor(Math.random() * pool.length)];
}

/** Level curve: level = floor(xp / 100) + 1. xp-to-next = (level * 100) - xp. */
export function xpToLevel(xp: number): { level: number; xpIntoLevel: number; xpForNext: number } {
  const level = Math.max(1, Math.floor(xp / 100) + 1);
  const floor = (level - 1) * 100;
  return { level, xpIntoLevel: xp - floor, xpForNext: level * 100 };
}

/**
 * Returns the server's notion of "today" as a midnight-UTC Date.
 * Postgres `date` columns round trip Date values via this helper.
 * Household-local timezone support can layer on later; for now streaks
 * and daily quests are evaluated in UTC so the logic is deterministic.
 */
export function utcDateKey(d: Date = new Date()): Date {
  return new Date(Date.UTC(d.getUTCFullYear(), d.getUTCMonth(), d.getUTCDate()));
}

/** Day-ordinal distance between two UTC dates. */
export function utcDayDiff(a: Date, b: Date): number {
  const ak = Date.UTC(a.getUTCFullYear(), a.getUTCMonth(), a.getUTCDate());
  const bk = Date.UTC(b.getUTCFullYear(), b.getUTCMonth(), b.getUTCDate());
  return Math.round((ak - bk) / (24 * 60 * 60 * 1000));
}
