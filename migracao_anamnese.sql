-- ============================================================
-- MIGRAÇÃO: Coluna anamnese em clientes
-- Execute no SQL Editor do Supabase
-- ============================================================

alter table clientes add column if not exists anamnese jsonb;
