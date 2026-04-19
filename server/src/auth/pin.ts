import bcrypt from "bcryptjs";

const PIN_PATTERN = /^\d{4}$/;

export function validatePin(pin: string): void {
  if (!PIN_PATTERN.test(pin)) {
    throw new Error("PIN must be exactly 4 digits");
  }
}

export const hashPin = (pin: string) => {
  validatePin(pin);
  return bcrypt.hash(pin, 8);
};

export const verifyPin = (pin: string, hash: string) => bcrypt.compare(pin, hash);
