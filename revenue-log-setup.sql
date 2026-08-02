-- شغل الكود ده مرة واحدة بس في Supabase Dashboard > SQL Editor
-- هدفه: تسجيل كل عملية اشتراك جديد او تجديد عشان نقدر نحسب الايرادات بالشهر

create table if not exists revenue_log (
  id uuid primary key default gen_random_uuid(),
  member_id uuid references gym_members(id) on delete set null,
  member_name text not null,
  package_name text,
  amount numeric not null default 0,
  gender text,
  type text not null default 'new', -- 'new' او 'renewal'
  created_at timestamptz not null default now()
);

create index if not exists revenue_log_created_idx on revenue_log (created_at);

alter table revenue_log enable row level security;

create policy "allow anon read revenue_log"
  on revenue_log for select
  using (true);

create policy "allow anon insert revenue_log"
  on revenue_log for insert
  with check (true);
