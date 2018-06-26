

create database locadora;


CREATE TABLE funcionario(
 	NSS 				BIGINT 			NOT NULL,
 	Nome 				VARCHAR(50) 	NOT NULL,
 	Data_Nascimento 	DATE 			NOT NULL,
 	Sexo 				CHAR(1),
 	Cidade 				VARCHAR(40),
 	Estado 				VARCHAR(40),
 	Pais 				VARCHAR(20),
 	CEP 				INT,
 	Bairro 				VARCHAR(40),
 	Logradouro 			VARCHAR(100),
 	Complemento 		VARCHAR(50),
 	Numero 				INT,
 	Salario 			REAL,
 	
 	CONSTRAINT pk_nss PRIMARY KEY (NSS),
    CONSTRAINT ck_sexo CHECK (Sexo='M' or Sexo='F')
);


CREATE TABLE gerente(
	NSS_Funcionario		BIGINT			NOT NULL,
	Inicio_Gerencia		DATE 			NOT NULL,
	Fim_Gerencia		DATE,

	CONSTRAINT pk_nssFunc PRIMARY KEY (NSS_Funcionario)
);

CREATE TABLE cliente(
	ID_Cliente			INT 			NOT NULL,
	Cidade 				VARCHAR(40),
 	Estado 				VARCHAR(40),
 	Pais 				VARCHAR(20),
 	CEP 				INT,
 	Bairro 				VARCHAR(40),
 	Logradouro 			VARCHAR(100),
 	Complemento 		VARCHAR(50),
 	Numero 				INT,

 	CONSTRAINT pk_idCliente PRIMARY KEY (ID_Cliente)
);


CREATE TABLE pessoa_fisica(
	CPF 				BIGINT 			NOT NULL,
	ID_Cliente			INT 			NOT NULL,
	Nome 				VARCHAR(50) 	NOT NULL,
    CNH					BIGINT			NOT NULL,
 	Data_Nascimento 	DATE 			NOT NULL,
 	Sexo 				CHAR(1),

 	CONSTRAINT pk_cpf PRIMARY KEY (CPF),
    CONSTRAINT ck_sexo CHECK (Sexo='M' or Sexo='F')
    
);


CREATE TABLE pessoa_juridica(
	CNPJ 				BIGINT 			NOT NULL,
	ID_Cliente			INT 			NOT NULL,
	Razao_Social 		VARCHAR(50) 	NOT NULL,
 	Responsavel 		VARCHAR(50)		NOT NULL,

 	CONSTRAINT pk_cnpj PRIMARY KEY (CNPJ)
);


CREATE TABLE locacao(
	Numero_NF			BIGINT			NOT NULL,
	Forma_Pagamento		INT		NOT NULL,
	Preco_Total			REAL	NOT NULL,
    NSS_Funcionario		BIGINT 			NOT NULL,
    ID_Cliente		INT 			NOT NULL,

	CONSTRAINT pk_nf PRIMARY KEY (Numero_NF)
);


CREATE TABLE veiculo(
	ID_Veiculo 			INT 			NOT NULL,
	Status 				INT 			NOT NULL, 
	Preco 				REAL			NOT NULL,
	Seguro				REAL,
	Numero_Passageiros	INT,
	Tipo_Combustivel 	VARCHAR(20), 
	Ano 				INT,
	Modelo 				VARCHAR(20),

	CONSTRAINT pk_idVeiculo PRIMARY KEY (ID_Veiculo)
);


CREATE TABLE carro(
	ID_Veiculo				INT 			NOT NULL,
	Capacidade_PortaMala	REAL,

	CONSTRAINT pk_idVeiculo PRIMARY KEY (ID_Veiculo)
);


CREATE TABLE onibus(
	ID_Veiculo				INT 			NOT NULL,
	Numero_Eixos			INT,

	CONSTRAINT pk_idVeiculo PRIMARY KEY (ID_Veiculo)
);


CREATE TABLE motocicleta(
	ID_Veiculo				INT 			NOT NULL,
	Cilindrada				INT				NOT NULL,

	CONSTRAINT pk_idVeiculo PRIMARY KEY (ID_Veiculo)
);


CREATE TABLE acessorio(
	ID_Acessorio			INT 			NOT NULL,
	Nome 					VARCHAR(20)		NOT NULL,
	Valor					REAL	NOT NULL,
    Descricao				VARCHAR(255),
	Tipo 					INT,
	Disponibilidade 		INT,

	CONSTRAINT pk_idAcessorio PRIMARY KEY (ID_Acessorio)
);


CREATE TABLE servico(
	ID_Servico				INT 			NOT NULL,
	Descricao				INT,
    Horas_Trabalhadas		TIME,
	Data 					DATE,
	ID_Veiculo				INT 			NOT NULL,

	CONSTRAINT pk_idServico PRIMARY KEY (ID_Servico)
);


CREATE TABLE realiza(
	NSS 				BIGINT 				NOT NULL,
	ID_Servico 			INT 				NOT NULL,

	CONSTRAINT pk_nss_idServico PRIMARY KEY (NSS, ID_Servico)
);


CREATE TABLE incluido(
	Numero_NF			BIGINT			NOT NULL,
	ID_Veiculo 			INT 			NOT NULL,
	Data_RealDevolucao	DATE,

	CONSTRAINT pk_nf_idVeiculo PRIMARY KEY(Numero_NF, ID_Veiculo)
);

CREATE TABLE administra(
	ID_Cliente 			INT 			NOT NULL,
	NSS_Funcionario		BIGINT 			NOT NULL,
	Data 				DATE,

	CONSTRAINT pk_idCliente_nss_data PRIMARY KEY (ID_Cliente, NSS_Funcionario, Data)
);

CREATE TABLE controla(
	ID_Acessorio		INT 		NOT NULL,
	NSS_Gerente		BIGINT		NOT NULL,
    
    CONSTRAINT pk_nss_idAcessorio PRIMARY KEY (NSS_Gerente,ID_Acessorio)
);

CREATE TABLE gerencia(
	NSS_Gerente		BIGINT		NOT NULL,
	ID_Veiculo			INT 		NOT NULL,

	CONSTRAINT pk_nss_idVeiculo PRIMARY KEY (NSS_Gerente, ID_Veiculo)
);


CREATE TABLE tel_funcionario(
	NSS_Funcionario		BIGINT		NOT NULL,
	Telefone 			BIGINT	 	NOT NULL,

	CONSTRAINT pk_nss_telefone PRIMARY KEY (NSS_Funcionario)
);


CREATE TABLE tel_cliente(
	ID_Cliente			INT 		NOT NULL,
	Telefone 			BIGINT		NOT NULL,

	CONSTRAINT pk_idCliente_telefone PRIMARY KEY (ID_Cliente, Telefone)
);

CREATE TABLE adicionado(
	Numero_NF			BIGINT			NOT NULL,
	ID_Acessorio			INT 			NOT NULL,
	    
    CONSTRAINT pk_idAcessorio_nf PRIMARY KEY (ID_Acessorio, Numero_NF)
);
/*Tabela necessária para o framework*/
CREATE TABLE `ci_session` (
  `id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `timestamp` int(10) NOT NULL,
  `data` blob NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


ALTER TABLE gerente
ADD CONSTRAINT gerente_nss FOREIGN KEY (NSS_Funcionario) 
REFERENCES funcionario(NSS) 
ON DELETE RESTRICT;

ALTER TABLE pessoa_fisica
ADD CONSTRAINT pessoafisica_id FOREIGN KEY (ID_Cliente) 
REFERENCES cliente(ID_Cliente) 
ON DELETE CASCADE;


ALTER TABLE pessoa_juridica
ADD CONSTRAINT pessoajuridica_id FOREIGN KEY (ID_Cliente) 
REFERENCES cliente(ID_Cliente) 
ON DELETE CASCADE;

ALTER TABLE locacao
ADD CONSTRAINT locacao_funcionario FOREIGN KEY (NSS_Funcionario) 
REFERENCES funcionario(NSS) 
ON DELETE RESTRICT;

ALTER TABLE locacao
ADD CONSTRAINT locacao_cliente FOREIGN KEY (ID_Cliente) 
REFERENCES cliente(ID_Cliente) 
ON DELETE RESTRICT;


ALTER TABLE carro
ADD CONSTRAINT veiculo_carro FOREIGN KEY (ID_Veiculo) 
REFERENCES veiculo(ID_Veiculo) 
ON DELETE CASCADE;


ALTER TABLE onibus
ADD CONSTRAINT onibus_motocicleta FOREIGN KEY (ID_Veiculo) 
REFERENCES veiculo(ID_Veiculo) 
ON DELETE CASCADE;



ALTER TABLE motocicleta
ADD CONSTRAINT veiculo_motocicleta FOREIGN KEY (ID_Veiculo) 
REFERENCES veiculo(ID_Veiculo) 
ON DELETE CASCADE;


ALTER TABLE servico
ADD CONSTRAINT servico_veiculo FOREIGN KEY (ID_Veiculo) 
REFERENCES veiculo(ID_Veiculo) 
ON DELETE RESTRICT;


ALTER TABLE realiza
ADD CONSTRAINT set_NSS FOREIGN KEY (NSS) 
REFERENCES funcionario(NSS) 
ON DELETE RESTRICT;


ALTER TABLE realiza
ADD CONSTRAINT set_Servico FOREIGN KEY (ID_Servico) 
REFERENCES servico(ID_Servico) 
ON DELETE RESTRICT;


ALTER TABLE incluido
ADD CONSTRAINT set_IDVeiculo FOREIGN KEY (ID_Veiculo) 
REFERENCES veiculo(ID_Veiculo) 
ON DELETE RESTRICT;


ALTER TABLE incluido
ADD CONSTRAINT set_nF FOREIGN KEY (Numero_NF) 
REFERENCES locacao(Numero_NF) 
ON DELETE RESTRICT;


ALTER TABLE administra
ADD CONSTRAINT set_clienteID FOREIGN KEY (ID_Cliente) 
REFERENCES cliente(ID_Cliente) 
ON DELETE CASCADE;


ALTER TABLE administra
ADD CONSTRAINT set_NSSFuncionario FOREIGN KEY (NSS_Funcionario) 
REFERENCES funcionario(NSS) 
ON DELETE RESTRICT;


ALTER TABLE controla
ADD CONSTRAINT set_IDAcessorio FOREIGN KEY (ID_Acessorio) 
REFERENCES acessorio(ID_Acessorio)
ON DELETE RESTRICT;

ALTER TABLE controla
ADD CONSTRAINT set_NSSGerente FOREIGN KEY (NSS_Gerente) 
REFERENCES gerente(NSS_Funcionario)
ON DELETE CASCADE;

ALTER TABLE gerencia
ADD CONSTRAINT set_Gerente_NSS FOREIGN KEY (NSS_Gerente) 
REFERENCES gerente(NSS_Funcionario)
ON DELETE RESTRICT;

ALTER TABLE gerencia
ADD CONSTRAINT set_Veiculo_ID FOREIGN KEY (ID_Veiculo) 
REFERENCES veiculo(ID_Veiculo)
ON DELETE CASCADE;


ALTER TABLE tel_funcionario
ADD CONSTRAINT set_tel_funcionario FOREIGN KEY (NSS_Funcionario) 
REFERENCES funcionario(NSS)
ON DELETE CASCADE;


ALTER TABLE tel_cliente
ADD CONSTRAINT set_IDCliente FOREIGN KEY (ID_Cliente) 
REFERENCES cliente(ID_Cliente)
ON DELETE CASCADE;

ALTER TABLE adicionado
ADD CONSTRAINT adicionado_NF FOREIGN KEY (Numero_NF) 
REFERENCES locacao(Numero_NF) 
ON DELETE RESTRICT;

ALTER TABLE adicionado
ADD CONSTRAINT adicionadoID_Acessorio FOREIGN KEY (ID_Acessorio) 
REFERENCES acessorio(ID_Acessorio) 
ON DELETE RESTRICT;

/*Início do povoamento do Banco de dados*/


INSERT INTO funcionario VALUES (593269912, 'Marc K Schell', '1982/10/26', 'M', 'Boynton Beach', 'Florida', 'United States', 33436, 'Florida', 'Kildeer Drive', ' ', 3123, 500.00);
INSERT INTO funcionario VALUES (063724752, 'Ruth J Mead', '1978/3/27', 'F', 'New York', 'New York', 'United States', 10013, 'New York', 'My Drive', ' ', 3949, 5000.0);
INSERT INTO funcionario VALUES (560450990, 'Lisa R Stowell', '1960/11/23',  'F', 'Los Angeles', 'California', 'United States', 90071, 'CA', 'Zimmerman Lane', ' ', 1949, 4000);
INSERT INTO funcionario VALUES (626345420, 'Pablo L Ginn', '1989/4/15', 'M', 'San Francisco', 'California', 'United States', 94102, 'CA', 'Longview Avenue', ' ', 732, 5000);
INSERT INTO funcionario VALUES (563725447, 'Lessie W Simpson', '1968/8/23', 'F', 'San Francisco', 'California', 'United States', 94102, 'CA', 'Felosa Drive', ' ', 989, 15000);
INSERT INTO funcionario VALUES (193704594, 'Gerald H Butler', '1989/7/10', 'M', 'Philadelphia', 'Pennsylvania', 'United States', 19131, 'PA', 'Glen Falls Road', ' ', 4760, 6000);



INSERT INTO gerente VALUES (193704594, '2013/02/15', '2010/02/15');
INSERT INTO gerente VALUES (563725447, '2016/02/15', NULL);



INSERT INTO cliente VALUES (44875, 'Pittsburgh', 'Pennsylvania', 'United States', 15222, 'PA', 'Shinn Avenue', ' ', '4972');
INSERT INTO cliente VALUES (86233, 'Delray Beach', 'Florida', 'United States', 33484, 'FL', 'Powder House Road', ' ', '507');
INSERT INTO cliente VALUES (30546, 'San Francisco', 'California', 'United States', 25624, 'CA', ' Jim Rosa Lane', ' ', '1753');


INSERT INTO pessoa_fisica VALUES (568058518, 86233, 'Mary A Jackson', 30942359810,'1990/7/21', 'F');
INSERT INTO pessoa_fisica VALUES (770303051, 44875, 'Kevin A Oleary', 02223023586, '1969/9/4', 'M');


INSERT INTO pessoa_juridica VALUES (992067986, 30546, 'J&C Associates', 'Marci S Connor');


INSERT INTO locacao values (215427478, 0, '100.20', 563725447, 44875);

/*status do veículo pode ser do tipo:
	0: disponível
	1: alugado
	2 em serviço, que pode ser de manutenção ou limpeza
*/

INSERT INTO veiculo VALUES (5359, 2, 60, 10, 5, 'flex', 2015, 'Fiat Uno');
INSERT INTO veiculo VALUES (8601, 0, 120, 20, 5, 'flex', 2017, 'Audi C3');
INSERT INTO veiculo VALUES (5691, 0, 40, 9, 2, 'gasolina', 2017, 'GSX-S750A');
INSERT INTO veiculo VALUES (5346, 0, 150, 80, 10, 'flex', 2016, 'Spin');


INSERT INTO carro VALUES (5359, 80.0);
INSERT INTO carro VALUES (8601, 80.0);

INSERT INTO motocicleta VALUES (5691, 250);

INSERT INTO onibus VALUES (5346, 1);


/* tipo
1 - capacete
2 - gps
3 - bebe conforto
4 - poltrona de elevação
5 - acento de elevação
6 - bagageiro */
INSERT INTO acessorio VALUES (46, 'capacete', 50, 'Capacete com proteção total contra impactos e espuma super confortável', 1, 0);
INSERT INTO acessorio VALUES (18, 'gps', 40, 'Gps de alta tecnologia com recursos de voz e salvar trajetos', 2, 0);
INSERT INTO acessorio VALUES (48, 'bebe conforto', 60, 'Cadeira confortável com tecido anti-alérgico para crianças de 0 a 2 anos', 3, 0);

/* 
descricao
1 - limpeza
2 - reparo
*/

INSERT INTO servico VALUES (3827, 1, '02:00:00', '2018/01/04', 5359);

INSERT INTO realiza VALUES (593269912, 3827);

INSERT INTO incluido VALUES (215427478, 8601, '2018/01/10');

INSERT INTO administra VALUES (44875, 063724752, '2018/01/10');

INSERT INTO controla VALUES (46, 563725447);

INSERT INTO gerencia VALUES (563725447, 5346);

INSERT INTO tel_funcionario VALUES (563725447, 5628224930);

INSERT INTO tel_cliente VALUES (44875, 7244815667);

INSERT INTO adicionado VALUES (215427478, 18);

