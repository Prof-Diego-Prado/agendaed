-- ============================================================
-- 1. FUNCIONÁRIAS — importar do Salão99
-- ============================================================
delete from agendamentos;
delete from funcionarios;

insert into funcionarios (nome, cargo, telefone, cor, ativo) values
  ('Erica Daiane Lepre Do Prado','Proprietária','(44) 99138-3371','#ec4899',true),
  ('Cibeli Agatha Moura Brancher','Cabeleireira','(44) 9849-1756','#8b5cf6',true),
  ('Amanda','Maquiadora',NULL,'#10b981',true),
  ('Jaqueline Michels','Manicure / Maquiagem','(44) 9153-1537','#f59e0b',true),
  ('Priscila Michels','Cabeleireira',NULL,'#06b6d4',true),
  ('Luiza Lepre Do Prado','Auxiliar','(44) 98464-2052','#f97316',true),
  ('Larissa','Colaboradora',NULL,'#84cc16',false),
  ('Juliana','Colaboradora',NULL,'#14b8a6',false),
  ('Joyce','Colaboradora',NULL,'#a855f7',false),
  ('Poliana Carneiro Capatti','Colaboradora',NULL,'#ef4444',false);