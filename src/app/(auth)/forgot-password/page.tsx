"use client";

import { useActionState } from "react";
import Link from "next/link";
import { forgotPassword } from "./actions";

export default function ForgotPasswordPage() {
  const [state, action, pending] = useActionState(forgotPassword, null);

  return (
    <>
      <h2 className="text-xl font-semibold text-zinc-900 dark:text-zinc-50 mb-2">
        Passwort zurücksetzen
      </h2>
      <p className="text-sm text-zinc-500 dark:text-zinc-400 mb-6">
        Wir senden dir einen Link zum Zurücksetzen deines Passworts.
      </p>

      {state && "success" in state ? (
        <div className="rounded-lg bg-green-50 dark:bg-green-950/30 border border-green-200 dark:border-green-900 px-4 py-4 text-sm text-green-700 dark:text-green-400">
          {state.success}
        </div>
      ) : (
        <form action={action} className="space-y-4">
          {state && "error" in state && (
            <p className="rounded-lg bg-red-50 dark:bg-red-950/30 border border-red-200 dark:border-red-900 px-4 py-3 text-sm text-red-700 dark:text-red-400">
              {state.error}
            </p>
          )}

          <div className="space-y-1.5">
            <label
              htmlFor="email"
              className="block text-sm font-medium text-zinc-700 dark:text-zinc-300"
            >
              E-Mail
            </label>
            <input
              id="email"
              name="email"
              type="email"
              autoComplete="email"
              required
              className="w-full rounded-lg border border-zinc-300 dark:border-zinc-700 bg-white dark:bg-zinc-800 px-3 py-2 text-sm text-zinc-900 dark:text-zinc-100 placeholder-zinc-400 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:border-transparent transition"
              placeholder="name@firma.de"
            />
          </div>

          <button
            type="submit"
            disabled={pending}
            className="w-full rounded-lg bg-blue-600 px-4 py-2.5 text-sm font-semibold text-white hover:bg-blue-700 focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2 disabled:opacity-50 disabled:cursor-not-allowed transition"
          >
            {pending ? "Wird gesendet…" : "Link senden"}
          </button>
        </form>
      )}

      <p className="mt-6 text-center text-sm text-zinc-500 dark:text-zinc-400">
        <Link
          href="/login"
          className="font-medium text-blue-600 dark:text-blue-400 hover:underline"
        >
          ← Zurück zur Anmeldung
        </Link>
      </p>
    </>
  );
}
