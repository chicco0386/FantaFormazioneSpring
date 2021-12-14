CREATE TABLE `giornate` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `numero_giornata` INTEGER NOT NULL,
  `stagione` varchar(10) NOT NULL,
  `data` date DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `squadre` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `giocatori` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `id_squadra` BIGINT NOT NULL,
  `nome` varchar(45) NOT NULL,
  `ruolo` varchar(1) NOT NULL,
  `stagione` varchar(10) DEFAULT NULL,
  `quotaz_iniziale` decimal(4,2) DEFAULT NULL,
  `quotaz_attuale` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`,`nome`),
  KEY `FK_squadra_id` (`id_squadra`),
  CONSTRAINT `FK_squadra_id` FOREIGN KEY (`id_squadra`) REFERENCES `squadre` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `calendario` (
  `id_giornata` BIGINT NOT NULL,
  `id_squadra_casa` BIGINT NOT NULL,
  `id_squadra_fuori_casa` BIGINT NOT NULL,
  KEY `FK_cal_id_giornata` (`id_giornata`),
  KEY `FK_cal_id_sq_casa` (`id_squadra_casa`),
  KEY `FK_cal_id_sq_fuori` (`id_squadra_fuori_casa`),
  CONSTRAINT `FK_cal_id_giornata` FOREIGN KEY (`id_giornata`) REFERENCES `giornate` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_cal_id_sq_casa` FOREIGN KEY (`id_squadra_casa`) REFERENCES `squadre` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_cal_id_sq_fuori` FOREIGN KEY (`id_squadra_fuori_casa`) REFERENCES `squadre` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `probabili_formazioni_fg` (
  `id_giocatore` BIGINT NOT NULL,
  `id_giornata` BIGINT NOT NULL,
  `titolare` TINYINT DEFAULT NULL,
  `panchina` TINYINT DEFAULT NULL,
  KEY `FK_pf_fg_id_giocatore` (`id_giocatore`),
  KEY `FK_pf_fg_id_giornata` (`id_giornata`),
  CONSTRAINT `FK_pf_fg_id_giocatore` FOREIGN KEY (`id_giocatore`) REFERENCES `giocatori` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_pf_fg_id_giornata` FOREIGN KEY (`id_giornata`) REFERENCES `giornate` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `probabili_formazioni_gazzetta` (
  `id_giocatore` BIGINT NOT NULL,
  `id_giornata` BIGINT NOT NULL,
  `titolare` TINYINT DEFAULT NULL,
  `panchina` TINYINT DEFAULT NULL,
  KEY `FK_id_giocatore` (`id_giocatore`),
  KEY `FK_pf_g_id_giornata` (`id_giornata`),
  CONSTRAINT `FK_pf_g_id_giocatore0` FOREIGN KEY (`id_giocatore`) REFERENCES `giocatori` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_pf_g_id_giornata` FOREIGN KEY (`id_giornata`) REFERENCES `giornate` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `statistiche` (
  `id_giocatore` BIGINT NOT NULL,
  `id_giornata` BIGINT NOT NULL DEFAULT '1',
  `media_voto` decimal(4,2) NOT NULL DEFAULT '0.00',
  `media_voto_fm` decimal(4,2) NOT NULL DEFAULT '0.00',
  `goal_fatti` INTEGER NOT NULL DEFAULT '0',
  `goal_rigore` INTEGER NOT NULL DEFAULT '0',
  `goal_subiti` INTEGER NOT NULL DEFAULT '0',
  `rigori_parati` INTEGER NOT NULL DEFAULT '0',
  `rigori_sbagliati` INTEGER NOT NULL DEFAULT '0',
  `autoreti` INTEGER NOT NULL DEFAULT '0',
  `assist` INTEGER NOT NULL DEFAULT '0',
  `ammonizioni` INTEGER NOT NULL DEFAULT '0',
  `espulsioni` INTEGER NOT NULL DEFAULT '0',
  KEY `FK_stat_id_giocatore` (`id_giocatore`),
  KEY `FK_stat_id_giornata` (`id_giornata`),
  CONSTRAINT `FK_stat_id_giocatore` FOREIGN KEY (`id_giocatore`) REFERENCES `giocatori` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_stat_id_giornata` FOREIGN KEY (`id_giornata`) REFERENCES `giornate` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `utenti` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `username` varchar(45) NOT NULL,
  `password` varchar(45) NOT NULL,
  `mail` varchar(200) NOT NULL,
  `data_registrazione` date DEFAULT NULL,
  `data_ultimo_accesso` date DEFAULT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `utenti_formazioni` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `id_utente` BIGINT NOT NULL,
  `nome_formazione` varchar(45) NOT NULL,
  `crediti` decimal(4,2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_uf_id_utente` (`id_utente`),
  CONSTRAINT `FK_uf_id_utente` FOREIGN KEY (`id_utente`) REFERENCES `utenti` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `formazioni` (
  `id_giocatore` BIGINT NOT NULL,
  `id_utenti_formazioni` BIGINT NOT NULL,
  `prezzo_acquisto` decimal(4,2) DEFAULT NULL,
  KEY `FK_f_fg_id_giocatore` (`id_giocatore`),
  KEY `FK_f_fg_id_utenti_formazioni` (`id_utenti_formazioni`),
  CONSTRAINT `FK_f_fg_id_giocatore` FOREIGN KEY (`id_giocatore`) REFERENCES `giocatori` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_f_fg_id_utenti_formazioni` FOREIGN KEY (`id_utenti_formazioni`) REFERENCES `utenti_formazioni` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);

CREATE TABLE `probabili_formazioni` (
  `id_giornate` BIGINT NOT NULL,
  `id_utenti_formazioni` BIGINT NOT NULL,
  `id_giocatore` BIGINT NOT NULL,
  `prob_titolare` INTEGER NOT NULL,
  `prob_panchina` INTEGER NOT NULL,
  `note` varchar(100) DEFAULT NULL,
  KEY `FK_f_fg_giornate` (`id_giornate`),
  KEY `FK_f_fg_utenti_formazioni` (`id_utenti_formazioni`),
  KEY `FK_f_fg_giocatori` (`id_giocatore`),
  CONSTRAINT `FK_f_fg_giocatori` FOREIGN KEY (`id_giocatore`) REFERENCES `giocatori` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_f_fg_giornate` FOREIGN KEY (`id_giornate`) REFERENCES `giornate` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_f_fg_utenti_formazioni` FOREIGN KEY (`id_utenti_formazioni`) REFERENCES `utenti_formazioni` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
);