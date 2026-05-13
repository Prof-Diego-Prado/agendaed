-- ============================================================
-- 2. SERVIÇOS — importar do Salão99
-- ============================================================
delete from servicos;

insert into servicos (nome, categoria, duracao_min, preco, ativo) values
  ('Mechas','Química',60,850.00,true),
  ('Tonalizar','Química',30,200.00,true),
  ('Raiz','Química',30,200.00,true),
  ('Contorno','Química',30,500.00,true),
  ('Raiz e Contorno','Química',60,800.00,true),
  ('Raiz e Tratamento','Química',60,250.00,true),
  ('Raiz/corte','Química',50,350.00,true),
  ('Tratamento','Tratamento',70,150.00,true),
  ('Babyliss','Penteados',60,120.00,true),
  ('Hidratação e Baby Liss','Penteados',120,270.00,true),
  ('Penteado','Penteados',60,280.00,true),
  ('Maquiagem (Jacky)','Maquiagem',60,150.00,true),
  ('Maquiagem (Amanda)','Maquiagem',60,200.00,true),
  ('Raiz e Corte','Corte',30,350.00,true),
  ('Corte','Corte',60,200.00,true),
  ('Tratamento e Corte','Corte',90,350.00,true),
  ('Avaliação','Avaliação',30,50.00,true),
  ('Escova','Escova',60,100.00,true),
  ('Unha Erika','Escova',80,70.00,true),
  ('Seal Aligner','Seal Aligner',30,350.00,true);