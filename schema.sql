-- ============================================================
-- Studio Érika Daiany — Schema Supabase (PostgreSQL)
-- Execute no SQL Editor do Supabase
-- ============================================================

-- Extensão para uuid
create extension if not exists "pgcrypto";

-- ============================================================
-- TABELAS
-- ============================================================

create table if not exists clientes (
  id            uuid primary key default gen_random_uuid(),
  nome          text not null,
  telefone      text,
  email         text,
  aniversario   date,
  observacoes   text,
  created_at    timestamptz not null default now()
);

create table if not exists funcionarios (
  id          uuid primary key default gen_random_uuid(),
  nome        text not null,
  cargo       text,
  telefone    text,
  foto_url    text,
  cor         text default '#ec4899',
  ativo       boolean not null default true,
  created_at  timestamptz not null default now()
);

create table if not exists servicos (
  id            uuid primary key default gen_random_uuid(),
  nome          text not null,
  duracao_min   integer not null default 60,
  preco         numeric(10,2) not null default 0,
  categoria     text,
  ativo         boolean not null default true
);

create table if not exists agendamentos (
  id              uuid primary key default gen_random_uuid(),
  cliente_id      uuid references clientes(id) on delete set null,
  funcionario_id  uuid references funcionarios(id) on delete set null,
  servico_id      uuid references servicos(id) on delete set null,
  data_hora       timestamptz not null,
  status          text not null default 'agendado'
                    check (status in ('agendado','concluido','cancelado','faltou')),
  observacoes     text,
  valor_cobrado   numeric(10,2),
  created_at      timestamptz not null default now()
);

create table if not exists estoque_salao (
  id                  uuid primary key default gen_random_uuid(),
  produto             text not null,
  categoria           text,
  quantidade          numeric(10,3) not null default 0,
  unidade             text not null default 'un',
  quantidade_minima   numeric(10,3) not null default 0,
  fornecedor          text,
  updated_at          timestamptz not null default now()
);

create table if not exists estoque_revenda (
  id              uuid primary key default gen_random_uuid(),
  produto         text not null,
  categoria       text,
  quantidade      integer not null default 0,
  preco_custo     numeric(10,2) not null default 0,
  preco_venda     numeric(10,2) not null default 0,
  codigo_barras   text,
  updated_at      timestamptz not null default now()
);

-- ============================================================
-- ROW LEVEL SECURITY — permissivo (projeto interno)
-- ============================================================

alter table clientes        enable row level security;
alter table funcionarios    enable row level security;
alter table servicos        enable row level security;
alter table agendamentos    enable row level security;
alter table estoque_salao   enable row level security;
alter table estoque_revenda enable row level security;

-- clientes
create policy "clientes_select" on clientes for select using (true);
create policy "clientes_insert" on clientes for insert with check (true);
create policy "clientes_update" on clientes for update using (true) with check (true);
create policy "clientes_delete" on clientes for delete using (true);

-- funcionarios
create policy "funcionarios_select" on funcionarios for select using (true);
create policy "funcionarios_insert" on funcionarios for insert with check (true);
create policy "funcionarios_update" on funcionarios for update using (true) with check (true);
create policy "funcionarios_delete" on funcionarios for delete using (true);

-- servicos
create policy "servicos_select" on servicos for select using (true);
create policy "servicos_insert" on servicos for insert with check (true);
create policy "servicos_update" on servicos for update using (true) with check (true);
create policy "servicos_delete" on servicos for delete using (true);

-- agendamentos
create policy "agendamentos_select" on agendamentos for select using (true);
create policy "agendamentos_insert" on agendamentos for insert with check (true);
create policy "agendamentos_update" on agendamentos for update using (true) with check (true);
create policy "agendamentos_delete" on agendamentos for delete using (true);

-- estoque_salao
create policy "estoque_salao_select" on estoque_salao for select using (true);
create policy "estoque_salao_insert" on estoque_salao for insert with check (true);
create policy "estoque_salao_update" on estoque_salao for update using (true) with check (true);
create policy "estoque_salao_delete" on estoque_salao for delete using (true);

-- estoque_revenda
create policy "estoque_revenda_select" on estoque_revenda for select using (true);
create policy "estoque_revenda_insert" on estoque_revenda for insert with check (true);
create policy "estoque_revenda_update" on estoque_revenda for update using (true) with check (true);
create policy "estoque_revenda_delete" on estoque_revenda for delete using (true);

-- ============================================================
-- DADOS DE EXEMPLO
-- ============================================================

-- Funcionárias
insert into funcionarios (nome, cargo, cor, ativo) values
  ('Érika',  'Proprietária',  '#ec4899', true),
  ('Cibeli', 'Cabeleireira',  '#8b5cf6', true);

-- Serviços
insert into servicos (nome, duracao_min, preco, categoria) values
  ('Corte',   30,  50.00, 'Cabelo'),
  ('Mechas', 120, 200.00, 'Coloração'),
  ('Escova',  60,  80.00, 'Cabelo');

-- Clientes
insert into clientes (nome, telefone) values
  ('Cintia Marques',        '44999990001'),
  ('Rayssa Paula Schechi',  '44999990002');

-- Agendamento de exemplo — hoje 2026-05-13 às 10:00 (Cintia / Érika / Corte)
insert into agendamentos (cliente_id, funcionario_id, servico_id, data_hora, status, valor_cobrado)
select
  c.id,
  f.id,
  s.id,
  '2026-05-13 10:00:00-03'::timestamptz,
  'agendado',
  50.00
from
  clientes      c,
  funcionarios  f,
  servicos      s
where
  c.nome = 'Cintia Marques'
  and f.nome = 'Érika'
  and s.nome = 'Corte'
limit 1;
