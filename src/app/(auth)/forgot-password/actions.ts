"use server";

import { createClient } from "@/lib/supabase/server";

export type ForgotPasswordState =
  | { error: string }
  | { success: string }
  | null;

export async function forgotPassword(
  prevState: ForgotPasswordState,
  formData: FormData
): Promise<ForgotPasswordState> {
  const supabase = await createClient();

  const email = formData.get("email") as string;

  if (!email) {
    return { error: "Bitte E-Mail-Adresse eingeben." };
  }

  const redirectTo = `${process.env.NEXT_PUBLIC_APP_URL}/auth/reset-password`;

  const { error } = await supabase.auth.resetPasswordForEmail(email, {
    redirectTo,
  });

  if (error) {
    return { error: error.message };
  }

  return {
    success:
      "Falls ein Konto mit dieser E-Mail existiert, haben wir einen Link zum Zurücksetzen des Passworts gesendet.",
  };
}
