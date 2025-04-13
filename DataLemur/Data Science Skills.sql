-- Problema:
-- Dada uma tabela chamada "candidates", que contém os IDs dos candidatos e suas respectivas habilidades (skills),
-- queremos identificar quais candidatos possuem TODAS as três habilidades exigidas para uma vaga de Cientista de Dados:
--   1. Python
--   2. Tableau
--   3. PostgreSQL
--
-- A consulta deve retornar apenas os IDs dos candidatos que possuem essas três skills.
-- O resultado deve ser ordenado pelo candidate_id em ordem crescente.

SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(DISTINCT skill) = 3
ORDER BY candidate_id;
