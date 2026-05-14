-- Execute no Supabase SQL Editor

-- Cor da categoria por serviço
alter table servicos add column if not exists cor_categoria text default null;

-- Pacotes de serviços
create table if not exists pacotes (
  id                uuid primary key default gen_random_uuid(),
  nome              text not null,
  descricao         text,
  preco_promocional numeric(10,2) not null default 0,
  ativo             boolean not null default true,
  created_at        timestamptz not null default now()
);
create table if not exists pacote_itens (
  id         uuid primary key default gen_random_uuid(),
  pacote_id  uuid references pacotes(id) on delete cascade not null,
  servico_id uuid references servicos(id) on delete cascade not null
);

alter table pacotes enable row level security;
drop policy if exists "pacotes_all" on pacotes;
create policy "pacotes_all" on pacotes for all using (true) with check (true);

alter table pacote_itens enable row level security;
drop policy if exists "pacote_itens_all" on pacote_itens;
create policy "pacote_itens_all" on pacote_itens for all using (true) with check (true);
