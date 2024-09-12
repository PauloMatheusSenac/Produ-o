CREATE DATABASE atividade;
USE atividade;
 
CREATE TABLE estado (
    id_estado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_estado VARCHAR(100) NOT NULL UNIQUE,
    sigla_estado CHAR(2) NOT NULL UNIQUE
);
 
CREATE TABLE cidade (
    id_cidade INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_cidade VARCHAR(100) NOT NULL,
    id_estado INT NOT NULL,
    FOREIGN KEY (id_estado) REFERENCES estado(id_estado)
);
 
 
CREATE TABLE tributacao (
    id_tributacao INT NOT NULL PRIMARY KEY,
    nome_tributacao VARCHAR(255) NOT NULL
);
 
CREATE TABLE icms (
    id_situacao_icms INT NOT NULL PRIMARY KEY,
    nome_situacao_icms VARCHAR(255) NOT NULL
);
 
CREATE TABLE sexo (
    id_sexo INT NOT NULL PRIMARY KEY,
    nome_sexo VARCHAR(255) NOT NULL
);
 
CREATE TABLE tabela_preco (
    id_tabela_preco INT NOT NULL PRIMARY KEY,
    nome_tabela_preco VARCHAR(255) NOT NULL
);
 
CREATE TABLE modo_de_frete (
    id_mod_frete_padrao INT NOT NULL PRIMARY KEY,
    nome_modo_de_frete VARCHAR(255) NOT NULL
);
 
CREATE TABLE situacao_cadastro (
    id_sit_cadastro INT NOT NULL PRIMARY KEY,
    nome_sit_cadastro VARCHAR(255) NOT NULL
);
 
 
CREATE TABLE usuarios (
    id_user INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50) NOT NULL,
    senha VARCHAR(255) NOT NULL
);
 
 
CREATE TABLE cadastro (
    id_cadastro INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    caminho_foto VARCHAR(255),
    regime_de_tributacao INT,
    nome VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    email_danfe VARCHAR(255) NOT NULL,
    email_cobranca VARCHAR(255) NOT NULL,
    email_loja VARCHAR(255) NOT NULL,
    telefone_com VARCHAR(20) NOT NULL,
    ramal VARCHAR(20),
    telefone_res VARCHAR(20) NOT NULL,
    telefone_cel VARCHAR(20) NOT NULL,
    fax VARCHAR(20) NOT NULL,
    cpf VARCHAR(14) NOT NULL,
    rg VARCHAR(20) NOT NULL,
    indicou VARCHAR(50),
    id_cidade INT,
    situacao_icms INT,
    insc_estadual INT,
    insc_suframa INT,
    sexo INT NOT NULL,
    data_nasc DATE NOT NULL,
    transportadora1 VARCHAR(50),
    transportadora2 VARCHAR(50),
    tabela_preco INT,
    mod_frete_padrao INT,
    sit_cadastro INT,
    linha_do_pef VARCHAR(255),
    aliquota DECIMAL(5, 2),
    FOREIGN KEY (regime_de_tributacao) REFERENCES tributacao(id_tributacao),
    FOREIGN KEY (situacao_icms) REFERENCES icms(id_situacao_icms),
    FOREIGN KEY (sexo) REFERENCES sexo(id_sexo),
    FOREIGN KEY (tabela_preco) REFERENCES tabela_preco(id_tabela_preco),
    FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade),
    FOREIGN KEY (mod_frete_padrao) REFERENCES modo_de_frete(id_mod_frete_padrao),
    FOREIGN KEY (sit_cadastro) REFERENCES situacao_cadastro(id_sit_cadastro)
);
 
 
CREATE TABLE enderecos (
    id_endereco INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT,
    endereco VARCHAR(255) NOT NULL,
    cidade VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    cep VARCHAR(10) NOT NULL,
    id_cidade INT,
    pais VARCHAR(50) NOT NULL,
    tipo_endereco ENUM('Residencial', 'Comercial', 'Entrega', 'Cobrança') NOT NULL,
    FOREIGN KEY (id_cidade) REFERENCES cidade(id_cidade),
    FOREIGN KEY (id_cliente) REFERENCES cadastro(id_cadastro)
);
 
CREATE TABLE perfil (
    id_perfil INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    nome_perfil VARCHAR(255) NOT NULL,
    descricao TEXT,
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    ativo BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (id_user) REFERENCES usuarios(id_user)
);
 
CREATE TABLE dados_adicionais (
    id_dado INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    tipo_dado VARCHAR(50) NOT NULL,
    valor TEXT NOT NULL,
    descricao VARCHAR(255),
    data_adicao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_cliente) REFERENCES cadastro(id_cadastro)
);
 
CREATE TABLE cliente_relacionado (
    id_relacionamento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente1 INT NOT NULL,
    id_cliente2 INT NOT NULL,
    quem_indicou VARCHAR(255),
    tipo_relacionamento ENUM('Parceiro', 'Referência', 'Fornecedor', 'Cliente') NOT NULL,
    data_inicio DATE,
    FOREIGN KEY (id_cliente1) REFERENCES cadastro(id_cadastro),
    FOREIGN KEY (id_cliente2) REFERENCES cadastro(id_cadastro)
);
 
CREATE TABLE contatos (
    id_contato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    nome_contato VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(255),
    cargo VARCHAR(100),
    tipo_contato ENUM('Principal', 'Secundário') NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cadastro(id_cadastro)
);
 
CREATE TABLE vendedores (
    id_vendedor INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    nome_vendedor VARCHAR(255) NOT NULL,
    telefone VARCHAR(20),
    email VARCHAR(255),
    area_de_vendas VARCHAR(100),
    data_contratacao DATE,
    ativo BOOLEAN DEFAULT TRUE
);
 
CREATE TABLE comunicacao (
    id_comunicacao INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_vendedor INT NOT NULL,
    tipo_comunicacao ENUM('Email', 'Telefone', 'Reunião', 'Outro') NOT NULL,
    data_comunicacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    assunto VARCHAR(255),
    mensagem TEXT,
    FOREIGN KEY (id_cliente) REFERENCES cadastro(id_cadastro),
    FOREIGN KEY (id_vendedor) REFERENCES vendedores(id_vendedor)
);
 
CREATE TABLE financeiro (
    id_atividade INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_user INT NOT NULL,
    data_atividade TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    pagamentos_aceitos VARCHAR(50),
    descricao VARCHAR(255),
    FOREIGN KEY (id_user) REFERENCES usuarios(id_user)
);
 
CREATE TABLE extras (
    id_hist INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    id_cadastro INT NOT NULL,
    nome VARCHAR(255),
    email VARCHAR(255),
    data_modificacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    acao VARCHAR(50) NOT NULL,
    FOREIGN KEY (id_cadastro) REFERENCES cadastro(id_cadastro)
);
 
 
CREATE TABLE os (
    id_documento INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    emissao DATE,
    cliente INT,
    previsao DATE,
    descricao TEXT,
    execucao DATE,
    servico VARCHAR(255),
    variante VARCHAR(50),
    quantidade DECIMAL(10, 2),
    valor DECIMAL(10, 2),
    FOREIGN KEY (cliente) REFERENCES cadastro(id_cadastro)
);
 
 
CREATE TABLE pecas (
    codigo INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    descricao VARCHAR(255),
    variante VARCHAR(50),
    ps VARCHAR(50),
    qtd_base DECIMAL(10, 2),
    qtd DECIMAL(10, 2),
    um VARCHAR(50),
    custo_unitario DECIMAL(10, 2),
    qt_fixa_variavel ENUM('Fixa', 'Variável'),
    ordem INT,
    ci VARCHAR(50),
    origem VARCHAR(50),
    status_peca ENUM('Ativo', 'Inativo') NOT NULL
);
 
 
CREATE TABLE vendas (
    id_venda INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sequencia INT,
    emissao DATE,
    vencimento DATE,
    previsao_de_faturamento DATE,
    aprovacao_cliente DATE,
    hora_aprovacao TIMESTAMP,
    embarques INT,
    prazo_entrega DATE,
    n_pedido_de_compra VARCHAR(50),
    vendedor INT,
    historico TEXT,
    faturamentos TEXT,
    cliente INT,
    end_entrega INT,
    tabela_de_preco INT,
    transportadora1 INT,
    transportadora2 INT,
    tipo_frete VARCHAR(50),
    valor_de_frete DECIMAL(10, 2),
    valor_desconto_rateado DECIMAL(10, 2),
    contato INT,
    FOREIGN KEY (vendedor) REFERENCES vendedores(id_vendedor),
    FOREIGN KEY (cliente) REFERENCES cadastro(id_cadastro),
    FOREIGN KEY (end_entrega) REFERENCES enderecos(id_endereco),
    FOREIGN KEY (tabela_de_preco) REFERENCES tabela_preco(id_tabela_preco),
    FOREIGN KEY (transportadora1) REFERENCES cadastro(id_cadastro),
    FOREIGN KEY (transportadora2) REFERENCES cadastro(id_cadastro),
    FOREIGN KEY (contato) REFERENCES contatos(id_contato)
);
 