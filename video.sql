-- DBA - CP2 - Video Locadora
set serveroutput on
set verify off

/*
DROP TABLE ALUGUEL CASCADE CONSTRAINTS;
DROP TABLE CLIENTE CASCADE CONSTRAINTS;
DROP TABLE FILME CASCADE CONSTRAINTS;
DROP TABLE EMPREGADO CASCADE CONSTRAINTS;
DROP TABLE LOJA CASCADE CONSTRAINTS;
DROP SEQUENCE aluguel_seq;
DROP PACKAGE PacoteAluguel;
DROP PROCEDURE InserirAluguel;
DROP FUNCTION VerificarEstoqueFilme;
DROP FUNCTION VerificarDados;
DROP FUNCTION CalcularTotalAluguel;
*/

-- 1-Criar todas as tabelas existentes no modelo (nao alterar os nomes nem sua estrutura, obedeca a documentacao), a estrutura com tipos de dados, tabelas e regras que nao estejam na documentacao, sao opcionais, ou seja colocar not null em algumas colunas fica a criterio do grupo.
CREATE TABLE LOJA (
    numLoja NUMBER(4) PRIMARY KEY,
    Endereco VARCHAR2(40),
    Nome VARCHAR2(25) NOT NULL
);

CREATE TABLE EMPREGADO (
    empregadoId NUMBER(3) PRIMARY KEY,
    Nome VARCHAR2(25),
    Loja NUMBER(4) REFERENCES LOJA(numLoja),
    Salario NUMBER(5,2)
);

CREATE TABLE FILME (
    videoId NUMBER(5) PRIMARY KEY,
    qtdEstoque NUMBER(3),
    Titulo VARCHAR2(30),
    Custo NUMBER(3,2),
    Categoria VARCHAR2(25),
    precoAluguel NUMBER(3,2)
);

CREATE TABLE CLIENTE (
    numCliente NUMBER(4) PRIMARY KEY,
    Nome VARCHAR2(20) NOT NULL,
    Endereco VARCHAR2(30)
);

CREATE TABLE ALUGUEL (
    numDaOperacaoAluga NUMBER(6) PRIMARY KEY,
    numCliente NUMBER(4) REFERENCES CLIENTE(numCliente),
    videoId NUMBER(5) REFERENCES FILME(videoId),
    empregadoId NUMBER(3) REFERENCES EMPREGADO(empregadoId),
    dataSaida DATE,
    dataRetorno DATE,
    total_aluguel NUMBER(6,2)
);
-- pk tabela ALUGUEL
CREATE SEQUENCE aluguel_seq
  START WITH 1
  INCREMENT BY 1
  NOCACHE
  NOCYCLE;


-- 2-Alimentar as tabelas compelo menos 8linhas de dados. Nao alimentar a tabela alugueisneste momento.
-- tabela LOJA
INSERT ALL
INTO LOJA (numLoja, Endereco, Nome) VALUES (1, 'Rua A', 'Loja Flor')
INTO LOJA (numLoja, Endereco, Nome) VALUES (2, 'Avenida B', 'Loja Rosa')
INTO LOJA (numLoja, Endereco, Nome) VALUES (3, 'Rua C', 'Loja Azul')
INTO LOJA (numLoja, Endereco, Nome) VALUES (4, 'Avenida D', 'Loja Verde')
INTO LOJA (numLoja, Endereco, Nome) VALUES (5, 'Rua E', 'Loja Vermelha')
INTO LOJA (numLoja, Endereco, Nome) VALUES (6, 'Avenida F', 'Loja Amarela')
INTO LOJA (numLoja, Endereco, Nome) VALUES (7, 'Rua G', 'Loja Marrom')
INTO LOJA (numLoja, Endereco, Nome) VALUES (8, 'Avenida H', 'Loja Branca')
SELECT * FROM DUAL;

-- tabela EMPREGADO
INSERT ALL
INTO EMPREGADO (empregadoId, Nome, Loja, Salario) VALUES (1, 'Joao Silva', 1, 250.00)
INTO EMPREGADO (empregadoId, Nome, Loja, Salario) VALUES (2, 'Maria Santos', 1, 220.50)
INTO EMPREGADO (empregadoId, Nome, Loja, Salario) VALUES (3, 'Pedro Oliveira', 2, 280.75)
INTO EMPREGADO (empregadoId, Nome, Loja, Salario) VALUES (4, 'Ana Rodrigues', 2, 230.25)
INTO EMPREGADO (empregadoId, Nome, Loja, Salario) VALUES (5, 'Carlos Pereira', 3, 260.80)
INTO EMPREGADO (empregadoId, Nome, Loja, Salario) VALUES (6, 'Sofia Almeida', 3, 240.30)
INTO EMPREGADO (empregadoId, Nome, Loja, Salario) VALUES (7, 'Jose Ferreira', 4, 300.00)
INTO EMPREGADO (empregadoId, Nome, Loja, Salario) VALUES (8, 'Camila Souza', 4, 270.40)
SELECT * FROM DUAL;

-- tabela FILME
INSERT ALL
INTO FILME (videoId, qtdEstoque, Titulo, Custo, Categoria, precoAluguel) VALUES (1, 10, 'Vingadores: Ultimato', 5.99, 'Acao', 2.50)
INTO FILME (videoId, qtdEstoque, Titulo, Custo, Categoria, precoAluguel) VALUES (2, 8, 'Toy Story 4', 6.99, 'Animacao', 3.00)
INTO FILME (videoId, qtdEstoque, Titulo, Custo, Categoria, precoAluguel) VALUES (3, 15, 'O Poderoso Chefao', 4.99, 'Drama', 2.25)
INTO FILME (videoId, qtdEstoque, Titulo, Custo, Categoria, precoAluguel) VALUES (4, 12, 'Indiana Jones', 7.99, 'Aventura', 3.50)
INTO FILME (videoId, qtdEstoque, Titulo, Custo, Categoria, precoAluguel) VALUES (5, 7, 'Blade Runner', 5.49, 'Ficcao Cientifica', 2.75)
INTO FILME (videoId, qtdEstoque, Titulo, Custo, Categoria, precoAluguel) VALUES (6, 9, 'Superbad', 6.49, 'Comedia', 2.75)
INTO FILME (videoId, qtdEstoque, Titulo, Custo, Categoria, precoAluguel) VALUES (7, 11, 'Titanic', 6.99, 'Romance', 2.50)
INTO FILME (videoId, qtdEstoque, Titulo, Custo, Categoria, precoAluguel) VALUES (8, 14, 'Matrix', 7.49, 'Acao', 3.25)
SELECT * FROM DUAL;

-- tabela CLIENTE
INSERT ALL
INTO CLIENTE (numCliente, Nome, Endereco) VALUES (1, 'Fernanda Silva', 'Rua Sao Joao, 123')
INTO CLIENTE (numCliente, Nome, Endereco) VALUES (2, 'Pedro Santos', 'Avenida Felipe Sequeira, 456')
INTO CLIENTE (numCliente, Nome, Endereco) VALUES (3, 'Maria Oliveira', 'Rua Gabriel Omar, 789')
INTO CLIENTE (numCliente, Nome, Endereco) VALUES (4, 'Jose Rodrigues', 'Avenida Ana Ira, 1011')
INTO CLIENTE (numCliente, Nome, Endereco) VALUES (5, 'Carla Pereira', 'Rua Guilherme Maelby, 1213')
INTO CLIENTE (numCliente, Nome, Endereco) VALUES (6, 'Fernando Almeida', 'Avenida Luiz Rodrigues, 1415')
INTO CLIENTE (numCliente, Nome, Endereco) VALUES (7, 'Isabela Ferreira', 'Rua Marcel, 1617')
INTO CLIENTE (numCliente, Nome, Endereco) VALUES (8, 'Rafael Souza', 'Avenida Tome, 1819')
SELECT * FROM DUAL;


-- 5-Criar um os mais pacotes com as funcoes e procedimentos existentes neste exercicio.    
CREATE OR REPLACE PACKAGE PacoteAluguel AS
    
    FUNCTION VerificarEstoqueFilme (p_videoId IN NUMBER) RETURN NUMBER;
    
    FUNCTION CalcularTotalAluguel (p_videoId IN NUMBER, p_dataSaida IN DATE, p_dataRetorno IN DATE) RETURN NUMBER;

END PacoteAluguel;
/

CREATE OR REPLACE PACKAGE BODY PacoteAluguel AS
    
    FUNCTION VerificarEstoqueFilme(p_videoId IN NUMBER) RETURN NUMBER AS
        v_qtdAlugar NUMBER := 1;
        v_qtdNova FILME.qtdEstoque%TYPE;
        v_qtdAtual FILME.qtdEstoque%TYPE;
    BEGIN
        SELECT qtdEstoque INTO v_qtdAtual FROM FILME WHERE videoId = p_videoId;
        IF v_qtdAlugar <= v_qtdAtual THEN
            v_qtdNova := v_qtdAtual - v_qtdAlugar;
            UPDATE FILME SET qtdEstoque = v_qtdNova WHERE  videoId = p_videoId;
        END IF;
        
        RETURN v_qtdAtual;
    END VerificarEstoqueFilme;  
        
    FUNCTION CalcularTotalAluguel(p_videoId IN NUMBER, p_dataSaida IN DATE, p_dataRetorno IN DATE) RETURN NUMBER AS
        v_precoAluguel NUMBER;
        v_totalDias NUMBER;
        v_totalAluguel NUMBER;
    BEGIN
        SELECT precoAluguel INTO v_precoAluguel FROM FILME WHERE videoId = p_videoId;
        v_totalDias := p_dataRetorno - p_dataSaida;
        v_totalAluguel := v_precoAluguel * v_totalDias;
        RETURN v_totalAluguel;
    END CalcularTotalAluguel;

END PacoteAluguel;
/


-- Procedimento para inserir dados na tabela ALUGUEL
CREATE OR REPLACE PROCEDURE InserirAluguel (
    p_numCliente IN NUMBER,
    p_videoId IN NUMBER,
    p_empregadoId IN NUMBER,
    p_dataSaida IN DATE,
    p_dataRetorno IN DATE)
    AS
    v_aluguelTotal NUMBER;
    v_numDaOperacaoAluga NUMBER;
    v_quantidadeFilmeEstoque NUMBER;
    v_videoId INT;
    v_numCliente INT;
    v_empregadoId INT;
    NO_QUANTITY_FILME EXCEPTION;
BEGIN    
    -- Verifica se o cliente, empregado e filme existem antes de inserir um aluguel
    SELECT numCliente INTO v_numCliente FROM CLIENTE WHERE numCliente = p_numCliente;
    SELECT empregadoId INTO v_empregadoId FROM EMPREGADO WHERE empregadoId = p_empregadoId;
    SELECT videoId INTO v_videoId FROM FILME WHERE videoId = p_videoId;
    
    v_quantidadeFilmeEstoque := PacoteAluguel.VerificarEstoqueFilme(p_videoId);
    IF v_quantidadeFilmeEstoque <= 0 THEN
        RAISE NO_QUANTITY_FILME;
    END IF;

    v_aluguelTotal := PacoteAluguel.CalcularTotalAluguel(p_videoId, p_dataSaida, p_dataRetorno); 
    
    v_numDaOperacaoAluga := aluguel_seq.NEXTVAL;  
        
    -- Verifica se o cliente, empregado e filme existem
    IF v_numCliente IS NOT NULL AND v_empregadoId IS NOT NULL AND v_videoId IS NOT NULL THEN
        -- Insere o aluguel na tabela Aluguel
        INSERT INTO ALUGUEL (numDaOperacaoAluga, numCliente, videoId, empregadoId, dataSaida, dataRetorno, total_aluguel)
        VALUES (v_numDaOperacaoAluga, v_numCliente, v_videoId, v_empregadoId, p_dataSaida, p_dataRetorno, v_aluguelTotal);

        DBMS_OUTPUT.PUT_LINE('Aluguel inserido com sucesso!');
    END IF;
EXCEPTION
    WHEN NO_QUANTITY_FILME THEN
        DBMS_OUTPUT.PUT_LINE('Estoque insuficiente para esse aluguel!');
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Cliente, empregado ou filme não encontrado. Verifique os dados.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Ocorreu um erro durante a operação.');
COMMIT;
END InserirAluguel;
/

DECLARE
    v_numCliente NUMBER := 10;            
    v_videoId NUMBER := 1;               
    v_empregadoId NUMBER := 1;           
    v_dataSaida DATE := TO_DATE('2023-10-16', 'YYYY-MM-DD');
    v_dataRetorno DATE := TO_DATE('2023-10-20', 'YYYY-MM-DD');
BEGIN
    InserirAluguel (
        v_numCliente,
        v_videoId,
        v_empregadoId,
        v_dataSaida,
        v_dataRetorno
    );
END;
/