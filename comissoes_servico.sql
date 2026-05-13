-- Tabela de comissões por serviço por funcionária
-- Execute no SQL Editor do Supabase

create table if not exists comissoes_servico (
  id             uuid primary key default gen_random_uuid(),
  funcionario_id uuid references funcionarios(id) on delete cascade not null,
  servico_id     uuid references servicos(id) on delete cascade not null,
  percentual     numeric(5,2) not null default 0,
  unique(funcionario_id, servico_id)
);

alter table comissoes_servico enable row level security;
drop policy if exists "comissoes_servico_all" on comissoes_servico;
create policy "comissoes_servico_all" on comissoes_servico for all using (true) with check (true);

-- Verificar
select f.nome, s.nome as servico, c.percentual
from comissoes_servico c
join funcionarios f on f.id = c.funcionario_id
join servicos s on s.id = c.servico_id
order by f.nome, s.nome;
