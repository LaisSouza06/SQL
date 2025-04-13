-- Problema:
-- Temos duas tabelas:
-- 1. activities: contém informações sobre o tipo de atividade feita no Snapchat (enviar, abrir, conversar), 
-- quanto tempo foi gasto e por quem.
-- 2. age_breakdown: mostra o grupo de idade (age_bucket) de cada usuário.

-- Objetivo:
-- Para cada faixa etária (age_bucket), queremos saber:
-- - A porcentagem de tempo gasto enviando snaps (`send`)
-- - A porcentagem de tempo gasto abrindo snaps (`open`)

-- Regras:
-- - Devemos ignorar atividades do tipo `chat`.
-- - As porcentagens devem ser arredondadas para 2 casas decimais.
-- - A soma das porcentagens de `send` e `open` em cada faixa etária deve totalizar 100%.

SELECT
  ab.age_bucket,
  ROUND(
    SUM(CASE WHEN a.activity_type = 'send' THEN a.time_spent ELSE 0 END) * 100.0
    /
    SUM(CASE WHEN a.activity_type IN ('send', 'open') THEN a.time_spent ELSE 0 END),
    2
  ) AS send_perc,
  ROUND(
    SUM(CASE WHEN a.activity_type = 'open' THEN a.time_spent ELSE 0 END) * 100.0
    /
    SUM(CASE WHEN a.activity_type IN ('send', 'open') THEN a.time_spent ELSE 0 END),
    2
  ) AS open_perc
FROM activities a
JOIN age_breakdown ab
  ON a.user_id = ab.user_id
WHERE a.activity_type IN ('send', 'open') -- Ignora 'chat'
GROUP BY ab.age_bucket
ORDER BY ab.age_bucket;

