CREATE TABLE `fazenda` (
  `id_fazenda` int PRIMARY KEY,
  `nome_fazenda` varchar(255) NOT NULL,
  `id_cidade` int NOT NULL
);

CREATE TABLE `cidade` (
  `id_cidade` int PRIMARY KEY,
  `nome_cidade` varchar(255) NOT NULL,
  `id_estado` int NOT NULL
);

CREATE TABLE `estado` (
  `id_estado` int PRIMARY KEY,
  `nome_estado` varchar(255) NOT NULL
);

CREATE TABLE `cultura` (
  `id_cultura` int PRIMARY KEY,
  `nome_cultura` varchar(255) NOT NULL
);

CREATE TABLE `safra` (
  `id_safra` int PRIMARY KEY,
  `id_fazenda` int NOT NULL,
  `id_cultura` int NOT NULL,
  `ano_safra` int NOT NULL,
  `qtd_colhida_sacas` decimal(12,2) NOT NULL
);

CREATE TABLE `comprador` (
  `id_comprador` int PRIMARY KEY,
  `nome_comprador` varchar(255) NOT NULL,
  `tipo_empresa` varchar(255) NOT NULL,
  `id_cidade` int NOT NULL
);

CREATE TABLE `venda` (
  `id_venda` int PRIMARY KEY,
  `id_safra` int NOT NULL,
  `id_comprador` int NOT NULL,
  `preco_por_saca` decimal(10,2) NOT NULL,
  `qtd_vendida_sacas` decimal(12,2) NOT NULL,
  `data_venda` date NOT NULL
);

ALTER TABLE `cidade` ADD FOREIGN KEY (`id_estado`) REFERENCES `estado` (`id_estado`);

ALTER TABLE `fazenda` ADD FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id_cidade`);

ALTER TABLE `safra` ADD FOREIGN KEY (`id_cultura`) REFERENCES `cultura` (`id_cultura`);

ALTER TABLE `comprador` ADD FOREIGN KEY (`id_cidade`) REFERENCES `cidade` (`id_cidade`);

ALTER TABLE `safra` ADD FOREIGN KEY (`id_fazenda`) REFERENCES `fazenda` (`id_fazenda`);

ALTER TABLE `venda` ADD FOREIGN KEY (`id_comprador`) REFERENCES `comprador` (`id_comprador`);

ALTER TABLE `venda` ADD FOREIGN KEY (`id_safra`) REFERENCES `safra` (`id_safra`);
