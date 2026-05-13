-- ============================================================
-- MIGRAÇÃO: Papéis, permissões, comissões e fechamentos
-- Execute no SQL Editor do Supabase
-- ============================================================

-- 1. Novos campos em funcionarios
alter table funcionarios add column if not exists papel              text    default 'funcionaria' check (papel in ('admin','funcionaria'));
alter table funcionarios add column if not exists ver_valores_erika  boolean default false;
alter table funcionarios add column if not exists tipo_remuneracao   text    default 'comissao'    check (tipo_remuneracao in ('fixo','comissao'));
alter table funcionarios add column if not exists percentual_comissao numeric(5,2) default 0;
alter table funcionarios add column if not exists salario_fixo       numeric(10,2) default 0;
alter table funcionarios add column if not exists pin                text    default '1234';

-- 2. Papéis corretos
update funcionarios set papel = 'admin', ver_valores_erika = true
where nome ilike '%erica%' or nome ilike '%érika%' or nome ilike '%luiza%';

update funcionarios set papel = 'funcionaria'
where nome not ilike '%erica%' and nome not ilike '%érika%' and nome not ilike '%luiza%';

-- 3. Comissões iniciais (ajuste conforme acordado)
update funcionarios set percentual_comissao = 40 where nome ilike '%cibeli%';
update funcionarios set percentual_comissao = 40 where nome ilike '%jaqueline%';
update funcionarios set percentual_comissao = 40 where nome ilike '%priscila%';
update funcionarios set percentual_comissao = 40 where nome ilike '%amanda%';
update funcionarios set percentual_comissao = 0,  tipo_remuneracao = 'fixo' where nome ilike '%luiza%';

-- 4. Tabela de fechamentos de pagamento
create table if not exists fechamentos (
  id             uuid primary key default gen_random_uuid(),
  funcionario_id uuid references funcionarios(id) on delete cascade not null,
  periodo_inicio date not null,
  periodo_fim    date not null,
  total_bruto    numeric(10,2) default 0,
  total_comissao numeric(10,2) default 0,
  status         text default 'aberto' check (status in ('aberto','pago')),
  observacoes    text,
  created_at     timestamptz not null default now()
);

alter table fechamentos enable row level security;
create policy "fechamentos_all" on fechamentos for all using (true) with check (true);

-- Verificar resultado
select nome, papel, ver_valores_erika, tipo_remuneracao, percentual_comissao, pin
from funcionarios order by papel desc, nome;
