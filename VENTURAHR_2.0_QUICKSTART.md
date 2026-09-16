# VenturaHR 2.0 — Quickstart

Esta é a forma mais simples de testar a V2 sem alterar o app legado.

## Requisitos

- Flutter stable atual (recomendado Flutter 3.47.x ou superior)
- Chrome instalado
- Git

Verifique:

```bash
flutter --version
flutter doctor
```

## Clonar diretamente a V2

```bash
git clone -b ventura-2.0 --single-branch https://github.com/NylRJ/VenturaHR.git
cd VenturaHR/apps/ventura_hr
flutter pub get
flutter run -d chrome
```

O app deve abrir a rota `/`.

A demonstração do motor de matching fica em:

```text
/match
```

Você também pode abrir pelo botão **Abrir demonstração do Match PMD**.

## O que testar agora

1. Alterar o nível do candidato entre 0 e 5.
2. Observar o percentual de aderência sendo recalculado.
3. Ver o perfil PMD da vaga e do candidato.
4. Ver requisitos obrigatórios não atendidos.
5. Desmarcar **Evidência confirmada** para simular uma informação sugerida por IA.
6. Confirmar que evidência provisória deixa de participar do score oficial.
7. Atualizar diretamente a URL `/match` e testar back/forward do navegador.

## Executar testes

```bash
flutter test
flutter analyze
```

## Build Web

```bash
flutter build web
```

Saída:

```text
build/web/
```

## Android

O código V2 é multiplataforma, mas nesta primeira entrega o repositório prioriza Web. Para gerar o scaffold Android localmente enquanto ele ainda não estiver versionado:

```bash
flutter create --platforms=android --org br.com.venturahr .
flutter run -d android
```

ou:

```bash
flutter build apk --debug
```

> O comando acima deve ser executado dentro de `apps/ventura_hr`.

## Estrutura atual

```text
VenturaHR/
├── ventura_rh/                 # aplicativo legado, preservado
├── packages/
│   └── ventura_domain/         # domínio Dart puro e PMD Engine V2
└── apps/
    └── ventura_hr/             # novo cliente Flutter Web-first
```

Nenhuma configuração Firebase é necessária para testar esta etapa.
