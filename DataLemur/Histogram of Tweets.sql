-- Problema:
-- Dada uma tabela chamada "tweets", que contém dados sobre tweets de usuários do Twitter, 
-- o objetivo é criar um histograma de tweets postados por usuário no ano de 2022.
-- O resultado deve agrupar os usuários pelo número de tweets que postaram em 2022 e contar quantos usuários se encaixam em cada grupo.
-- Ou seja, queremos o número de tweets por usuário como "bucket" e a quantidade de usuários que se encaixam nesse "bucket".

-- Tabela tweets:
-- tweet_id (ID do tweet)
-- user_id (ID do usuário)
-- msg (mensagem do tweet)
-- tweet_date (data do tweet)

-- Exemplo de entrada:
-- tweet_id   user_id   msg   tweet_date
-- 214252     111       Am considering taking Tesla private at $420. Funding secured.  12/30/2021 00:00:00
-- 739252     111       Despite the constant negative press covfefe                     01/01/2022 00:00:00
-- 846402     111       Following @NickSinghTech on Twitter changed my life!           02/14/2022 00:00:00
-- 241425     254       If the salary is so competitive why won’t you tell me what it is? 03/01/2022 00:00:00
-- 231574     148       I no longer have a manager. I can't be managed                 03/23/2022 00:00:00

-- A consulta deve retornar:
-- tweet_bucket   users_num
-- 1              2
-- 2              1

-- Onde "tweet_bucket" é o número de tweets postados e "users_num" é a quantidade de usuários que postaram esse número de tweets.

SELECT tweet_count AS tweet_bucket, COUNT(*) AS users_num
FROM (
    SELECT user_id, COUNT(*) AS tweet_count
    FROM tweets
    WHERE EXTRACT(YEAR FROM tweet_date) = 2022 -- A função EXTRACT(YEAR FROM tweet_date) extrai o ano da data do tweet
    GROUP BY user_id
) AS tweet_counts
GROUP BY tweet_count
ORDER BY tweet_count;