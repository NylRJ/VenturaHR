# VenturaHR — Schema Firebase Legado (inferido do código)

> **Importante:** este documento representa o schema inferido a partir do código da branch `master`. Ele ainda precisa ser confrontado com os documentos reais do projeto Firebase antes de qualquer migração destrutiva.

## 1. Collections observadas

```text
users/{uid}
candidate/{uid}
company/{uid}
admins/{uid}
vaga/{vagaId}
```

Storage observado:

```text
candidate/{uid}/{uuid}
company/{uid}/{uuid}
vagas/{vagaId}/{uuid}
```

---

## 2. `users/{uid}`

### Shape candidato — escrita observada

```json
{
  "id": "uid",
  "name": "string",
  "email": "string",
  "phone": "string|null",
  "images": ["url"],
  "address": {},
  "cpf": "string|null",
  "createdAt": "Timestamp?",
  "updateAt": "Timestamp?"
}
```

### Shape empresa — escrita observada

```json
{
  "id": "uid",
  "name": "string",
  "email": "string",
  "phone": "string|null",
  "images": ["url"],
  "address": {},
  "razaoSocial": "string|null",
  "cnpj": "string|null",
  "createdAt": "Timestamp?",
  "updateAt": "Timestamp?"
}
```

### Inconsistência relevante

A leitura `UserHR.fromDocument` tenta acessar `accountType`, porém os métodos de escrita observados para candidato/empresa não incluem esse campo. O `UserManager` também infere o tipo consultando collections marcadoras (`candidate`, `company`, `admins`).

**V2:** identidade, perfil e memberships devem ser modelados explicitamente; não depender de múltiplas leituras para inferir papel.

---

## 3. `candidate/{uid}`

Documento marcador observado:

```json
{
  "user": "uid"
}
```

Não representa um perfil profissional completo no código analisado; serve primariamente para tipagem do usuário.

---

## 4. `company/{uid}`

Documento marcador observado:

```json
{
  "user": "uid"
}
```

Assim como `candidate`, o shape observado é usado para inferir tipo da conta, enquanto dados da empresa são armazenados em `users/{uid}`.

**Problema de domínio:** uma empresa fica implicitamente 1:1 com uma identidade Firebase. Isso não suporta bem múltiplos recrutadores por empresa, que é um requisito natural da visão original.

**V2:** `Company` deve ter identidade própria e `CompanyMembership` relaciona usuários/recrutadores à empresa.

---

## 5. `admins/{uid}`

A presença do documento é usada para marcar `userHR.admin = true`.

Shape interno ainda não foi encontrado no código analisado.

**V2:** substituir por autorização explícita/claims/membership server-side com trilha de auditoria.

---

## 6. `address`

Objeto embutido observado:

```json
{
  "street": "string|null",
  "number": "string|null",
  "complement": "string|null",
  "district": "string|null",
  "zipCode": "string|null",
  "city": "string|null",
  "state": "string|null",
  "lat": "number|null",
  "long": "number|null"
}
```

### Risco de compatibilidade

O código faz casts diretos, inclusive de latitude/longitude para `double`. Documentos históricos com inteiro, string ou campo ausente podem falhar em runtime.

---

## 7. `vaga/{vagaId}`

### Leitura observada em `Vaga.fromDocument`

```json
{
  "userId": "string",
  "companyTitle": "string",
  "titleVacancy": "string",
  "descriptionVacancy": "string",
  "images": ["url"],
  "workplace": "string",
  "workload": 0,
  "numberOfVacancies": 0,
  "address": {},
  "criteria": []
}
```

### Escrita observada em `Vaga.save`

```json
{
  "id": "string|null",
  "userId": "string",
  "address": {},
  "companyTitle": "string",
  "titleVacancy": "string",
  "descriptionVacancy": "string",
  "image": ["url"],
  "workplace": "string",
  "workload": 0,
  "numberOfVacancies": 0,
  "criterio": []
}
```

Depois da gravação, o código também executa update separado em:

```json
{
  "images": ["urls atualizadas"]
}
```

### Divergências críticas

| Conceito | Leitura | Escrita inicial |
|---|---|---|
| Imagens | `images` | `image` |
| Critérios | `criteria` | `criterio` |

Isso cria potencial para documentos heterogêneos no banco.

---

## 8. Critério legado

Shape inferido:

```json
{
  "name": "string",
  "description": "string",
  "pmd": 1,
  "weight": 1
}
```

Faixas 1–5 são conceito do produto, mas o legado não centraliza invariantes fortes na persistência.

### V2 proposta

```text
JobCriterion
- id
- jobId
- skillId?
- name
- description
- pmd 1..5
- weight 1..5
- required
- minimumYearsExperience?
- source
- order
```

---

## 9. Soft delete de vaga

A exclusão observada escreve:

```json
{
  "deleted": true
}
```

Entretanto, a leitura geral de vagas observada carrega a collection inteira e não mostra filtro server-side obrigatório por `deleted`.

**V2:** status da vaga deve ser explícito (`draft`, `published`, `paused`, `closed`, `archived`) e exclusão lógica não deve depender de convenção informal.

---

## 10. Mapeamento proposto para V2

```text
Firebase legado             VenturaHR V2
────────────────────────────────────────────────
users/{uid}          ->     UserIdentity + Profile
candidate/{uid}      ->     CandidateProfile
company/{uid}        ->     Company + CompanyMembership
admins/{uid}         ->     Role/Authorization
vaga/{id}            ->     Job
criteria/criterio     ->     JobCriterion
images/image          ->     Media/Document references
```

---

## 11. Verificações ainda necessárias no Firebase real

- [ ] quantidade de documentos por collection;
- [ ] todos os nomes de campos efetivamente existentes;
- [ ] percentual de vagas com `criteria` vs `criterio`;
- [ ] percentual de vagas com `images` vs `image`;
- [ ] presença/ausência de `accountType` em `users`;
- [ ] documentos `admins` e seu conteúdo;
- [ ] registros marcados `deleted`;
- [ ] timestamps e tipos reais;
- [ ] referências quebradas de imagens;
- [ ] regras Firestore atuais;
- [ ] regras Storage atuais;
- [ ] índices Firestore existentes;
- [ ] volume total e necessidade de migração em lote.

Nenhum script de migração deve ser executado antes dessas verificações.
