-- Migração 2026-10-02: desconto, pagamento em várias formas e baixa retroativa
-- Rodar uma vez no Supabase → SQL Editor.

-- Desconto aplicado no fechamento (em R$)
alter table agendamentos add column if not exists desconto numeric(10,2) default 0;

-- Formas de pagamento usadas: [{"forma":"pix","valor":100}, {"forma":"dinheiro","valor":50}]
alter table agendamentos add column if not exists pagamentos jsonb;

-- Comandas fechadas em lote (sem pagamento real registrado): não entram no financeiro/comissões
alter table agendamentos add column if not exists baixa_retroativa boolean default false;

-- Permite forma_pagamento = 'misto' (mais de uma forma no mesmo atendimento)
do $$
declare c record;
begin
  for c in
    select con.conname from pg_constraint con
    join pg_class rel on rel.oid = con.conrelid
    where rel.relname = 'agendamentos' and con.contype = 'c'
      and pg_get_constraintdef(con.oid) ilike '%forma_pagamento%'
  loop
    execute format('alter table agendamentos drop constraint %I', c.conname);
  end loop;
end $$;

alter table agendamentos add constraint agendamentos_forma_pagamento_check
  check (forma_pagamento in ('dinheiro','pix','debito','credito','cortesia','fiado','misto'));
