-- Execute no Supabase SQL Editor

alter table agendamentos add column if not exists forma_pagamento text default 'dinheiro'
  check (forma_pagamento in ('dinheiro','pix','debito','credito','cortesia','fiado'));

create table if not exists despesas (
  id           uuid primary key default gen_random_uuid(),
  nome         text not null,
  valor        numeric(10,2) not null default 0,
  data         date not null default current_date,
  categoria    text not null default 'outros'
               check (categoria in ('aluguel','produto','equipamento','marketing','pessoal','outros')),
  repeticao    text not null default 'nenhuma'
               check (repeticao in ('nenhuma','diaria','semanal','quinzenal','mensal')),
  proxima_data date,
  created_at   timestamptz not null default now()
);
alter table despesas enable row level security;
drop policy if exists "despesas_all" on despesas;
create policy "despesas_all" on despesas for all using (true) with check (true);

create table if not exists debitos_clientes (
  id             uuid primary key default gen_random_uuid(),
  cliente_id     uuid references clientes(id) on delete cascade not null,
  agendamento_id uuid references agendamentos(id) on delete set null,
  valor_original numeric(10,2) not null default 0,
  valor_pago     numeric(10,2) not null default 0,
  data_lancamento date not null default current_date,
  observacoes    text,
  created_at     timestamptz not null default now()
);
alter table debitos_clientes enable row level security;
drop policy if exists "debitos_all" on debitos_clientes;
create policy "debitos_all" on debitos_clientes for all using (true) with check (true);
