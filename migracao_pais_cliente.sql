-- Execute no Supabase SQL Editor
-- Adiciona suporte a clientes de outros países (ex: Paraguai) no WhatsApp

alter table clientes add column if not exists pais text not null default 'BR';
