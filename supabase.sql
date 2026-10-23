-- Maaş Pusulası: bulut kaydı tablosu
-- Supabase > SQL Editor > New query: bu dosyanın tamamını yapıştırıp "Run" deyin.

create table if not exists public.plans (
  user_id    uuid primary key references auth.users(id) on delete cascade,
  data       jsonb  not null,
  updated_at bigint not null default 0
);

-- Herkes yalnızca kendi kaydını görebilir ve değiştirebilir
alter table public.plans enable row level security;

drop policy if exists "kendi planini oku" on public.plans;
drop policy if exists "kendi planini ekle" on public.plans;
drop policy if exists "kendi planini guncelle" on public.plans;

create policy "kendi planini oku" on public.plans
  for select using (auth.uid() = user_id);

create policy "kendi planini ekle" on public.plans
  for insert with check (auth.uid() = user_id);

create policy "kendi planini guncelle" on public.plans
  for update using (auth.uid() = user_id) with check (auth.uid() = user_id);
