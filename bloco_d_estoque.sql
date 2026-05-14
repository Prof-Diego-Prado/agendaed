-- ============================================================
-- BLOCO D — Estoque: Movimentações e produtos na comanda
-- Execute no SQL Editor do Supabase
-- ============================================================

-- Histórico de movimentações de estoque (salão e revenda)
create table if not exists mov_estoque (
  id             uuid primary key default gen_random_uuid(),
  tipo_item      text not null check (tipo_item in ('salao','revenda')),
  item_id        uuid not null,
  tipo_mov       text not null check (tipo_mov in ('entrada','saida')),
  quantidade     numeric not null,
  motivo         text,
  agendamento_id uuid references agendamentos(id) on delete set null,
  created_at     timestamptz not null default now()
);

alter table mov_estoque enable row level security;
drop policy if exists "mov_estoque_all" on mov_estoque;
create policy "mov_estoque_all" on mov_estoque for all using (true) with check (true);

-- Produtos de revenda vendidos na comanda
create table if not exists comanda_produtos (
  id             uuid primary key default gen_random_uuid(),
  agendamento_id uuid references agendamentos(id) on delete cascade not null,
  produto_id     uuid references estoque_revenda(id) on delete restrict not null,
  quantidade     integer not null default 1,
  preco_unitario numeric(10,2) not null,
  created_at     timestamptz not null default now()
);

alter table comanda_produtos enable row level security;
drop policy if exists "comanda_produtos_all" on comanda_produtos;
create policy "comanda_produtos_all" on comanda_produtos for all using (true) with check (true);

-- Verificar
select count(*) as movimentos from mov_estoque;
select count(*) as comanda_produtos from comanda_produtos;
