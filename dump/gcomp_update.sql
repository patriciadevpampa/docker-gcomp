-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema servidorgerencia_gcomp
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema servidorgerencia_gcomp
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `servidorgerencia_gcomp` DEFAULT CHARACTER SET latin1 ;
USE `servidorgerencia_gcomp` ;

-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`categoriaAnuncio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`categoriaAnuncio` (
  `idcategoriaAnuncio` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeCategoria` VARCHAR(45) NULL DEFAULT NULL,
  `imagemCategoria` VARCHAR(45) NULL DEFAULT NULL,
  `nomeIcone` VARCHAR(45) NULL DEFAULT NULL,
  `tipoIcone` VARCHAR(45) NULL DEFAULT NULL,
  `corCategoria` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idcategoriaAnuncio`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`anuncio`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`anuncio` (
  `idanuncio` INT(11) NOT NULL AUTO_INCREMENT,
  `tipoAnuncio` INT(11) NULL DEFAULT NULL,
  `imagem` VARCHAR(100) NULL DEFAULT NULL,
  `status` INT(11) NULL DEFAULT NULL,
  `linkExterno` VARCHAR(500) NULL DEFAULT NULL,
  `nomeEmpresa` VARCHAR(300) NULL DEFAULT NULL,
  `descricao` VARCHAR(1000) NULL DEFAULT NULL,
  `telefone` VARCHAR(45) NULL DEFAULT NULL,
  `endereco` VARCHAR(200) NULL DEFAULT NULL,
  `linkMapa` VARCHAR(200) NULL DEFAULT NULL,
  `linkFacebook` VARCHAR(100) NULL DEFAULT NULL,
  `linkInstagram` VARCHAR(100) NULL DEFAULT NULL,
  `logoTipo` VARCHAR(45) NULL DEFAULT NULL,
  `horarioFuncionamento` VARCHAR(500) NULL DEFAULT NULL,
  `formaEntrega` VARCHAR(500) NULL DEFAULT NULL,
  `statusPromocao` INT(11) NULL DEFAULT NULL,
  `descricaoPromocao` VARCHAR(500) NULL DEFAULT NULL,
  `linkWebView` VARCHAR(200) NULL DEFAULT NULL,
  `categoriaAnuncio_idcategoriaAnuncio` INT(11) NOT NULL,
  `linkWhatsapp` VARCHAR(100) NULL DEFAULT NULL,
  `produtos` VARCHAR(1000) NULL DEFAULT NULL,
  PRIMARY KEY (`idanuncio`),
  INDEX `fk_anuncio_categoriaAnuncio1_idx` (`categoriaAnuncio_idcategoriaAnuncio` ASC),
  CONSTRAINT `fk_anuncio_categoriaAnuncio1`
    FOREIGN KEY (`categoriaAnuncio_idcategoriaAnuncio`)
    REFERENCES `servidorgerencia_gcomp`.`categoriaAnuncio` (`idcategoriaAnuncio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 68
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`competicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`competicao` (
  `idcompeticao` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `logotipo` VARCHAR(200) NULL DEFAULT NULL,
  `background` VARCHAR(200) NULL DEFAULT NULL,
  `cores` VARCHAR(200) NULL DEFAULT NULL,
  `username` VARCHAR(200) NULL DEFAULT NULL,
  `status` INT(11) NULL DEFAULT NULL,
  `restrito` TINYINT(4) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idcompeticao`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`faseJogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`faseJogo` (
  `idfaseJogo` INT(11) NOT NULL AUTO_INCREMENT,
  `textoFase` VARCHAR(100) NULL DEFAULT NULL,
  `codigoFase` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idfaseJogo`))
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`configuracao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`configuracao` (
  `idconfiguracao` INT(11) NOT NULL AUTO_INCREMENT,
  `dataLimiteIncluirJogador` TIMESTAMP NULL DEFAULT NULL,
  `dataLimiteEditarJogador` TIMESTAMP NULL DEFAULT NULL,
  `dataLimiteRemoverJogador` TIMESTAMP NULL DEFAULT NULL,
  `dataLimiteIncluirComissao` TIMESTAMP NULL DEFAULT NULL,
  `dataLimiteEditarComissao` TIMESTAMP NULL DEFAULT NULL,
  `dataLimiteRemoverComissao` TIMESTAMP NULL DEFAULT NULL,
  `dataLiberacaoFichaApp` TIMESTAMP NULL DEFAULT NULL,
  `grupoUnico` INT(2) NULL DEFAULT 1,
  `quantidadeClassificados` INT(11) NULL DEFAULT 4,
  `tabelaGeral` INT(2) NULL DEFAULT 1,
  `tabelaGrupos` INT(2) NULL DEFAULT 0,
  `quantidadeGrupos` INT(11) NULL DEFAULT NULL,
  `faseZerarCartao` INT(11) NOT NULL DEFAULT 3,
  `minutagem` INT(11) NULL DEFAULT 0,
  `lances` INT(11) NULL DEFAULT 1,
  `noticia` INT(11) NULL DEFAULT 0,
  `quantidadeCartoesAmarelos` INT(11) NULL DEFAULT 3,
  `moduloEscalarEquipe` INT(11) NULL DEFAULT 0,
  `horasParaEscalar` INT(11) NULL DEFAULT 72,
  PRIMARY KEY (`idconfiguracao`),
  INDEX `fk_configuracao_faseJogo1_idx` (`faseZerarCartao` ASC),
  CONSTRAINT `fk_configuracao_faseJogo1`
    FOREIGN KEY (`faseZerarCartao`)
    REFERENCES `servidorgerencia_gcomp`.`faseJogo` (`idfaseJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 241
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`configuracaoCadastro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`configuracaoCadastro` (
  `idconfiguracaoCadastro` INT(11) NOT NULL AUTO_INCREMENT,
  `limiteJogadores` INT(11) NULL DEFAULT NULL,
  `limiteComissaoTecnica` INT(11) NULL DEFAULT NULL,
  `numeracaoJogadoresFixa` INT(11) NULL DEFAULT NULL,
  `atestadoMedicoJogador` INT(11) NULL DEFAULT 0,
  `historicoJogador` INT(11) NULL DEFAULT 0,
  `atestadoMedicoTime` INT(11) NULL DEFAULT 0,
  `campoCpf` INT(11) NULL DEFAULT 0,
  `campoRG` INT(11) NULL DEFAULT 0,
  `comprovanteVacinaJogador` INT(11) NULL DEFAULT 0,
  `comprovanteRG` INT(11) NULL DEFAULT 0,
  `comprovanteCPF` INT(11) NULL DEFAULT 0,
  PRIMARY KEY (`idconfiguracaoCadastro`))
ENGINE = InnoDB
AUTO_INCREMENT = 250
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`criterios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`criterios` (
  `idcriterios` INT(11) NOT NULL AUTO_INCREMENT,
  `saldoGol` INT(11) NULL DEFAULT NULL,
  `vitorias` INT(11) NULL DEFAULT NULL,
  `golsPro` INT(11) NULL DEFAULT NULL,
  `golsContra` INT(11) NULL DEFAULT NULL,
  `cartoesVermelhos` INT(11) NULL DEFAULT NULL,
  `cartoesAmarelos` INT(11) NULL DEFAULT NULL,
  `confrontoDireto` INT(11) NULL DEFAULT NULL,
  `tipoCriterio` INT(11) NOT NULL,
  PRIMARY KEY (`idcriterios`))
ENGINE = InnoDB
AUTO_INCREMENT = 233
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`categoria` (
  `idcategoria` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` VARCHAR(1000) NULL DEFAULT NULL,
  `competicao_idcompeticao` INT(11) NOT NULL,
  `logotipo` VARCHAR(45) NULL DEFAULT NULL,
  `configuracao_idconfiguracao` INT(11) NOT NULL DEFAULT 1,
  `configuracaoCadastro_idconfiguracaoCadastro` INT(11) NOT NULL DEFAULT 1,
  `criterios_idcriterios` INT(11) NULL DEFAULT NULL,
  `prioridade` INT(11) NULL DEFAULT 1,
  `status` VARCHAR(45) NULL DEFAULT 'Encerrado',
  `ano` VARCHAR(45) NULL DEFAULT NULL,
  `aceiteTermo` VARCHAR(200) NULL DEFAULT NULL,
  `regulamento` VARCHAR(400) NULL DEFAULT NULL,
  `tipoEsporte` VARCHAR(100) NULL DEFAULT NULL,
  `username` VARCHAR(150) NULL DEFAULT NULL,
  `categoria_idcategoria` INT(11) NULL DEFAULT NULL,
  `restrito` INT(11) NOT NULL,
  PRIMARY KEY (`idcategoria`),
  INDEX `fk_categoria_configuracaoCadastro1_idx` (`configuracaoCadastro_idconfiguracaoCadastro` ASC),
  INDEX `fk_categoria_configuracao1_idx` USING BTREE (`configuracao_idconfiguracao`),
  INDEX `fk_categoria_competicao1` (`competicao_idcompeticao` ASC),
  INDEX `fk_categoria_criterios1_idx` (`criterios_idcriterios` ASC),
  CONSTRAINT `fk_categoria_competicao1`
    FOREIGN KEY (`competicao_idcompeticao`)
    REFERENCES `servidorgerencia_gcomp`.`competicao` (`idcompeticao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categoria_configuracao1`
    FOREIGN KEY (`configuracao_idconfiguracao`)
    REFERENCES `servidorgerencia_gcomp`.`configuracao` (`idconfiguracao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categoria_configuracaoCadastro1`
    FOREIGN KEY (`configuracaoCadastro_idconfiguracaoCadastro`)
    REFERENCES `servidorgerencia_gcomp`.`configuracaoCadastro` (`idconfiguracaoCadastro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_categoria_criterios1`
    FOREIGN KEY (`criterios_idcriterios`)
    REFERENCES `servidorgerencia_gcomp`.`criterios` (`idcriterios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 234
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`anuncio_has_categoria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`anuncio_has_categoria` (
  `anuncio_idanuncio` INT(11) NOT NULL,
  `categoria_idcategoria` INT(11) NOT NULL,
  `status` INT(11) NULL DEFAULT NULL,
  `quantidadeCliques` INT(11) NULL DEFAULT 0,
  `quantidadeCliquesAnuncioRodape` INT(11) NULL DEFAULT 0,
  `quantidadeCliquesWhatsapp` INT(11) NULL DEFAULT 0,
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_anuncio_has_categoria_categoria1_idx` (`categoria_idcategoria` ASC),
  INDEX `fk_anuncio_has_categoria_anuncio1_idx` (`anuncio_idanuncio` ASC),
  CONSTRAINT `fk_anuncio_has_categoria_anuncio1`
    FOREIGN KEY (`anuncio_idanuncio`)
    REFERENCES `servidorgerencia_gcomp`.`anuncio` (`idanuncio`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_anuncio_has_categoria_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `servidorgerencia_gcomp`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 107
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`arbitro` (
  `idArbitro` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeArbitro` VARCHAR(45) NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  `categoria` VARCHAR(45) NULL DEFAULT NULL,
  `categoria_idcategoria` INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idArbitro`),
  INDEX `fk_arbitro_categoria1_idx` (`categoria_idcategoria` ASC),
  CONSTRAINT `fk_arbitro_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `servidorgerencia_gcomp`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8517
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`grupo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`grupo` (
  `idGrupo` INT(11) NOT NULL,
  `identificadorAlfabetoGrupo` VARCHAR(20) NULL DEFAULT NULL,
  PRIMARY KEY (`idGrupo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`time`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`time` (
  `idTime` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `logotipo` VARCHAR(45) NULL DEFAULT NULL,
  `Grupo_idGrupo` INT(11) NOT NULL,
  `cartoesVermelho` INT(11) NOT NULL DEFAULT 0,
  `cartoesAmarelo` INT(11) NOT NULL DEFAULT 0,
  `sigla` VARCHAR(10) NULL DEFAULT NULL,
  `atestadoMedicoJogadores` MEDIUMBLOB NULL DEFAULT NULL,
  `descricao` VARCHAR(2000) NULL DEFAULT NULL,
  `categoria_idcategoria` INT(11) NOT NULL DEFAULT 1,
  `pais` VARCHAR(95) NULL DEFAULT NULL,
  `estado` VARCHAR(95) NULL DEFAULT NULL,
  `quantidadeVezesCampeao` INT(11) NULL DEFAULT NULL,
  `anoFundacao` VARCHAR(55) NULL DEFAULT NULL,
  `atestadoMedicoGeral` VARCHAR(95) NULL DEFAULT NULL,
  `corPrincipal` VARCHAR(45) NULL DEFAULT NULL,
  `aceiteTermo` VARCHAR(100) NULL DEFAULT NULL,
  `time_idTime` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idTime`),
  INDEX `fk_Time_Grupo1_idx` (`Grupo_idGrupo` ASC),
  INDEX `fk_time_categoria1_idx` (`categoria_idcategoria` ASC),
  CONSTRAINT `fk_Time_Grupo1`
    FOREIGN KEY (`Grupo_idGrupo`)
    REFERENCES `servidorgerencia_gcomp`.`grupo` (`idGrupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_time_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `servidorgerencia_gcomp`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2671;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`jogador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`jogador` (
  `idjogador` INT(11) NOT NULL AUTO_INCREMENT,
  `numero` INT(11) NULL DEFAULT NULL,
  `nomeJogador` VARCHAR(45) NULL DEFAULT NULL,
  `time_idTime` INT(11) NOT NULL,
  `passaporte` VARCHAR(45) NULL DEFAULT NULL,
  `dataNascimento` DATE NULL DEFAULT NULL,
  `localNascimento` VARCHAR(85) NULL DEFAULT NULL,
  `nomePai` VARCHAR(85) NULL DEFAULT NULL,
  `nomeMae` VARCHAR(85) NULL DEFAULT NULL,
  `foto` VARCHAR(55) NULL DEFAULT NULL,
  `posicao` VARCHAR(45) NULL DEFAULT NULL,
  `historicoEscolar` MEDIUMBLOB NULL DEFAULT NULL,
  `atestadoMedico` MEDIUMBLOB NULL DEFAULT NULL,
  `apelido` VARCHAR(100) NULL DEFAULT NULL,
  `caminhoAtestadoMedico` VARCHAR(95) NULL DEFAULT NULL,
  `caminhoHistoricoEscolar` VARCHAR(95) NULL DEFAULT NULL,
  `status` INT(11) NULL DEFAULT 1,
  `aprovadoPor` VARCHAR(100) NULL DEFAULT NULL,
  `idUsuarioAprovou` INT(11) NULL DEFAULT NULL,
  `dataRegistro` TIMESTAMP NULL DEFAULT NULL,
  `cpf` VARCHAR(40) NULL DEFAULT NULL,
  `caminhoComprovanteVacina` VARCHAR(45) NULL DEFAULT NULL COMMENT 'caminhoComprovanteVacina',
  `caminhoCPF` VARCHAR(45) NULL DEFAULT NULL,
  `caminhoPassaporte` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idjogador`),
  INDEX `fk_jogador_time1_idx` (`time_idTime` ASC),
  CONSTRAINT `fk_jogador_time1`
    FOREIGN KEY (`time_idTime`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 62556
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`artilharia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`artilharia` (
  `idartilharia` INT(11) NOT NULL AUTO_INCREMENT,
  `jogador_idjogador` INT(11) NOT NULL,
  `posicao` INT(11) NULL DEFAULT NULL,
  `gols` INT(11) NULL DEFAULT NULL,
  `categoria_idcategoria` INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idartilharia`),
  INDEX `fk_artilharia_jogador1_idx` (`jogador_idjogador` ASC),
  INDEX `fk_artilharia_categoria1_idx` (`categoria_idcategoria` ASC),
  CONSTRAINT `fk_artilharia_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `servidorgerencia_gcomp`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artilharia_jogador1`
    FOREIGN KEY (`jogador_idjogador`)
    REFERENCES `servidorgerencia_gcomp`.`jogador` (`idjogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 14500
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`comissaotecnica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`comissaotecnica` (
  `idcomissaoTecnica` INT(11) NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NULL DEFAULT NULL,
  `funcao` VARCHAR(45) NULL DEFAULT NULL,
  `time_idTime` INT(11) NOT NULL,
  `foto` VARCHAR(55) NULL DEFAULT NULL,
  `cpf` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idcomissaoTecnica`),
  INDEX `fk_comissaoTecnica_time1_idx` (`time_idTime` ASC),
  CONSTRAINT `fk_comissaoTecnica_time1`
    FOREIGN KEY (`time_idTime`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 13117
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`resultado`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`resultado` (
  `idResultado` INT(11) NOT NULL AUTO_INCREMENT,
  `golsTime1` INT(11) NULL DEFAULT NULL,
  `golsTime2` INT(11) NULL DEFAULT NULL,
  `golsPenaltiTime1` INT(11) NULL DEFAULT NULL,
  `golsPenaltiTime2` INT(11) NULL DEFAULT NULL,
  `foiPenalti` INT(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`idResultado`))
ENGINE = InnoDB
AUTO_INCREMENT = 8832;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`local`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`local` (
  `idlocal` INT(11) NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(200) NULL DEFAULT NULL,
  `idCompeticao` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idlocal`))
ENGINE = InnoDB
AUTO_INCREMENT = 452
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`jogo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`jogo` (
  `idJogo` INT(11) NOT NULL AUTO_INCREMENT,
  `dataJogo` TIMESTAMP NULL DEFAULT NULL,
  `Grupo_idGrupo` INT(11) NULL DEFAULT NULL,
  `Time_idTime2` INT(11) NULL DEFAULT NULL,
  `Time_idTime1` INT(11) NULL DEFAULT NULL,
  `faseJogo` INT(11) NULL DEFAULT NULL,
  `Resultado_idResultado` INT(11) NULL DEFAULT NULL,
  `status` INT(11) NULL DEFAULT 0,
  `rodada` INT(11) NULL DEFAULT NULL,
  `linkJogo` VARCHAR(120) NULL DEFAULT NULL,
  `local_idlocal` INT(11) NULL DEFAULT NULL,
  `resumoJogo` VARCHAR(500) NULL DEFAULT NULL,
  `categoria_idcategoria` INT(11) NOT NULL,
  `faseJogo_idfaseJogo` INT(11) NOT NULL DEFAULT 1,
  `wo` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idJogo`),
  INDEX `fk_Jogo_Grupo1_idx` (`Grupo_idGrupo` ASC),
  INDEX `fk_Jogo_Time1_idx` (`Time_idTime2` ASC),
  INDEX `fk_Jogo_Time2_idx` (`Time_idTime1` ASC),
  INDEX `fk_Jogo_Resultado1_idx` (`Resultado_idResultado` ASC),
  INDEX `fk_jogo_local1_idx` (`local_idlocal` ASC),
  INDEX `fk_jogo_categoria1_idx` (`categoria_idcategoria` ASC),
  INDEX `fk_jogo_faseJogo1_idx` (`faseJogo_idfaseJogo` ASC),
  CONSTRAINT `fk_Jogo_Grupo1`
    FOREIGN KEY (`Grupo_idGrupo`)
    REFERENCES `servidorgerencia_gcomp`.`grupo` (`idGrupo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_Resultado1`
    FOREIGN KEY (`Resultado_idResultado`)
    REFERENCES `servidorgerencia_gcomp`.`resultado` (`idResultado`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_Time1`
    FOREIGN KEY (`Time_idTime2`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Jogo_Time2`
    FOREIGN KEY (`Time_idTime1`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogo_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `servidorgerencia_gcomp`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogo_faseJogo1`
    FOREIGN KEY (`faseJogo_idfaseJogo`)
    REFERENCES `servidorgerencia_gcomp`.`faseJogo` (`idfaseJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_jogo_local1`
    FOREIGN KEY (`local_idlocal`)
    REFERENCES `servidorgerencia_gcomp`.`local` (`idlocal`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8800;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`cronologia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`cronologia` (
  `Time_1_HoraEntradaTempo1` TIME NULL DEFAULT NULL,
  `Time_1_HoraEntradaTempo2` TIME NULL DEFAULT NULL,
  `Time_2_HoraEntradaTempo1` TIME NULL DEFAULT NULL,
  `Time_2_HoraEntradaTempo2` TIME NULL DEFAULT NULL,
  `inicioPrimeiroTempo` TIME NULL DEFAULT NULL,
  `inicioSegundoTempo` TIME NULL DEFAULT NULL,
  `terminoPrimeiroTempo` TIME NULL DEFAULT NULL,
  `terminoSegundoTempo` TIME NULL DEFAULT NULL,
  `resultadoPrimeiroTempo` VARCHAR(10) NULL DEFAULT NULL,
  `idCronologia` INT(11) NOT NULL AUTO_INCREMENT,
  `acrescimoPrimeiroTempo` TIME NULL DEFAULT NULL,
  `acrescimoSegundoTempo` TIME NULL DEFAULT NULL,
  `observacao` VARCHAR(30000) NULL DEFAULT NULL,
  PRIMARY KEY (`idCronologia`))
ENGINE = InnoDB
AUTO_INCREMENT = 8813
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`sumario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`sumario` (
  `idSumario` INT(11) NOT NULL AUTO_INCREMENT,
  `campeonato` VARCHAR(45) NULL DEFAULT NULL,
  `rodada` INT(11) NULL DEFAULT NULL,
  `data` TIMESTAMP NULL DEFAULT NULL,
  `estadio` VARCHAR(45) NULL DEFAULT NULL,
  `estado` VARCHAR(45) NULL DEFAULT NULL,
  `jogo_idJogo` INT(11) NOT NULL,
  `cronologia_idCronologia` INT(11) NULL DEFAULT NULL,
  `status` INT(11) NULL DEFAULT NULL,
  `mesario` VARCHAR(455) NULL DEFAULT NULL,
  PRIMARY KEY (`idSumario`),
  INDEX `fk_Sumario_jogo1_idx` (`jogo_idJogo` ASC),
  INDEX `fk_sumario_cronologia1_idx` (`cronologia_idCronologia` ASC),
  CONSTRAINT `fk_Sumario_jogo1`
    FOREIGN KEY (`jogo_idJogo`)
    REFERENCES `servidorgerencia_gcomp`.`jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sumario_cronologia1`
    FOREIGN KEY (`cronologia_idCronologia`)
    REFERENCES `servidorgerencia_gcomp`.`cronologia` (`idCronologia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 8800
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`cartao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`cartao` (
  `idcartaoAmarelo` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(25) NULL DEFAULT NULL,
  `jogador_idjogador` INT(11) NULL DEFAULT NULL,
  `sumario_idSumario` INT(11) NOT NULL,
  `tempo` TIMESTAMP NULL DEFAULT NULL,
  `periodo` INT(11) NULL DEFAULT NULL,
  `motivo` VARCHAR(500) NULL DEFAULT NULL,
  `time_idTime` INT(11) NOT NULL,
  `tempoString` VARCHAR(45) NULL DEFAULT NULL,
  `idLance` INT(11) NULL DEFAULT NULL,
  `comissaotecnica_idcomissaoTecnica` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idcartaoAmarelo`),
  INDEX `fk_cartao_jogador1_idx` (`jogador_idjogador` ASC),
  INDEX `fk_cartao_sumario1_idx` (`sumario_idSumario` ASC),
  INDEX `fk_cartao_time1_idx` (`time_idTime` ASC),
  INDEX `fk_cartao_comissaotecnica1_idx` (`comissaotecnica_idcomissaoTecnica` ASC),
  CONSTRAINT `fk_cartao_comissaotecnica1`
    FOREIGN KEY (`comissaotecnica_idcomissaoTecnica`)
    REFERENCES `servidorgerencia_gcomp`.`comissaotecnica` (`idcomissaoTecnica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartao_jogador1`
    FOREIGN KEY (`jogador_idjogador`)
    REFERENCES `servidorgerencia_gcomp`.`jogador` (`idjogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartao_sumario1`
    FOREIGN KEY (`sumario_idSumario`)
    REFERENCES `servidorgerencia_gcomp`.`sumario` (`idSumario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_cartao_time1`
    FOREIGN KEY (`time_idTime`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 22588
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`defesaMenosVazada`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`defesaMenosVazada` (
  `iddefesaMenosVazada` INT(11) NOT NULL AUTO_INCREMENT,
  `posicao` INT(11) NULL DEFAULT NULL,
  `gols` INT(11) NULL DEFAULT NULL,
  `time_idTime` INT(11) NOT NULL,
  `categoria_idcategoria` INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`iddefesaMenosVazada`),
  INDEX `fk_defesaMenosVazada_time1_idx` (`time_idTime` ASC),
  INDEX `fk_defesaMenosVazada_categoria1_idx` (`categoria_idcategoria` ASC),
  CONSTRAINT `fk_defesaMenosVazada_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `servidorgerencia_gcomp`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_defesaMenosVazada_time1`
    FOREIGN KEY (`time_idTime`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2760
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`escalacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`escalacao` (
  `idescalacao` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeTecnico` VARCHAR(100) NULL DEFAULT NULL,
  `jogo_idJogo` INT(11) NOT NULL,
  `time_idTime` INT(11) NOT NULL,
  PRIMARY KEY (`idescalacao`),
  INDEX `fk_escalacao_jogo1_idx` (`jogo_idJogo` ASC),
  INDEX `fk_escalacao_time1_idx` (`time_idTime` ASC),
  CONSTRAINT `fk_escalacao_jogo1`
    FOREIGN KEY (`jogo_idJogo`)
    REFERENCES `servidorgerencia_gcomp`.`jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escalacao_time1`
    FOREIGN KEY (`time_idTime`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 16338
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`escalacao_has_comissaotecnica`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`escalacao_has_comissaotecnica` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `comissaotecnica_idcomissaoTecnica` INT(11) NOT NULL,
  `escalacao_idescalacao` INT(11) NOT NULL,
  `funcao` VARCHAR(200) NULL DEFAULT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_escalacao_has_comissaotecnica_comissaotecnica1_idx` (`comissaotecnica_idcomissaoTecnica` ASC),
  INDEX `fk_escalacao_has_comissaotecnica_escalacao1_idx` (`escalacao_idescalacao` ASC),
  CONSTRAINT `fk_escalacao_has_comissaotecnica_comissaotecnica1`
    FOREIGN KEY (`comissaotecnica_idcomissaoTecnica`)
    REFERENCES `servidorgerencia_gcomp`.`comissaotecnica` (`idcomissaoTecnica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escalacao_has_comissaotecnica_escalacao1`
    FOREIGN KEY (`escalacao_idescalacao`)
    REFERENCES `servidorgerencia_gcomp`.`escalacao` (`idescalacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 816
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`escalacao_has_jogador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`escalacao_has_jogador` (
  `escalacao_idescalacao` INT(11) NOT NULL,
  `jogador_idjogador` INT(11) NOT NULL,
  `titular` INT(1) NULL DEFAULT NULL,
  `numeroCamisa` INT(3) NULL DEFAULT NULL,
  `titularidade` TINYINT(1) NULL DEFAULT NULL,
  `relacionado` INT(1) NULL DEFAULT 1,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  INDEX `fk_escalacao_has_jogador_jogador1_idx` (`jogador_idjogador` ASC),
  INDEX `fk_escalacao_has_jogador_escalacao1_idx` (`escalacao_idescalacao` ASC),
  CONSTRAINT `fk_escalacao_has_jogador_escalacao1`
    FOREIGN KEY (`escalacao_idescalacao`)
    REFERENCES `servidorgerencia_gcomp`.`escalacao` (`idescalacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_escalacao_has_jogador_jogador1`
    FOREIGN KEY (`jogador_idjogador`)
    REFERENCES `servidorgerencia_gcomp`.`jogador` (`idjogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 394499
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`gol`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`gol` (
  `idgol` INT(11) NOT NULL AUTO_INCREMENT,
  `tempo` TIMESTAMP NULL DEFAULT NULL,
  `periodo` INT(11) NULL DEFAULT NULL,
  `tipo` VARCHAR(15) NULL DEFAULT NULL,
  `jogador_idjogador` INT(11) NOT NULL,
  `time_idTime` INT(11) NOT NULL,
  `sumario_idSumario` INT(11) NOT NULL,
  `tempoRegulamentar` INT(11) NULL DEFAULT 1,
  `idLance` INT(11) NULL DEFAULT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`idgol`),
  INDEX `fk_gol_jogador1_idx` (`jogador_idjogador` ASC),
  INDEX `fk_gol_time1_idx` (`time_idTime` ASC),
  INDEX `fk_gol_sumario1_idx` (`sumario_idSumario` ASC),
  CONSTRAINT `fk_gol_jogador1`
    FOREIGN KEY (`jogador_idjogador`)
    REFERENCES `servidorgerencia_gcomp`.`jogador` (`idjogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gol_sumario1`
    FOREIGN KEY (`sumario_idSumario`)
    REFERENCES `servidorgerencia_gcomp`.`sumario` (`idSumario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_gol_time1`
    FOREIGN KEY (`time_idTime`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 32367
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`lance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`lance` (
  `idlance` INT(11) NOT NULL AUTO_INCREMENT,
  `tipo` VARCHAR(45) NULL DEFAULT NULL,
  `tempo` TIMESTAMP NULL DEFAULT NULL,
  `descricao` VARCHAR(300) NULL DEFAULT NULL,
  `time_idTime` INT(11) NULL DEFAULT NULL,
  `jogo_idJogo` INT(11) NOT NULL,
  `periodo` INT(11) NULL DEFAULT NULL,
  `tempoString` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`idlance`),
  INDEX `fk_lance_time1_idx` (`time_idTime` ASC),
  INDEX `fk_lance_jogo1_idx` (`jogo_idJogo` ASC),
  CONSTRAINT `fk_lance_jogo1`
    FOREIGN KEY (`jogo_idJogo`)
    REFERENCES `servidorgerencia_gcomp`.`jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_lance_time1`
    FOREIGN KEY (`time_idTime`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 156275
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`noticia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`noticia` (
  `idnoticia` INT(11) NOT NULL AUTO_INCREMENT,
  `titulo` VARCHAR(45) NULL DEFAULT NULL,
  `descricao` VARCHAR(1000) NULL DEFAULT NULL,
  `data` TIMESTAMP NULL DEFAULT NULL,
  `linkConteudo` VARCHAR(200) NULL DEFAULT NULL,
  `tipo` INT(11) NULL DEFAULT NULL,
  `categoria_idcategoria` INT(11) NULL DEFAULT NULL,
  `competicao_idcompeticao` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idnoticia`),
  INDEX `fk_noticia_categoria1_idx` (`categoria_idcategoria` ASC),
  INDEX `fk_noticia_competicao1_idx` (`competicao_idcompeticao` ASC),
  CONSTRAINT `fk_noticia_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `servidorgerencia_gcomp`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_noticia_competicao1`
    FOREIGN KEY (`competicao_idcompeticao`)
    REFERENCES `servidorgerencia_gcomp`.`competicao` (`idcompeticao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 83
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`substituicao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`substituicao` (
  `idsubstituicao` INT(11) NOT NULL AUTO_INCREMENT,
  `tempo` TIMESTAMP NULL DEFAULT NULL,
  `periodo` INT(11) NULL DEFAULT NULL,
  `time_idTime` INT(11) NOT NULL,
  `jogador_idjogador2` INT(11) NOT NULL,
  `jogador_idjogador1` INT(11) NOT NULL,
  `sumario_idSumario` INT(11) NOT NULL,
  `idLance` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idsubstituicao`),
  INDEX `fk_substituicao_time1_idx` (`time_idTime` ASC),
  INDEX `fk_substituicao_jogador1_idx` (`jogador_idjogador2` ASC),
  INDEX `fk_substituicao_jogador2_idx` (`jogador_idjogador1` ASC),
  INDEX `fk_substituicao_sumario1_idx` (`sumario_idSumario` ASC),
  CONSTRAINT `fk_substituicao_jogador1`
    FOREIGN KEY (`jogador_idjogador2`)
    REFERENCES `servidorgerencia_gcomp`.`jogador` (`idjogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_substituicao_jogador2`
    FOREIGN KEY (`jogador_idjogador1`)
    REFERENCES `servidorgerencia_gcomp`.`jogador` (`idjogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_substituicao_sumario1`
    FOREIGN KEY (`sumario_idSumario`)
    REFERENCES `servidorgerencia_gcomp`.`sumario` (`idSumario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_substituicao_time1`
    FOREIGN KEY (`time_idTime`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 60689
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`sumario_has_arbitro`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`sumario_has_arbitro` (
  `Sumario_idSumario` INT(11) NOT NULL,
  `Arbitro_idArbitro` INT(11) NOT NULL,
  `funcao` VARCHAR(45) NULL DEFAULT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`),
  INDEX `fk_Sumario_has_Arbitro_Arbitro1_idx` (`Arbitro_idArbitro` ASC),
  INDEX `fk_Sumario_has_Arbitro_Sumario1_idx` (`Sumario_idSumario` ASC),
  CONSTRAINT `fk_Sumario_has_Arbitro_Arbitro1`
    FOREIGN KEY (`Arbitro_idArbitro`)
    REFERENCES `servidorgerencia_gcomp`.`arbitro` (`idArbitro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Sumario_has_Arbitro_Sumario1`
    FOREIGN KEY (`Sumario_idSumario`)
    REFERENCES `servidorgerencia_gcomp`.`sumario` (`idSumario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 15512
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`suspensao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`suspensao` (
  `idsuspensao` INT(11) NOT NULL AUTO_INCREMENT,
  `jogo_suspenso` INT(11) NOT NULL,
  `jogo_registrado` INT(11) NOT NULL,
  `jogador_idjogador` INT(11) NULL DEFAULT NULL,
  `tipo` INT(11) NOT NULL,
  `cumprimento` INT(11) NULL DEFAULT NULL,
  `penalizacao` INT(11) NULL DEFAULT NULL,
  `suspensao` INT(11) NULL DEFAULT NULL,
  `idLance` INT(11) NULL DEFAULT NULL,
  `comissaotecnica_idcomissaoTecnica` INT(11) NULL DEFAULT NULL,
  PRIMARY KEY (`idsuspensao`),
  INDEX `fk_suspensao_jogo1_idx` (`jogo_suspenso` ASC),
  INDEX `fk_suspensao_jogo2_idx` (`jogo_registrado` ASC),
  INDEX `fk_suspensao_jogador1_idx` (`jogador_idjogador` ASC),
  INDEX `fk_suspensao_comissaotecnica1_idx` (`comissaotecnica_idcomissaoTecnica` ASC),
  CONSTRAINT `fk_suspensao_comissaotecnica1`
    FOREIGN KEY (`comissaotecnica_idcomissaoTecnica`)
    REFERENCES `servidorgerencia_gcomp`.`comissaotecnica` (`idcomissaoTecnica`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suspensao_jogador1`
    FOREIGN KEY (`jogador_idjogador`)
    REFERENCES `servidorgerencia_gcomp`.`jogador` (`idjogador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suspensao_jogo1`
    FOREIGN KEY (`jogo_suspenso`)
    REFERENCES `servidorgerencia_gcomp`.`jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_suspensao_jogo2`
    FOREIGN KEY (`jogo_registrado`)
    REFERENCES `servidorgerencia_gcomp`.`jogo` (`idJogo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2496
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`tabela`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`tabela` (
  `idTabela` INT(11) NOT NULL AUTO_INCREMENT,
  `golsPro` INT(11) NULL DEFAULT NULL,
  `golsContra` INT(11) NULL DEFAULT NULL,
  `vitorias` INT(11) NULL DEFAULT NULL,
  `derrotas` INT(11) NULL DEFAULT NULL,
  `empates` INT(11) NULL DEFAULT NULL,
  `pontosTotal` INT(11) NULL DEFAULT NULL,
  `colocacao` INT(11) NULL DEFAULT NULL,
  `jogos` INT(11) NULL DEFAULT NULL,
  `saldoGol` INT(11) NULL DEFAULT NULL,
  `Time_idTime` INT(11) NOT NULL,
  `grupo` INT(11) NULL DEFAULT NULL,
  `categoria_idcategoria` INT(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`idTabela`),
  INDEX `fk_Tabela_Time1_idx` (`Time_idTime` ASC),
  INDEX `fk_tabela_categoria1_idx` (`categoria_idcategoria` ASC),
  CONSTRAINT `fk_Tabela_Time1`
    FOREIGN KEY (`Time_idTime`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tabela_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `servidorgerencia_gcomp`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2761;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`token`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`token` (
  `idtoken` INT(11) NOT NULL AUTO_INCREMENT,
  `idcompeticao` INT(11) NULL DEFAULT NULL,
  `idcategoria` INT(11) NULL DEFAULT NULL,
  `idTimeFavorito` INT(11) NULL DEFAULT NULL,
  `createdAt` DATETIME NULL DEFAULT NULL,
  `updatedAt` DATETIME NULL DEFAULT NULL,
  `token` VARCHAR(300) NULL DEFAULT NULL,
  `receberTodasCategorias` TINYINT(4) NULL DEFAULT NULL,
  PRIMARY KEY (`idtoken`))
ENGINE = InnoDB
AUTO_INCREMENT = 108677
DEFAULT CHARACTER SET = latin1;


-- -----------------------------------------------------
-- Table `servidorgerencia_gcomp`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `servidorgerencia_gcomp`.`usuario` (
  `idusuario` INT(11) NOT NULL AUTO_INCREMENT,
  `nomeUsuario` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(100) NULL DEFAULT NULL,
  `senha` VARCHAR(45) NULL DEFAULT NULL,
  `papelAdmin` INT(1) NULL DEFAULT NULL,
  `papelResponsavelTecnico` INT(1) NULL DEFAULT NULL,
  `time_idTime` INT(11) NULL DEFAULT NULL,
  `categoria_idcategoria` INT(11) NULL DEFAULT 1,
  `competicao_idcompeticao` INT(11) NULL DEFAULT NULL,
  `papelMesario` INT(1) NULL DEFAULT 0,
  `papelAdminSupremo` INT(1) NULL DEFAULT 0,
  `senhaString` VARCHAR(100) NULL DEFAULT NULL,
  `login` VARCHAR(100) NULL DEFAULT NULL,
  PRIMARY KEY (`idusuario`),
  INDEX `fk_usuario_time1_idx` (`time_idTime` ASC),
  INDEX `fk_usuario_categoria1_idx` (`categoria_idcategoria` ASC),
  INDEX `fk_usuario_competicao1_idx` (`competicao_idcompeticao` ASC),
  CONSTRAINT `fk_usuario_categoria1`
    FOREIGN KEY (`categoria_idcategoria`)
    REFERENCES `servidorgerencia_gcomp`.`categoria` (`idcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_competicao1`
    FOREIGN KEY (`competicao_idcompeticao`)
    REFERENCES `servidorgerencia_gcomp`.`competicao` (`idcompeticao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_time1`
    FOREIGN KEY (`time_idTime`)
    REFERENCES `servidorgerencia_gcomp`.`time` (`idTime`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2989
DEFAULT CHARACTER SET = latin1;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
