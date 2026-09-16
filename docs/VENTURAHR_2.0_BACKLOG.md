# VenturaHR 2.0 — Backlog de Modernização

> Backlog inicial orientado a entrega. Prioridade: segurança e núcleo funcional antes de IA.

## Convenções

- **P0:** risco crítico/bloqueador.
- **P1:** necessário para primeira versão utilizável.
- **P2:** evolução importante.
- **P3:** otimização/futuro.

Status: `TODO`, `DOING`, `DONE`, `BLOCKED`.

---

# M0 — Auditoria e contenção de risco

## SEC-001 — Rotacionar credencial exposta do serviço de CEP

- Prioridade: **P0**
- Status: TODO
- Responsável externo: proprietário da conta/credencial

### Aceite
- credencial antiga revogada/rotacionada;
- nenhum segredo privilegiado permanece no Flutter;
- chamada futura usa backend seguro ou serviço sem segredo quando adequado.

## SEC-002 — Remover senha do domínio User

- Prioridade: **P0**
- Status: TODO

### Aceite
- entidade persistente não contém senha/confirmPassword;
- logs/toString nunca imprimem credenciais;
- autenticação recebe credenciais apenas como comando/DTO transitório.

## DATA-001 — Inventariar schema Firebase legado

- Prioridade: **P0**
- Status: TODO

### Escopo
- users;
- candidate;
- company;
- admins;
- vaga;
- Storage relacionado.

### Aceite
- campos e tipos documentados;
- exemplos anonimizados registrados;
- divergências `images/image`, `criteria/criterio` identificadas;
- plano de migração definido.

## SEC-003 — Versionar regras de acesso

- Prioridade: **P0**
- Status: TODO

### Aceite
- regras Firestore/Storage existentes recuperadas ou substituídas;
- regras mantidas em código;
- testes de autorização para candidato, recrutador e admin.

## QA-001 — Testes de caracterização do legado

- Prioridade: **P1**
- Status: TODO

### Aceite
- teste da fórmula PMD;
- teste de serialize/deserialize de critério;
- teste de leitura de vaga legada;
- teste de papéis/perfis existentes.

---

# M1 — Foundation V2

## ARCH-001 — Criar workspace V2

- Prioridade: **P1**
- Status: TODO

### Estrutura alvo

```text
apps/ventura_hr/
packages/ventura_domain/
services/ventura_api/
```

### Aceite
- legado continua compilável/isolado enquanto necessário;
- novo app usa Dart moderno/null safety;
- nenhum código V2 depende diretamente das classes legadas.

## DOM-001 — Criar domínio puro

Entidades/VO iniciais:

- `Job`;
- `JobCriterion`;
- `Skill`;
- `CandidateProfile`;
- `Application`;
- `MatchResult`;
- `MatchComponent`.

### Aceite
- pacote Dart sem Flutter/Firebase;
- invariantes validadas;
- cobertura de teste do matching inicial.

## MATCH-001 — Implementar PMD Engine V2

- Prioridade: **P1**
- Status: TODO

### Requisitos
- PMD 1–5;
- peso configurável;
- critério obrigatório/opcional;
- algoritmo versionado;
- resultado por componente;
- score total reproduzível.

### Aceite
- mesmos inputs sempre produzem mesmo output;
- cada parcela do score é explicável;
- testes incluem limites, pesos diferentes e critérios obrigatórios.

## APP-001 — Novo App Shell Flutter

### Aceite
- um único `MaterialApp`/app shell;
- tema V2;
- roteamento declarativo;
- layout compact/medium/expanded;
- tela inicial renderiza no Web e Android.

## CI-001 — Pipeline Flutter V2

### Aceite
Em pull requests e branch V2:

- format check;
- static analyze;
- unit tests;
- widget tests essenciais;
- build Web;
- build Android de validação.

---

# M2 — Identidade, empresas e Web-first

## AUTH-001 — Autenticação V2

### Aceite
- login/logout;
- sessão restaurável;
- usuário sem senha no perfil;
- guards de rota;
- erros tipados.

## AUTH-002 — RBAC / memberships

Papéis iniciais:

- candidate;
- recruiter;
- company_admin;
- platform_admin.

### Aceite
- recrutador só acessa empresas às quais pertence;
- candidato só altera o próprio perfil;
- ações administrativas registradas.

## COMPANY-001 — Empresa e membros

### Aceite
- criar/editar empresa;
- convidar/associar recrutador em etapa posterior;
- listar membros e papéis;
- separação clara entre identidade e empresa.

## WEB-001 — Navegação/deep links

### Aceite
- `/jobs/:id` abre diretamente uma vaga;
- refresh preserva a rota;
- back/forward do browser funcionam;
- rota protegida redireciona corretamente.

## FILE-001 — Upload multiplataforma

### Aceite
- Web e mobile não dependem de `dart:io` no domínio;
- upload usa abstração de documento/bytes;
- valida tamanho/tipo;
- storage path é controlado pelo backend/adaptor.

---

# M3 — Core HR completo

## JOB-001 — Criar vaga

Campos iniciais:

- título;
- descrição;
- empresa;
- modalidade;
- localização;
- senioridade;
- número de posições;
- prazo;
- status.

## JOB-002 — Gerenciar critérios

### Aceite
- adicionar/remover/ordenar;
- PMD e peso;
- obrigatório/opcional;
- skill canônica opcional na primeira iteração;
- validações explícitas.

## JOB-003 — Publicar/pausar/encerrar/renovar

### Aceite
- máquina de estados documentada;
- transições inválidas rejeitadas;
- eventos de domínio emitidos.

## CAND-001 — Perfil de candidato

### Aceite
- informações profissionais separadas de identidade;
- skills/evidências;
- experiência;
- formação;
- idiomas;
- preferências de vaga;
- consentimento e controles de privacidade.

## APP-002 — Candidatura

### Aceite
- candidato responde critérios;
- salva evidências/respostas;
- não permite candidatura fora do período;
- histórico de status.

## MATCH-002 — Match determinístico ponta a ponta

### Aceite
- candidatura gera MatchResult;
- versão do algoritmo registrada;
- explicação visível ao recrutador;
- explicação apropriada ao candidato.

---

# M4 — Skill Graph + Matching 2.0

## SKILL-001 — Catálogo canônico de skills

### Aceite
- Skill com ID estável;
- aliases;
- busca por alias;
- merge controlado de duplicatas;
- trilha de auditoria.

## SKILL-002 — Relações entre skills

Tipos iniciais:

- related_to;
- ecosystem_of;
- prerequisite_of;
- specialization_of.

## MATCH-003 — Evidência profissional

### Aceite
- skill pode apontar para experiências/documentos;
- origem da evidência registrada;
- evidência confirmada vs. sugerida diferenciada.

## SEARCH-001 — Busca estruturada

Filtros:

- skill;
- senioridade;
- modalidade;
- localização;
- empresa;
- status/data.

## SEARCH-002 — Preparar índice semântico

### Aceite
- documentos elegíveis indexados;
- atualização/reindexação idempotente;
- nenhuma informação sensível indevida entra no índice.

---

# M5 — AI Layer

## AI-PLAT-001 — AI Orchestrator

- Prioridade: **P1 para M5**

### Aceite
- provedor não é chamado diretamente pelo Flutter para operações privilegiadas;
- prompts versionados;
- structured outputs validados;
- timeouts/retries controlados;
- custo e latência observáveis;
- auditoria de artefatos relevantes.

## AI-001 — Normalizador de skills

### Fluxo

```text
texto → aliases → busca semântica → sugestões → confirmação → skill canônica
```

### Aceite
- IA nunca cria silenciosamente uma skill canônica global;
- usuário/revisor confirma ambiguidades;
- decisão armazenada para reduzir repetição.

## AI-002 — Job Builder

### Aceite
- transforma descrição livre em draft estruturado;
- sugere critérios/PMD/pesos sem publicar sozinho;
- recrutador vê o que foi sugerido e pode editar;
- versão do prompt/modelo registrada.

## AI-003 — Resume Parser

### Aceite
- PDF/DOCX processável;
- extrai experiências, skills, formação, idiomas, certificações;
- cada item mantém proveniência;
- candidato revisa antes de confirmar dados relevantes;
- falhas de extração não apagam perfil existente.

## AI-004 — Recruiter Copilot

### Primeiros comandos
- resumir evidências;
- explicar gaps;
- comparar candidatos selecionados sem gerar decisão final automática;
- sugerir perguntas técnicas de entrevista.

## AI-005 — Candidate Copilot

### Primeiros comandos
- explicar match;
- mostrar gaps;
- apontar dados incompletos;
- ajudar preparação para requisitos reais da vaga.

---

# M6 — Intelligence Platform

## ANALYTICS-001 — Funil de recrutamento

Métricas:

- vagas publicadas;
- candidaturas;
- match distribution;
- conversões por etapa;
- tempo de preenchimento;
- abandono;
- fontes.

## ANALYTICS-002 — Skill intelligence

- skills mais demandadas;
- skills emergentes;
- gaps do talent pool;
- distribuição por senioridade;
- tendências por período.

## TALENT-001 — Talent Pool

### Aceite
- candidatos com consentimento apropriado podem entrar em pool;
- busca por evidência/skill;
- controles de retenção e privacidade.

## EVENT-001 — Arquitetura orientada a eventos

Eventos iniciais:

- JobPublished;
- ApplicationSubmitted;
- ResumeUploaded;
- ResumeParsed;
- MatchCalculated;
- JobDeadlineReached;
- JobClosed.

## AUTO-001 — Automações

Consumidores possíveis:

- e-mail;
- notificações;
- recálculo de match;
- indexação;
- analytics;
- auditoria.

---

# Guardrails obrigatórios de IA e recrutamento

Aplicam-se a todos os marcos:

- [ ] IA não rejeita automaticamente candidato;
- [ ] atributos sensíveis não participam do score;
- [ ] não inferir atributos sensíveis;
- [ ] cada score oficial é reproduzível e versionado;
- [ ] dado extraído por IA possui origem/proveniência;
- [ ] usuário pode corrigir extrações;
- [ ] auditoria registra alterações relevantes;
- [ ] privilégios são verificados no servidor;
- [ ] segredos não ficam no cliente;
- [ ] prompts não recebem dados desnecessários.

---

# Ordem de implementação recomendada

```text
M0 Segurança/Auditoria
        ↓
M1 Foundation + PMD Engine
        ↓
M2 Auth + Web
        ↓
M3 Core HR ponta a ponta
        ↓
M4 Skill Graph + busca
        ↓
M5 IA
        ↓
M6 Inteligência/automação
```

A primeira meta de produto é uma **vertical slice sem IA**: criar vaga → critérios → candidatura → match PMD explicável no Web. Essa slice será a prova de que a arquitetura funciona. IA entra logo depois, sobre um domínio confiável.
