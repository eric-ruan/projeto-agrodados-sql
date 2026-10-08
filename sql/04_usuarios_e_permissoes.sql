USE agrodados;

-- Rodar como projeto
CREATE OR REPLACE VIEW vw_faturamento_fazenda AS
SELECT f.id_fazenda, f.nome_fazenda,
       ROUND(SUM(v.preco_por_saca * v.qtd_vendida_sacas), 2) AS faturamento
FROM fazenda AS f
INNER JOIN safra AS s ON s.id_fazenda = f.id_fazenda
INNER JOIN venda AS v ON v.id_safra = s.id_safra
GROUP BY f.id_fazenda, f.nome_fazenda;

-- Rodar como root trocando as senhas:
CREATE USER 'leitor'@'localhost' IDENTIFIED BY 'TROQUE_SENHA_LEITOR';
CREATE USER 'app_agro'@'localhost' IDENTIFIED BY 'TROQUE_SENHA_APP_AGRO';
GRANT SELECT ON agrodados.vw_faturamento_fazenda TO 'leitor'@'localhost';
GRANT SELECT, INSERT, UPDATE ON agrodados.* TO 'app_agro'@'localhost';
SHOW GRANTS FOR 'leitor'@'localhost';
SHOW GRANTS FOR 'app_agro'@'localhost';