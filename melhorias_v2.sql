-- ============================================================
-- MELHORIAS V2 — Adiantamentos, Subcategoria de Serviços
-- Execute no SQL Editor do Supabase
-- ============================================================

-- 1. Adiantamentos de funcionárias
create table if not exists adiantamentos (
  id             uuid primary key default gen_random_uuid(),
  funcionario_id uuid references funcionarios(id) on delete cascade not null,
  valor          numeric(10,2) not null check (valor > 0),
  data           date not null default current_date,
  periodo        text,          -- "2026-05" para referência de mês
  observacoes    text,
  created_at     timestamptz not null default now()
);

alter table adiantamentos enable row level security;
drop policy if exists "adiantamentos_all" on adiantamentos;
create policy "adiantamentos_all" on adiantamentos for all using (true) with check (true);

-- 2. Subcategoria em serviços
alter table servicos add column if not exists subcategoria text;

-- Verificar
select count(*) as adiantamentos from adiantamentos;
select nome, categoria, subcategoria from servicos order by categoria, subcategoria, nome limit 10;
