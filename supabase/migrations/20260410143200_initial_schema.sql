-- ============================================================
-- AccessCheck – Initial Database Schema
-- Version: 1.0
-- Date: 2026-04-10
-- ============================================================

-- ----------------------------------------
-- TABLE: profiles
-- ----------------------------------------
CREATE TABLE IF NOT EXISTS public.profiles (
  id          uuid        PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  full_name   text,
  company_name text,
  logo_url    text,
  created_at  timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.profiles ENABLE ROW LEVEL SECURITY;

CREATE POLICY "profiles_select_own" ON public.profiles
  FOR SELECT USING (auth.uid() = id);

CREATE POLICY "profiles_insert_own" ON public.profiles
  FOR INSERT WITH CHECK (auth.uid() = id);

CREATE POLICY "profiles_update_own" ON public.profiles
  FOR UPDATE USING (auth.uid() = id);

-- ----------------------------------------
-- TABLE: audits
-- ----------------------------------------
CREATE TABLE IF NOT EXISTS public.audits (
  id               uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  user_id          uuid        NOT NULL REFERENCES auth.users(id) ON DELETE CASCADE,
  client_name      text        NOT NULL,
  website_url      text        NOT NULL,
  audit_date       date        NOT NULL DEFAULT CURRENT_DATE,
  auditor_name     text        NOT NULL,
  status           text        NOT NULL DEFAULT 'open'
                               CHECK (status IN ('open', 'in_progress', 'completed')),
  report_language  text        NOT NULL DEFAULT 'de'
                               CHECK (report_language IN ('de', 'en')),
  notes            text,
  created_at       timestamptz NOT NULL DEFAULT now(),
  updated_at       timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.audits ENABLE ROW LEVEL SECURITY;

CREATE POLICY "audits_select_own" ON public.audits
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "audits_insert_own" ON public.audits
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "audits_update_own" ON public.audits
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "audits_delete_own" ON public.audits
  FOR DELETE USING (auth.uid() = user_id);

-- ----------------------------------------
-- TABLE: audit_findings
-- ----------------------------------------
CREATE TABLE IF NOT EXISTS public.audit_findings (
  id               uuid  PRIMARY KEY DEFAULT gen_random_uuid(),
  audit_id         uuid  NOT NULL REFERENCES public.audits(id) ON DELETE CASCADE,
  wcag_criterion   text  NOT NULL,
  wcag_level       text  NOT NULL CHECK (wcag_level IN ('A', 'AA')),
  result           text  NOT NULL DEFAULT 'not_checked'
                         CHECK (result IN ('passed', 'failed', 'na', 'not_checked')),
  severity         text  CHECK (severity IN ('critical', 'high', 'medium', 'low')),
  comment          text,
  ai_suggestion    text,
  ai_used          boolean NOT NULL DEFAULT false
);

ALTER TABLE public.audit_findings ENABLE ROW LEVEL SECURITY;

CREATE POLICY "findings_select_own" ON public.audit_findings
  FOR SELECT USING (
    EXISTS (SELECT 1 FROM public.audits WHERE id = audit_id AND user_id = auth.uid())
  );

CREATE POLICY "findings_insert_own" ON public.audit_findings
  FOR INSERT WITH CHECK (
    EXISTS (SELECT 1 FROM public.audits WHERE id = audit_id AND user_id = auth.uid())
  );

CREATE POLICY "findings_update_own" ON public.audit_findings
  FOR UPDATE USING (
    EXISTS (SELECT 1 FROM public.audits WHERE id = audit_id AND user_id = auth.uid())
  );

CREATE POLICY "findings_delete_own" ON public.audit_findings
  FOR DELETE USING (
    EXISTS (SELECT 1 FROM public.audits WHERE id = audit_id AND user_id = auth.uid())
  );

-- ----------------------------------------
-- TABLE: finding_screenshots
-- ----------------------------------------
CREATE TABLE IF NOT EXISTS public.finding_screenshots (
  id            uuid        PRIMARY KEY DEFAULT gen_random_uuid(),
  finding_id    uuid        NOT NULL REFERENCES public.audit_findings(id) ON DELETE CASCADE,
  storage_path  text        NOT NULL,
  ai_analysis   text,
  created_at    timestamptz NOT NULL DEFAULT now()
);

ALTER TABLE public.finding_screenshots ENABLE ROW LEVEL SECURITY;

CREATE POLICY "screenshots_select_own" ON public.finding_screenshots
  FOR SELECT USING (
    EXISTS (
      SELECT 1 FROM public.audit_findings af
      JOIN public.audits a ON a.id = af.audit_id
      WHERE af.id = finding_id AND a.user_id = auth.uid()
    )
  );

CREATE POLICY "screenshots_insert_own" ON public.finding_screenshots
  FOR INSERT WITH CHECK (
    EXISTS (
      SELECT 1 FROM public.audit_findings af
      JOIN public.audits a ON a.id = af.audit_id
      WHERE af.id = finding_id AND a.user_id = auth.uid()
    )
  );

CREATE POLICY "screenshots_delete_own" ON public.finding_screenshots
  FOR DELETE USING (
    EXISTS (
      SELECT 1 FROM public.audit_findings af
      JOIN public.audits a ON a.id = af.audit_id
      WHERE af.id = finding_id AND a.user_id = auth.uid()
    )
  );

-- ----------------------------------------
-- TRIGGER: auto-update updated_at on audits
-- ----------------------------------------
CREATE OR REPLACE FUNCTION public.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = now();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER set_updated_at
  BEFORE UPDATE ON public.audits
  FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();

-- ----------------------------------------
-- TRIGGER: auto-create profile row on user signup
-- ----------------------------------------
CREATE OR REPLACE FUNCTION public.handle_new_user()
RETURNS TRIGGER AS $$
BEGIN
  INSERT INTO public.profiles (id)
  VALUES (NEW.id)
  ON CONFLICT (id) DO NOTHING;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql SECURITY DEFINER;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE FUNCTION public.handle_new_user();

-- ----------------------------------------
-- STORAGE BUCKETS
-- ----------------------------------------
INSERT INTO storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
VALUES
  ('logos',       'logos',       false, 5242880,  ARRAY['image/png','image/jpeg','image/webp','image/svg+xml']),
  ('screenshots', 'screenshots', false, 10485760, ARRAY['image/png','image/jpeg','image/webp'])
ON CONFLICT (id) DO NOTHING;

-- Storage RLS: logos bucket
CREATE POLICY "logos_select_own" ON storage.objects
  FOR SELECT USING (bucket_id = 'logos' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "logos_insert_own" ON storage.objects
  FOR INSERT WITH CHECK (bucket_id = 'logos' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "logos_update_own" ON storage.objects
  FOR UPDATE USING (bucket_id = 'logos' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "logos_delete_own" ON storage.objects
  FOR DELETE USING (bucket_id = 'logos' AND auth.uid()::text = (storage.foldername(name))[1]);

-- Storage RLS: screenshots bucket
CREATE POLICY "screenshots_storage_select_own" ON storage.objects
  FOR SELECT USING (bucket_id = 'screenshots' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "screenshots_storage_insert_own" ON storage.objects
  FOR INSERT WITH CHECK (bucket_id = 'screenshots' AND auth.uid()::text = (storage.foldername(name))[1]);

CREATE POLICY "screenshots_storage_delete_own" ON storage.objects
  FOR DELETE USING (bucket_id = 'screenshots' AND auth.uid()::text = (storage.foldername(name))[1]);
