CREATE DATABASE agrodados
CHARACTER SET utf8mb4
COLLATE utf8mb4_0900_ai_ci;

USE agrodados;

CREATE TABLE cultura (
    id_cultura INT AUTO_INCREMENT,
    nome_cultura VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_cultura),
    CONSTRAINT uq_cultura UNIQUE (nome_cultura)
);

CREATE TABLE estado (
    id_estado INT AUTO_INCREMENT,
    nome_estado VARCHAR(255) NOT NULL,
    PRIMARY KEY (id_estado),
    CONSTRAINT uq_estado UNIQUE (nome_estado)
);

CREATE TABLE cidade (
    id_cidade INT AUTO_INCREMENT,
    nome_cidade VARCHAR(255) NOT NULL,
    id_estado INT NOT NULL,
    PRIMARY KEY(id_cidade),
    CONSTRAINT fk_cidade_estado FOREIGN KEY(id_estado) REFERENCES estado(id_estado)
);

CREATE TABLE fazenda (
    id_fazenda INT AUTO_INCREMENT,
    nome_fazenda VARCHAR(255) NOT NULL,
    id_cidade INT NOT NULL,
    PRIMARY KEY (id_fazenda),
    CONSTRAINT fk_fazenda_cidade FOREIGN KEY(id_cidade) REFERENCES cidade(id_cidade)
);

CREATE TABLE safra (
    id_safra INT AUTO_INCREMENT,
    id_fazenda INT NOT NULL,
    id_cultura INT NOT NULL,
    ano_safra INT NOT NULL,
    qtd_colhida_sacas DECIMAL(12,2) NOT NULL,
    PRIMARY KEY (id_safra),
    CONSTRAINT fk_safra_fazenda FOREIGN KEY (id_fazenda) REFERENCES fazenda(id_fazenda),
    CONSTRAINT fk_safra_cultura FOREIGN KEY (id_cultura) REFERENCES cultura(id_cultura),
    CONSTRAINT uq_safra UNIQUE(id_fazenda, id_cultura, ano_safra),
    CONSTRAINT chk_safra_qtd CHECK (qtd_colhida_sacas > 0),
    CONSTRAINT chk_safra_ano CHECK (ano_safra BETWEEN 2000 AND 2100)
);

CREATE TABLE comprador (
    id_comprador INT AUTO_INCREMENT,
    nome_comprador VARCHAR(255) NOT NULL,
    tipo_empresa VARCHAR(255) NOT NULL,
    id_cidade INT NOT NULL,
    PRIMARY KEY (id_comprador),
    CONSTRAINT fk_comprador_cidade FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade)
);

CREATE TABLE venda (
    id_venda INT AUTO_INCREMENT,
    id_safra INT NOT NULL,
    id_comprador INT NOT NULL,
    preco_por_saca DECIMAL(10,2) NOT NULL,
    qtd_vendida_sacas DECIMAL(12,2) NOT NULL,
    data_venda DATE NOT NULL,
    PRIMARY KEY (id_venda),
    CONSTRAINT fk_venda_safra FOREIGN KEY (id_safra) REFERENCES safra(id_safra),
    CONSTRAINT fk_venda_comprador FOREIGN KEY (id_comprador) REFERENCES comprador(id_comprador),
    CONSTRAINT chk_venda_preco CHECK (preco_por_saca > 0),
    CONSTRAINT chk_venda_qtd CHECK (qtd_vendida_sacas > 0)
);