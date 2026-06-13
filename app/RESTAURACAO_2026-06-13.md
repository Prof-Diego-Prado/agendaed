# Ponto de Restauração — 2026-06-13

## Estado do projeto

App funcional. Commits aplicados, `www/index.html` sincronizado com `index.html`.

**Último commit:** `fix: cliente recém-cadastrado aparece imediatamente no agendamento`

---

## Como retomar

```bash
# Entrar na pasta do projeto
cd "/Users/apple/Desktop/Claude Code/PROJETOS/agenda_salão"

# Ver estado atual
git log --oneline -5

# Workflow de edição (sempre que alterar index.html)
cp index.html www/index.html
npx cap sync

# Abrir no Xcode (se precisar de build iOS)
npx cap open ios
```

---

## Stack

- **Frontend:** `index.html` único (~6500 linhas) — HTML/CSS/JS puro
- **Banco de dados:** Supabase (PostgreSQL)
- **Mobile wrapper:** Capacitor (`appId: com.edbeautystudio.agenda`)
- **Deploy iOS:** `www/index.html` → `npx cap sync` → Xcode

---

## Features implementadas (ordem cronológica)

1. Design v2 — tema Crème & Bordeaux
2. Modo dia na agenda — ocultar funcionária sem atendimento
3. Soft delete de funcionárias (com confirmação)
4. Botão excluir movido para modal de edição
5. Coluna Erika sempre primeira (fixada, resiste a drag-and-drop)
6. Bottom nav mobile + novo app bar
7. "Manter conectado" na tela de login
8. Layout adaptativo calendário (mobile/tablet/desktop)
9. Redução de altura das barras superiores no mobile
10. Menu mobile como bottom sheet
11. Fix: conteúdo atrás da barra de status iOS
12. Fix: Erika sempre na primeira coluna mesmo após drag-and-drop
13. Fix: cadastro de clientes (`anamnese jsonb`) + validação de cliente no agendamento (`"?"`)
14. Fix UI comanda mobile: botão Cancelar removido, lixeira sempre visível e funcional
15. Fix: cliente recém-cadastrado aparece imediatamente no dropdown de agendamento

---

## Schema Supabase — observações críticas

| Tabela | Observação |
|--------|-----------|
| `clientes` | Coluna `anamnese jsonb` — adicionada via `migracao_anamnese.sql` em 2026-06-11 |
| `funcionarios` | Colunas extras via `migracoes.sql`: `ordem`, `papel`, `pin`, `tipo_remuneracao`, `percentual_comissao`, `salario_fixo`, `ver_valores_erika` |
| `servicos` | Coluna `subcategoria` via `melhorias_v2.sql` |
| `adiantamentos` | Criada via `melhorias_v2.sql` |
| `fechamentos` | Criada via `migracoes.sql` |

---

## Arquivos importantes

```
agenda_salão/
├── index.html              ← app principal (editar aqui)
├── www/index.html          ← cópia para Capacitor (sempre manter em sync)
├── capacitor.config.json   ← appId, appName, webDir
├── package.json            ← dependências Capacitor
├── app/
│   ├── RETOMAR.md          ← setup inicial do Capacitor/Xcode
│   └── RESTAURACAO_2026-06-13.md  ← este arquivo
├── ios/                    ← projeto Xcode
└── android/                ← projeto Android Studio
```

---

## Commits desta sessão (2026-06-13)

```
55751f4 fix: cliente recém-cadastrado aparece imediatamente no agendamento
6fa9566 fix: remove botão Cancelar da comanda, lixeira sempre visível
```
