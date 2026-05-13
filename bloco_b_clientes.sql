-- Execute no Supabase SQL Editor

-- Anamnese armazenada como JSONB na própria tabela de clientes
alter table clientes add column if not exists anamnese jsonb default '{}';
