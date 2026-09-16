# VenturaHR 2.0 — Auditoria Técnica do Legado

> Status: diagnóstico inicial do repositório `NylRJ/VenturaHR` antes da modernização.
> Branch de trabalho: `ventura-2.0`.
> Princípio: o código legado em `master` não será alterado durante esta fase.

## 1. Resumo executivo

O VenturaHR possui uma ideia de domínio que continua relevante: **Vaga × Critérios × Candidatos**, com um Perfil Mínimo Desejado (PMD), pesos e cálculo de aderência. A modernização não deve eliminar esse núcleo; deve transformá-lo em um mecanismo de matching explicável, auditável e assistido por IA.

O projeto atual, entretanto, foi construído com Flutter/Dart e Firebase de uma geração anterior e mistura regras de domínio, estado de UI, persistência e infraestrutura. Há também pontos concretos de segurança, compatibilidade Web, consistência de dados, testes e CI que impedem uma atualização simples por troca de versões.

**Decisão recomendada:** migração incremental por estrangulamento do legado, preservando conceitos e dados úteis, enquanto um novo núcleo é criado com arquitetura moderna.

---

## 2. Inventário atual

### 2.1 Stack observada

- Flutter com Dart pré-null-safety (`>=2.7.0 <3.0.0`).
- Firebase Auth, Firestore e Firebase Storage diretamente no cliente.
- `provider` como gerenciamento de estado.
- `dio` para HTTP.
- Dependências antigas de imagem, localização, UI e utilitários.
- Android, iOS e scaffold Web presentes no repositório.
- GitHub Actions antigo.

### 2.2 Estrutura funcional encontrada

- Cadastro/autenticação de usuário.
- Perfis de pessoa física, empresa e administrador.
- Endereço e serviços de CEP.
- Listagem e busca simples de vagas.
- Modelo de vaga com critérios, PMD e peso.
- Tela de detalhes de vaga.
- Tela de edição de vaga parcialmente implementada.
- Upload de imagens para Firebase Storage.

### 2.3 Estrutura do código

A aplicação está organizada principalmente em:

```text
lib/
├── common/
├── helpers/
├── models/
├── screens/
├── services/
├── utils/
└── widgets/
```

É uma estrutura típica de aplicativo Flutter da época, mas não estabelece fronteiras fortes entre domínio, aplicação, apresentação e infraestrutura.

---

## 3. Achados críticos — P0

### P0-01 — Credencial de serviço exposta no cliente

Existe token de serviço de CEP gravado diretamente no código-fonte de um repositório público.

**Risco:** uso indevido da credencial, consumo de cota e impossibilidade de tratar o segredo como confidencial.

**Ação:**
1. revogar/rotacionar a credencial existente;
2. retirar segredos do Flutter;
3. colocar chamadas privilegiadas no backend;
4. usar Secret Manager/variáveis seguras no ambiente de servidor.

### P0-02 — Modelo de usuário contém senha e pode imprimi-la

`UserHR` mantém `password` e `confirmPassword` como campos do modelo e o método `toString()` os inclui.

**Risco:** vazamento acidental em logs, crash reports ou debugging.

**Ação:** senha deve existir apenas no fluxo transitório de autenticação e nunca fazer parte da entidade persistente de usuário.

### P0-03 — Inconsistência no schema de Vaga

A leitura de `Vaga` espera campos como `images` e `criteria`, enquanto o fluxo de gravação usa nomes diferentes em parte do payload, como `image` e `criterio`.

**Risco:** perda de dados, leitura incompleta, incompatibilidade entre registros novos e antigos.

**Ação:** documentar o schema atual, criar migração e adotar DTOs/versionamento de schema.

### P0-04 — Tela de edição não conclui a persistência

O botão de salvar da edição de vaga apenas valida o formulário e imprime uma mensagem; não existe persistência efetiva no fluxo observado.

**Risco:** funcionalidade aparentemente disponível sem efetivar a alteração.

**Ação:** o fluxo será reimplementado como caso de uso testável antes de ser exposto na V2.

---

## 4. Achados de alta prioridade — P1

### P1-01 — Código não é realmente Web-safe

Apesar de existir a pasta `web/`, partes centrais importam `dart:io` e trabalham diretamente com `File`.

**Impacto:** o mesmo código não pode ser considerado multiplataforma sem uma abstração de arquivo/upload.

**Correção-alvo:** trabalhar com abstrações como bytes/XFile/document gateway e deixar detalhes de plataforma na infraestrutura.

### P1-02 — Entidades acopladas ao Firebase

`Vaga` e `UserHR` conhecem Firestore, Storage, loading e `ChangeNotifier`.

**Impacto:**
- difícil testar;
- difícil migrar de banco;
- difícil executar lógica no backend;
- domínio dependente de framework.

**Correção-alvo:** entidades Dart puras + interfaces de repositório + adapters de infraestrutura.

### P1-03 — Busca de vagas não escala

`VagaManager` carrega a coleção inteira e filtra pelo título no dispositivo.

**Correção-alvo:** consultas paginadas, filtros estruturados, índice de skills e busca semântica no lado servidor.

### P1-04 — Navegação antiga e pouco adequada à Web

A aplicação usa `onGenerateRoute`, `PageView` e dois `MaterialApp` aninhados.

**Correção-alvo:** um único app shell, roteamento declarativo, deep links e URLs navegáveis.

### P1-05 — CI não protege a aplicação atual

O workflow observado:

- roda apenas na branch antiga `sprint-5`;
- usa comandos `dart` para um projeto Flutter;
- não está configurado para a estrutura atual do app;
- não protege `master`/`ventura-2.0`.

**Correção-alvo:** CI Flutter com format, analyze, test e builds mínimos de Web/Android.

### P1-06 — Testes praticamente inexistentes

Existe apenas o teste padrão do contador gerado pelo template Flutter, que não representa o VenturaHR.

**Correção-alvo:** pirâmide de testes começando pelo domínio de PMD/matching, autenticação, vagas e critérios.

---

## 5. Achados de média prioridade — P2

- múltiplas implementações/telas de login indicam código residual;
- responsividade limitada a uma distinção simples celular/tablet;
- assets e fontes duplicados fora e dentro do app aumentam ruído e tamanho do repositório;
- arquivos `.zip` e materiais de assessment podem ser removidos ou arquivados fora do runtime;
- regras de acesso do Firestore/Storage não estão versionadas no repositório observado;
- camada `services` tem apenas serviços de CEP, enquanto persistência está espalhada nos modelos;
- nomes e convenções possuem inconsistências (`address_creen`, `cepabeto`, etc.);
- callbacks e campos sem tipagem/null-safety modernos aumentam risco de erro de runtime.

---

## 6. O que deve ser preservado

### 6.1 Conceito de PMD

Preservar o PMD 1–5 e pesos como componente **determinístico e explicável** do matching.

### 6.2 Critério de vaga

O objeto atual `Criterio` é simples e pode evoluir para `JobCriterion` com:

- skill normalizada;
- descrição;
- PMD;
- peso;
- obrigatório/opcional;
- evidências aceitas;
- nível de proficiência;
- experiência mínima;
- origem do critério: humano ou sugestão de IA.

### 6.3 Separação de perfis

Preservar os conceitos de candidato, empresa/recrutador e administrador, mas remodelar autorização com papéis e memberships explícitos.

### 6.4 Fluxo de vaga

Preservar o ciclo criar → publicar → candidatar → comparar → encerrar/renovar, evoluindo-o para um pipeline auditável.

---

## 7. O que não deve ser carregado para a V2

- `ChangeNotifier` dentro de entidade de domínio;
- acesso direto ao Firestore/Storage dentro da entidade;
- senha dentro do modelo `User`;
- `dart:io` no domínio;
- leitura integral de coleções para pesquisa;
- ranking opaco ou decisão automática por IA;
- segredo/API token no aplicativo;
- regra de negócio definida dentro de widgets;
- schema sem versão;
- CI/teste de template sem relação com o produto.

---

## 8. Estratégia de migração

Não atualizar o projeto legado pacote por pacote até ele “compilar”. Em vez disso:

```text
LEGADO (preservado)
      │
      ├── extrair regras válidas
      ├── mapear schema Firebase
      ├── escrever testes de caracterização
      │
      ▼
NOVO NÚCLEO V2
      │
      ├── domínio puro
      ├── repositories
      ├── casos de uso
      ├── adapters Firebase/API
      ├── Flutter Web/Android/iOS
      └── IA no servidor
```

A V2 poderá coexistir temporariamente com os dados atuais durante a transição.

---

## 9. Definition of Done da auditoria M0

A auditoria estará encerrada quando:

- [x] estrutura do repositório estiver mapeada;
- [x] riscos críticos iniciais estiverem identificados;
- [x] conceito de domínio a preservar estiver definido;
- [ ] collections e documentos reais do Firebase forem inventariados;
- [ ] regras de segurança atuais forem obtidas/registradas, se existirem;
- [ ] fluxo completo candidato/empresa/vaga for caracterizado com exemplos de dados;
- [ ] credencial exposta for rotacionada pelo proprietário do serviço;
- [ ] arquitetura V2 estiver aprovada;
- [ ] backlog M0–M6 estiver criado.

---

## 10. Próximo passo técnico

A partir desta auditoria, implementar primeiro a **Foundation V2**, sem IA ainda:

1. bootstrap do novo app Flutter moderno;
2. domínio puro para `Job`, `JobCriterion`, `CandidateProfile` e `MatchScore`;
3. testes do algoritmo PMD;
4. autenticação e repositories abstraídos;
5. navegação Web-first/responsiva;
6. CI funcionando;
7. só então adicionar matching semântico e serviços de IA.
