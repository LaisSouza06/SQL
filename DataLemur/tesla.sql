--O que deve ser feito:
--Tesla está investigando os gargalos na produção e precisa de sua ajuda para extrair dados relevantes sobre as peças que ainda não finalizaram o processo de montagem.
--A tarefa é escrever uma consulta SQL para determinar quais peças começaram o processo de montagem, mas ainda não foram finalizadas. Isso significa que essas peças estão em andamento no processo de montagem, mas ainda não têm uma data de finalização registrada (finish_date é NULL).
--A tabela parts_assembly contém informações sobre as peças em produção, incluindo o nome da peça (part), a data de finalização (finish_date), e a etapa de montagem (assembly_step).
--A tarefa é encontrar as peças que não têm data de finalização e listar suas etapas de montagem.

--Abaixo está a query SQL que resolve esse problema.

SELECT 
    part, 
    assembly_step
FROM 
    parts_assembly
WHERE 
    finish_date IS NULL
ORDER BY 
    part, 
    assembly_step;
