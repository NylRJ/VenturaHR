**Instituto Infnet**

Escola Superior de Tecnologia da Informação

Graduação em Engenharia da Computação - Engenharia Disciplinada de Software
# Introdução

# **VenturaHR**

Documento de Visão

O RH 2.0 ganhou protagonismo e está sendo promovido a área estratégica, essencial para a tomada de decisão e crescimento do negócio.

Problemas antigos como a dificuldade em medir o retorno sobre o investimento (ROI) das ações, ineficiência do recrutamento e baixo desempenho em treinamentos já têm suas soluções tecnológicas sob medida.

AsHRTechssão startups que desenvolvem soluções tecnológicas para a área de Recursos Humanos (Human Resources), agregando inteligência aos processos. A missão dessas empresas é levar a inovação ao RH, mostrando que a tecnologia pode reduzir custos, aumentar a eficiência e agilizar o crescimento do setor.

# Cenário Atual

VenturaSoft é uma HRTech que atua no segmento de recolocação de profissionais de TI. Devido às peculiaridades desse mercado, os requisitos para contratação têm um dinamismo vertiginoso, pois as tecnologias e as &quot;stacks&quot; adotadas pelas empresas estão em constante evolução.

A empresa necessita que seja construída uma solução de software, chamado de VenturaHR, que tenha abrangência de todos os fluxos operacionais da sua atividade-fim.

A VenturaSoft tem como clientes empresas que precisam fazer processos seletivos para vagas em aberto.

# Solução Desejada

O software VenturaHR precisa ter como diferencial o fato de não manter um banco de Curriculum e sim um banco de Vagas X Critérios X Candidatos.

## Publicação da Vaga

O fluxo de negócio é iniciado com a publicação de uma vaga de trabalho pelos responsáveis na empresa cliente. Cada empresa cliente pode ter várias contas que permitem o cadastro de vagas.

Uma vaga tem dados específicos e é descrita por uma lista de critérios de seleção que podem ser:

- Conhecimento em tecnologias especificas.  

- Conhecimento em idiomas.
- Graduação, Pós-Graduação, Mestrado, Doutorado.
- Tempo de experiência em funções específicas.

Os critérios são variáveis e são informados durante a publicação da vaga. Cada vaga tem o seu conjunto de critérios exclusivo a fim de evitar que critérios semelhantes sejam reconhecidos como diferentes em função de erros de digitação / semântica.

O Perfil Mínimo Desejado - PMD do candidato é uma graduação de 1 (desejável), 2, 3, 4 e 5 (obrigatório) a ser conjugado com o peso que cada critério tem na seleção. Esse perfil indica a adequação dos critérios à vaga publicada.

O perfil da seleção é um índice calculado a partir da média ponderada dos valores definidos para cada critério. Esse índice serve como linha-base para a contratação.

Por exemplo, uma vaga para Analista de Requisitos poderia ter 4 critérios: UML, Língua Inglesa, Análise de Pontos de Função e Experiência Profissional. Observe que nenhum critério foi definido como obrigatório, aceitando candidatos que estejam próximos do que se deseja.

Dessa forma, uma publicação pode ficar assim:

| **Critério** | **Descrição** | **PMD*** | **Peso** |
| --- | --- | ------- | --- |
| UML | O candidato deverá conhecer os principais diagramas da UML: casos de uso, classes e sequência. | 4 | 5 |
| Inglês | Conversação e leitura de documentos técnicos. | 4 | 3 |
| Análise de Pontos de Função | Desejáveis conhecimentos de dimensionamento de sistemas. | 1 | 1 |
| Experiência Profissional | 2 anos de experiência em levantamento de requisitos e análise. | 4 | 2 |

\*Perfil Mínimo Desejado

Nesse exemplo, o perfil da oportunidade é calculado pela média ponderada:

(4\*5) +( 4\*3) + (1\*1) + (4\*2) / (5 + 3 + 1 + 2) = 20 + 12 + 1 + 8 / 11 = 41 / 11 = **3,72**

A tabela acima mostra como o contato da empresa que publica a oportunidade deve especificar uma vaga.

Cada vaga terá uma data/hora limite para receber as informações dos interessados.

## Resposta Para a Vaga

O candidato que desejar responder a essa oportunidade deve poder pesquisar por vários critérios, mas a pesquisa pelo cargo desejado é mandatória. Ao selecionar uma vaga, uma página deverá ser carregada e o candidato deve responder através de valores 1

(nenhum/pouco), 2, 3, 4 e 5 (todo) qual é o seu conhecimento / experiência em cada critério, como por exemplo:

| Critério | Descrição | Conhecimento/ Experiência |
| --- | --- | --- |
| UML | O candidato deverá conhecer os principais diagramas da UML: casos de uso, classes e sequência. | 5 todo |
| Inglês | Conversação e leitura de documentos técnicos. | 3 médio |
| Análise de Pontos de Função | Desejáveis conhecimentos de dimensionamento de sistemas. | 1 nenhum/pouco |
| Experiência Profissional | 2 anos de experiência em levantamento de requisitos e análise. | 5 todo (tem 3 anos) |

O candidato que respondeu à oferta teve o seu perfil calculado da seguinte forma:

(5\*5) +( 3\*3) + (1\*1) + (5\*2) / (5 + 3 + 1 + 2) = 25 + 9 + 1 + 10 / 11 = 45 / 11 = **4,09**

## Regras Gerais

As vagas de emprego têm um período dentro do qual candidatos podem responder. Na data limite da vaga o sistema processará as respostas e mandará um e-mail para o contato da empresa que publicou a oportunidade. Esse e-mail contém um link para o resultado da coleta de dados e os valores de perfil de cada candidato (ranking).

Na página com o resultado o contato da empresa que publicou a oferta pode renovar ou finalizar a publicação.

A página que exibe o resultado de uma publicação de oferta fica disponível por até um mês. A renovação ou encerramento de uma publicação poderá ser feita em até dois dias. Caso nenhuma ação seja tomada pela empresa que publicou a oportunidade, a oferta será encerrada automaticamente pelo sistema. Nessa mesma página, o contato pode obter as informações dos candidatos através de uma consulta que lista todos os que responderam à oferta, os que tiveram pontuação igual ou acima do perfil da oferta ou os x primeiros.

O sistema precisa controlar cadastro e acesso de usuários e empresas e fazer a manutenção automática das ofertas vencidas.

O sistema precisa tornar disponível para o administrador relatórios básicos de acesso por usuário, empresa e número de ofertas.

_-_2_-_
# **Diagrama de Caso de Uso**
![Diagrama de Caso de Uso](https://github.com/NylRJ/VenturaHR/blob/master/Imagens/Diagramas/VenturaRH_Diagram_case_use-Page-Fundo%20Branco.jpg)
_-_3_-_
# **UI**
## Tela de Login
![Tela de Login](https://github.com/NylRJ/VenturaHR/blob/master/Imagens/Screen/LoginScreen-2020-08-17-180748.png)
