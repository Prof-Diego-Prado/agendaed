-- Tabela de itens extras adicionados durante o atendimento
create table if not exists comanda_itens (
  id             uuid primary key default gen_random_uuid(),
  agendamento_id uuid references agendamentos(id) on delete cascade not null,
  descricao      text not null,
  quantidade     integer not null default 1,
  valor_unitario numeric(10,2) not null default 0,
  created_at     timestamptz not null default now()
);
alter table comanda_itens enable row level security;
create policy "comanda_itens_all" on comanda_itens for all using (true) with check (true);
