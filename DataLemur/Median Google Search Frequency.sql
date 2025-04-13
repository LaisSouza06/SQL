-- 🧠 PROBLEMA:
-- Queremos encontrar a mediana do número de buscas feitas por usuários no ano passado.
-- Mas, ao invés de termos uma lista de buscas por usuário, temos um resumo:
-- cada linha mostra quantos usuários fizeram certa quantidade de buscas.

-- Exemplo:
-- searches | num_users
--      1   |     2       → dois usuários fizeram 1 busca
--      2   |     2       → dois usuários fizeram 2 buscas
--      3   |     3       → três usuários fizeram 3 buscas
--      4   |     1       → um usuário fez 4 buscas

-- Se "expandíssemos" isso, seria:
-- [1, 1, 2, 2, 3, 3, 3, 4] → mediana = (2 + 3)/2 = 2.5

-- Como fazer isso no SQL sem expandir os dados manualmente?
-- Vamos usar a técnica de cálculo de mediana com base em posições acumuladas.

WITH expanded AS (
  -- Criamos uma lista com a posição acumulada dos usuários (como se estivéssemos expandindo a tabela)
  SELECT
    searches,
    num_users,
    SUM(num_users) OVER (ORDER BY searches) AS running_total,
    SUM(num_users) OVER () AS total_users
  FROM search_frequency
),
median_pos AS (
  -- Identificamos as posições onde a mediana está
  SELECT
    *,
    CASE
      WHEN total_users % 2 = 1 THEN total_users / 2 + 1
      ELSE total_users / 2
    END AS pos1,
    CASE
      WHEN total_users % 2 = 1 THEN total_users / 2 + 1
      ELSE total_users / 2 + 1
    END AS pos2
  FROM expanded
),
final AS (
  -- Selecionamos os valores nas posições da mediana
  SELECT
    searches * 1.0 AS median_val
  FROM median_pos
  WHERE running_total >= pos1 AND (running_total - num_users) < pos2
)
-- Calculamos a média dos dois valores da mediana (caso sejam dois números)
SELECT ROUND(AVG(median_val), 1) AS median FROM final;
