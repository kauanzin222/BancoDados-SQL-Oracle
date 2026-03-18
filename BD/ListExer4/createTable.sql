
--- Tabela de Clientes  
CREATE TABLE TB_CLIENTE (
    CodCliente      NUMBER(5)       NOT NULL,
    NomeCliente     VARCHAR2(40)    NOT NULL,
    Endereco        VARCHAR2(30)    DEFAULT NULL,
    Cidade          VARCHAR2(20)    NOT NULL,
    CEP             VARCHAR2(10)    DEFAULT NULL,
    UF              CHAR(2)         NOT NULL,

    PRIMARY KEY (CodCliente)
);

--- Tabela de Produtos
CREATE TABLE TB_PRODUTO (
    CodProduto      number(5)       not NULL,
    Descricao       varchar2(20)    not NULL,
    Unidade         char(2)         not NULL,
    ValorUnitario   number(6,2)     not NULL,

    PRIMARY KEY (CodProduto)
);

--- Tabela de Vendedor
CREATE TABLE TB_VENDEDOR (
    CodVendedor     number(5)       not NULL,
    NomeVendedor    varchar2(30)    not NULL,
    FaixaComissao   number(4,2)     not NULL,
    SalarioFixo     number(7,2)     not NULL,

    PRIMARY KEY (CodVendedor)
);

--- Tabela de Pedidos
CREATE TABLE TB_PEDIDO (
    NumPedido       NUMBER(5)       NOT NULL, 
    PrazoEntrega    DATE            not NULL, 
    CodCliente      number(5)       not NULL,
    CodVendedor     number(5)       not null,

    PRIMARY KEY (CodVendedor),
    
    CONSTRAINT fk_pedido_cliente
    FOREIGN KEY (CodCliente) REFERENCES TB_CLIENTE,

    CONSTRAINT fk_pedido_vendedor
    FOREIGN KEY (CodVendedor) REFERENCES TB_VENDEDOR
);

CREATE TABLE TB_ITEMPEDIDO (
    NumPedido       number(5)       not NULL,
    CodProduto      number(5)       not NULL,
    Quantidade      number(3)       not NULL,

    PRIMARY KEY (NumPedido, CodProduto),

    CONSTRAINT fk_id_pedido
    FOREIGN KEY (NumPedido) REFERENCES TB_PEDIDO
);



