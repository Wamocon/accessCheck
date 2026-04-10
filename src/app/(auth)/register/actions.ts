"use server";

import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";

export type AuthState = { error: string } | { success: string } | null;

export async function register(
  prevState: AuthState,
  formData: FormData
): Promise<AuthState> {
  const supabase = await createClient();

  const fullName = (formData.get("fullName") as string)?.trim();
  const email = formData.get("email") as string;
  const password = formData.get("password") as string;
  const confirmPassword = formData.get("confirmPassword") as string;

  if (!fullName || !email || !password || !confirmPassword) {
    return { error: "Bitte alle Felder ausfüllen." };
  }

  if (password.length < 6) {
    return { error: "Das Passwort muss mindestens 6 Zeichen lang sein." };
  }

  if (password !== confirmPassword) {
    return { error: "Die Passwörter stimmen nicht überein." };
  }

  const { error } = await supabase.auth.signUp({
    email,
    password,
    options: { data: { full_name: fullName } },
  });

  if (error) {
    return { error: error.message };
  }

  // Update profile with full_name (trigger creates the row, we update it)
  const {
    data: { user },
  } = await supabase.auth.getUser();
  if (user) {
    await supabase
      .from("profiles")
      .update({ full_name: fullName })
      .eq("id", user.id);
  }

  redirect("/dashboard");
}
