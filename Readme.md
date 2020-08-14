**Instituto Infnet**

Escola Superior de Tecnologia da Informação

Graduação em Engenharia da Computação - Disciplinada Engenharia de Software


## Introdução

# **VenturaHR**

# Documento de Visão

O RH 2.0 ganhou protagonismo e está sendo promovido a área estratégica, essencial para a tomada de decisão e crescimento do negócio.

Problemas antigos como a dificuldade em medir o retorno sobre o investimento (ROI) das ações, ineficiência do recrutamento e baixo desempenho em treinamentos já têm suas soluções tecnológicas sob medida.

As HRTechs são startups que desenvolvem soluções tecnológicas para a área de Recursos Humanos (Human Resources), agregando inteligência aos processos. A missão dessas empresas é levar a inovação ao RH, mostrando que a tecnologia pode reduzir custos, aumentar a eficiência e agilizar o crescimento dosetor.

## Cenário Atual

VenturaSoft é uma HRTech que atua no segmento de recolocação de profissionais de TI. Devido às peculiaridades desse mercado, os requisitos para contratação têm um dinamismo vertiginoso, pois as tecnologias e as &quot;stacks&quot; adotadas pelas empresas estão em constante evolução.

Aempresanecessitaquesejaconstruídaumasoluçãodesoftware,chamadodeVenturaHR,que tenha abrangência de todos os fluxos operacionais da sua atividadefim.

A VenturaSoft tem como clientes empresas que precisam fazer processos seletivos para vagas em aberto.

## Solução Desejada

O software VenturaHR precisa ter como diferencial o fato de não manter um banco de curriculums e sim um banco de Vagas X Critérios X Candidatos.

### Publicação da Vaga

O fluxo de negócio é iniciado com a publicação de uma vaga de trabalho pelos responsáveis na empresa cliente. Cada empresa cliente pode ter várias contas que permitem o cadastro de vagas.

Uma vaga tem dados específicos e é descrita por uma lista de critérios de seleção que podem ser:

- Conhecimento em tecnologiasespecificas.

- Conhecimento emidiomas.
- Graduação, Pós-Graduação, Mestrado,Doutorado.
- Tempo de experiência em funçõesespecíficas.

Os critérios são variáveis e são informados durante a publicação da vaga. Cada vaga tem o seu conjunto de critérios exclusivo a fim de evitar que critérios semelhantes sejam reconhecidos como diferentes em função de erros de digitação / semântica.

O Perfil Mínimo Desejado - PMD do candidato é uma graduação de 1 (desejável), 2, 3, 4 e 5 (obrigatório) a ser conjugado com o peso que cada critério tem na seleção. Esse perfil indica a adequação dos critérios à vaga publicada.

O perfil da seleção é um índice calculado a partir da média ponderada dos valores definidos para cada critério. Esse índice serve como linha-base para a contratação.

Por exemplo, uma vaga para Analista de Requisitos poderia ter 4 critérios: UML, Língua Inglesa, Análise de Pontos de Função e Experiência Profissional. Observe que nenhum critério foi definido como obrigatório, aceitando candidatos que estejam próximos do que se deseja.

Dessa forma, uma publicação pode ficar assim:

| **Critério** | **Descrição** | **PMD\*** | **Peso** |
| --- | --- | --- | --- |
| UML | O candidato deverá conhecer os principais diagramas da UML: casos de uso, classes eseqüência. | 4 | 5 |
| Inglês | Conversação e leitura de documentos técnicos. | 4 | 3 |
| Análise de Pontos de Função | Desejável conhecimentos de dimensionamento de sistemas. | 1 | 1 |
| Experiência Profissional | 2 anos de experiência em levantamento de requisitos e análise. | 4 | 2 |

\*Perfil Mínimo Desejado

Nesse exemplo, o perfil da oportunidade é calculado pela média ponderada:

(4\*5) +( 4\*3) + (1\*1) + (4\*2) / (5 + 3 + 1 + 2) = 20 + 12 + 1 + 8 / 11 = 41 / 11 = **3,72**

A tabela acima mostra como o contato da empresa que publica a oportunidade deve especificar uma vaga.

Cada vaga terá uma data/hora limite para receber as informações dos interessados.

### Resposta Para a Vaga

O candidato que desejar responder a essa oportunidade deve poder pesquisar por vários critérios, mas a pesquisa pelo cargo desejado é mandatória. Ao selecionar uma vaga, uma página deverá ser carregada e o candidato deve responder através de valores 1

_-_ 2 _-_
