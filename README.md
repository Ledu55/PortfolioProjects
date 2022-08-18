# Covid Dashboard
### Visualizando principais indicadores da COVID19

---
Acesse o DashBoard em [Power BI][dashpowerbi]

# 1.0 Objetivo
A Covid-19 impactou o mundo de formas nunca antes vistas, o objetivo
deste projeto é acompanhar os principais indicadores dessa doença e
entender como a vacinação impactou no combate à essa doença.

# 2.0 A solução 
A solução aplicada neste projeto foi uma visualização utilizando 
ferramentas de dashboard que apresentam gráficos de maneira dinâmica.

## 2.1 Fonte de Dados
Os dados utilizados foram extraidos do site [ourworldindata][dataset] 
armazendos em um banco de dados SQL Server. 

# 3.0 Exploração de Dados
Para realizar a exploração dos dados foi utilizado a linguagem SQL
as análises podem ser vistas através desse [jupyter nnotebook][sql].

# 4.0 Construção do Dashboard
O Dashboard foi construido com a ferramenta PowerBI.

## 4.1 Conexão com banco de Dados
A conexão foi feita através da integração nativa do PowerBi com o
SQL server através da Query Direta.

## 4.2 Tabela Calendário
Para que haja uma conexão entre as tabelas extraidas do banco de
dados e a criação de um dash dinâmico, foi criada a tabela calendário
através da seguinte fórmula DAX:

= List.Dates(#date(1900,1,1), Number.From(DateTime.LocalNow())- Number.From(#date(1900,1,1)) ,#duration(1,0,0,0))

## 4.3 Relacionamento
Como os dados estão divididos em vacinação e mortes foi realizado o 
relacionamento da tabela calendário com as citadas anteriormente
através do atributo data.

![relacionamento](https://github.com/Ledu55/Sql_Covid_Project/blob/main/Imagens/Relacionamento.png?raw=true)

## 4.4 Resultado
O resultado final do dashboard porde ser visualizado abaixo:

![resultado](https://github.com/Ledu55/Sql_Covid_Project/blob/main/Imagens/Dash.png?raw=true)




    
[dashpowerbi]: https://app.powerbi.com/view?r=eyJrIjoiNmFmNWM0YTAtMjA3OC00ZDI5LWJlNGMtMWI1Y2JhNDJhODQ1IiwidCI6IjI1ZDM2M2EyLTRjNzktNDRlNy05N2I3LWVkZjgxZGY3ZTYwOSJ9
[dataset]: https://ourworldindata.org/covid-deaths
[sql]: https://github.com/Ledu55/Sql_Covid_Project/blob/main/covid_sql_project.ipynb
