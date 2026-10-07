-- 1. Quanto o sistema faturou no total, em cada ano de venda?
SELECT
    YEAR(data_venda) AS ano,
    ROUND(SUM(v.preco_por_saca * v.qtd_vendida_sacas)) AS total
FROM venda AS v
GROUP BY YEAR(v.data_venda)
ORDER BY YEAR(v.data_venda) ASC;

-- 2. Quais são as 10 fazendas que mais faturaram?
SELECT
    f.nome_fazenda AS nome,
    ROUND(SUM(v.preco_por_saca * v.qtd_vendida_sacas), 2) AS faturamento
FROM fazenda AS f
INNER JOIN safra AS s
    ON s.id_fazenda = f.id_fazenda
INNER JOIN venda AS v
    ON v.id_safra = s.id_safra
GROUP BY nome
ORDER BY faturamento DESC
LIMIT 10;

-- 3. Qual cultura gera mais receita? E qual tem o maior preço médio por saca?
SELECT
    c.nome_cultura,
    ROUND(SUM(v.preco_por_saca * v.qtd_vendida_sacas), 2) AS faturamento,
    ROUND(AVG(v.preco_por_saca), 2) AS preco_medio 
FROM cultura AS c
INNER JOIN safra AS s
    ON c.id_cultura = s.id_cultura
INNER JOIN venda AS v
    ON v.id_safra = s.id_safra
GROUP BY nome_cultura
ORDER BY preco_medio DESC;

-- 4. Qual é a participação de cada estado na receita total, em %?
SELECT
    e.nome_estado,
    ROUND(
        SUM(v.preco_por_saca * v.qtd_vendida_sacas) / (
            SELECT SUM(v.preco_por_saca * v.qtd_vendida_sacas) FROM venda AS v
        ) * 100, 2
    ) AS percentual_venda
FROM venda AS v
INNER JOIN comprador AS c
    ON v.id_comprador = c.id_comprador
INNER JOIN cidade AS cid
    ON cid.id_cidade = c.id_cidade
INNER JOIN estado AS e
    ON e.id_estado = cid.id_estado
GROUP BY e.nome_estado
ORDER BY percentual_venda DESC;

-- 5. Quais fazendas nunca registraram uma safra?
SELECT
    f.nome_fazenda,
    s.id_cultura
FROM fazenda AS f
LEFT JOIN safra AS s
    ON f.id_fazenda = s.id_fazenda
WHERE s.id_safra IS NULL
ORDER BY f.nome_fazenda ASC;

-- 6. Quais compradores nunca compraram nada?
SELECT
    c.nome_comprador,
    c.tipo_empresa,
    v.id_venda
FROM comprador AS c
LEFT JOIN venda AS v
    ON c.id_comprador = v.id_comprador
WHERE v.id_comprador IS NULL
ORDER BY c.nome_comprador ASC;

-- 7. Quais safras foram colhidas mas ainda não tiveram nenhuma venda?
SELECT
    s.id_safra,
    s.id_fazenda,
    v.id_venda
FROM safra AS s
LEFT JOIN venda AS v
    ON s.id_safra = v.id_safra
WHERE v.id_venda IS NULL
ORDER BY s.id_safra ASC;

-- 8. Há estados sem nenhuma fazenda cadastrada?
SELECT
    e.id_estado,
    COUNT(f.id_fazenda) AS qtd_faz_por_estado
FROM estado AS e
LEFT JOIN cidade AS c
    ON e.id_estado = c.id_estado
LEFT JOIN fazenda AS f
    ON c.id_cidade = f.id_cidade
GROUP BY e.id_estado
HAVING qtd_faz_por_estado = 0;

-- 9. De cada safra, quantas sacas ainda não foram vendidas?
SELECT
    s.id_safra,
    c.nome_cultura,
    (MAX(s.qtd_colhida_sacas) - COALESCE(SUM(v.qtd_vendida_sacas), 0)) AS qtd_nao_vendidas
FROM safra AS s
LEFT JOIN venda AS v
    ON v.id_safra = s.id_safra
LEFT JOIN cultura AS c
    ON s.id_cultura = c.id_cultura
GROUP BY s.id_safra
ORDER BY qtd_nao_vendidas ASC;

-- 10. Quais safras já venderam mais de 70% do que colheram?
SELECT
    s.id_safra,
    c.nome_cultura,
    MAX(s.qtd_colhida_sacas) AS total_colhido,
    SUM(v.qtd_vendida_sacas) AS total_vendido,
    (SUM(v.qtd_vendida_sacas) * 100.0 / MAX(s.qtd_colhida_sacas)) AS percentual_vendido
FROM safra AS s
INNER JOIN venda AS v
    ON v.id_safra = s.id_safra
INNER JOIN cultura AS c
    ON s.id_cultura = c.id_cultura
GROUP BY s.id_safra
HAVING SUM(v.qtd_vendida_sacas) > (MAX(s.qtd_colhida_sacas) * 0.70)
ORDER BY percentual_vendido ASC;