CREATE DATABASE bgp_database;
USE bgp_database;

-- MySQL dump 10.13  Distrib 5.7.21, for Linux (x86_64)
--
-- Host: localhost    Database: BGP
-- ------------------------------------------------------
-- Server version	5.7.21-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `address_families_by_peer`
--

DROP TABLE IF EXISTS `address_families_by_peer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_families_by_peer` (
  `idaddress_families_by_peer` int(11) NOT NULL AUTO_INCREMENT,
  `address_families_by_peer` varchar(45) NOT NULL,
  PRIMARY KEY (`idaddress_families_by_peer`),
  UNIQUE KEY `address_families_by_peer_UNIQUE` (`address_families_by_peer`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COMMENT='Tabela que representa o campo "Address families by peer". Tem relacao com o "Graceful Restart Capability". Ainda nao tenho informacoes especificas sobre esse campo';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `address_family`
--

DROP TABLE IF EXISTS `address_family`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `address_family` (
  `idaddress_family` int(11) NOT NULL AUTO_INCREMENT,
  `address_family` varchar(45) DEFAULT NULL COMMENT 'IPv4 Unicast ou IPv6 Unicast',
  PRIMARY KEY (`idaddress_family`),
  UNIQUE KEY `address_family_UNIQUE` (`address_family`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Corresponde ao campo "For address family:" do "show ip bgp". Informa se eh IPv4 ou IPv6';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ases`
--

DROP TABLE IF EXISTS `ases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ases` (
  `idases` int(11) NOT NULL AUTO_INCREMENT,
  `ases` int(11) NOT NULL COMMENT 'ASN',
  `responsavel` varchar(45) COMMENT 'Nome da empresa responsavel pelo AS',
  `lg` binary(1) NOT NULL COMMENT 'a informacao deste AS foi pega no site do IX (0) ou atraves do looking glass (1)',
  PRIMARY KEY (`idases`)
) ENGINE=InnoDB AUTO_INCREMENT=2863 DEFAULT CHARSET=utf8 COMMENT='Armazena a lista de ASes com os respectivos nomes das empresas relacionadas. Esta eh a informacao oficinal, consultada do site da IX.br e validado no site do Iana. Se houver mais de um ASn por localidade, esta informacao devera ser armazenada e analizada.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ases_ix`
--

DROP TABLE IF EXISTS `ases_ix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ases_ix` (
  `idases_ix` int(11) NOT NULL AUTO_INCREMENT,
  `idix` int(11) NOT NULL,
  `idases` int(11) NOT NULL,
  `atm_v4` binary(1) DEFAULT NULL,
  `atm_v6` binary(1) DEFAULT NULL,
  `transito_v4` binary(1) DEFAULT NULL,
  `transito_v6` binary(1) DEFAULT NULL,
  `ipv6` binary(1) DEFAULT NULL,
  PRIMARY KEY (`idases_ix`),
  KEY `fk_as_ix_ix_idx` (`idix`),
  KEY `fk_as_ix_as1_idx` (`idases`),
  CONSTRAINT `fk_as_ix_as1` FOREIGN KEY (`idases`) REFERENCES `ases` (`idases`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_as_ix_ix` FOREIGN KEY (`idix`) REFERENCES `ix` (`idix`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2863 DEFAULT CHARSET=utf8 COMMENT='Lista de ASes conectados em PIX de um determinado IX ou diretamente no IX. A principio nao tenho como saber via comandos show em qual PIX um AS esta, portanto, armazeno apenas qual IX um AS esta.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bgp_connection`
--

DROP TABLE IF EXISTS `bgp_connection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bgp_connection` (
  `idbgp_connection` int(11) NOT NULL AUTO_INCREMENT,
  `bgp_connection` varchar(45) NOT NULL,
  PRIMARY KEY (`idbgp_connection`),
  UNIQUE KEY `bgp_connection_UNIQUE` (`bgp_connection`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bgp_path`
--

DROP TABLE IF EXISTS `bgp_path`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bgp_path` (
  `idbgp_path` int(11) NOT NULL AUTO_INCREMENT,
  `idroute` int(11) NOT NULL,
  `idases` int(11) NOT NULL,
  PRIMARY KEY (`idbgp_path`),
  KEY `fk_idroutes` (`idroute`),
  KEY `fk_idases1` (`idases`),
  CONSTRAINT `fk_idases1` FOREIGN KEY (`idases`) REFERENCES `ases` (`idases`),
  CONSTRAINT `fk_idroutes` FOREIGN KEY (`idroute`) REFERENCES `routes` (`idroute`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bgp_state`
--

DROP TABLE IF EXISTS `bgp_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bgp_state` (
  `idbgp_state` int(11) NOT NULL AUTO_INCREMENT,
  `bgp_state` varchar(45) NOT NULL COMMENT 'Finite state machine (FSM) stage of session negotiation: Idle, Connect, Active, OpenSent, OpenConfirm, Established.',
  PRIMARY KEY (`idbgp_state`),
  UNIQUE KEY `bgp_state_UNIQUE` (`bgp_state`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='Finite state machine (FSM) stage of session negotiation: Idle, Connect, Active, OpenSent, OpenConfirm, Established.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `end_of_rib`
--

DROP TABLE IF EXISTS `end_of_rib`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `end_of_rib` (
  `idend_of_rib` int(11) NOT NULL AUTO_INCREMENT,
  `end_of_rib` varchar(45) NOT NULL,
  PRIMARY KEY (`idend_of_rib`),
  UNIQUE KEY `end_of_rib_UNIQUE` (`end_of_rib`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COMMENT='Corresponde aos valores dos campos "end-of_rib send" e "end-of-rib received". Ainda nao tenho detalhes desses campos.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `idfile` int(11) NOT NULL AUTO_INCREMENT,
  `file` varchar(100) NOT NULL,
  PRIMARY KEY (`idfile`),
  UNIQUE KEY `file_UNIQUE` (`file`)
) ENGINE=InnoDB AUTO_INCREMENT=65252 DEFAULT CHARSET=utf8 COMMENT='Nome do arquivo que armazena os dados (para conferencia de informacao)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `files_description`
--

DROP TABLE IF EXISTS `files_description`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `files_description` (
    `idfiles_description` int(11) AUTO_INCREMENT NOT NULL,
  `idfile` int(11) NOT NULL,
  `bgptable_version` int(11) NOT NULL,
  `local_router_id` int(11) NOT NULL,
  PRIMARY KEY (`idfiles_description`),
  KEY `fk_idfile` (`idfile`),
  KEY `fk_local_router_id` (`local_router_id`),
  CONSTRAINT `fk_idfile` FOREIGN KEY (`idfile`) REFERENCES `file` (`idfile`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_local_router_id` FOREIGN KEY (`local_router_id`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ip`
--

DROP TABLE IF EXISTS `ip`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ip` (
  `idip` int(11) NOT NULL AUTO_INCREMENT,
  `ip` decimal(45,0) DEFAULT NULL,
  `mask` int(11) DEFAULT NULL,
  PRIMARY KEY (`idip`),
  UNIQUE KEY `unique_ip_mask` (`ip`,`mask`)
) ENGINE=InnoDB AUTO_INCREMENT=2196 DEFAULT CHARSET=utf8 COMMENT='Armazena todos IPs do sistema em decimal(65,0)';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ix`
--

DROP TABLE IF EXISTS `ix`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ix` (
  `idix` int(11) NOT NULL AUTO_INCREMENT,
  `ix` varchar(45) DEFAULT NULL COMMENT 'Nome do IX',
  `uf` char(2) DEFAULT NULL,
  `url` varchar(45) DEFAULT NULL,
  `idip` int(11) DEFAULT NULL,
  PRIMARY KEY (`idix`),
  KEY `fk_ix_ip1_idx` (`idip`),
  CONSTRAINT `fk_ix_ip1` FOREIGN KEY (`idip`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='Armazena informações de cada IX';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `last_reset_motivation`
--

DROP TABLE IF EXISTS `last_reset_motivation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `last_reset_motivation` (
  `idlast_reset_motivation` int(11) NOT NULL AUTO_INCREMENT,
  `last_reset_motivation` varchar(100) NOT NULL COMMENT 'Motivo pelo ultimo reset da conexao BGP',
  PRIMARY KEY (`idlast_reset_motivation`),
  UNIQUE KEY `last_reset_motivation_UNIQUE` (`last_reset_motivation`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `line_error`
--

DROP TABLE IF EXISTS `line_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `line_error` (
  `idline_error` int(11) NOT NULL AUTO_INCREMENT,
  `idfile` int(11) NOT NULL,
  `line` int(11) DEFAULT NULL COMMENT 'linha do arquivo com erro',
  `line_error` varchar(45) DEFAULT NULL COMMENT 'conteudo da linha',
  PRIMARY KEY (`idline_error`),
  KEY `fk_line_error_file1_idx` (`idfile`),
  CONSTRAINT `fk_line_error_file1` FOREIGN KEY (`idfile`) REFERENCES `file` (`idfile`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `looking_glass`
--

DROP TABLE IF EXISTS `looking_glass`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `looking_glass` (
  `idlooking_glass` int(11) NOT NULL AUTO_INCREMENT,
  `idfile` int(11) NOT NULL COMMENT 'arquivo que armazena os dados desse registro',
  `bgp_neighbor` int(11) DEFAULT NULL,
  `remote_as` int(11) DEFAULT NULL COMMENT 'remote AS - Autonomous system number of the neighbor',
  `local_as` int(11) DEFAULT NULL COMMENT 'Local AS',
  `origin_code` int(11) DEFAULT NULL COMMENT '“internal link” is displayed for iBGP neighbors; “external link” is displayed for external BGP (eBGP) neighbors.',
  `description` varchar(100) DEFAULT NULL COMMENT 'nome do peer informado pelo IX - deve-se comparar com a lista de ASes para confirmar se a informacao esta atualizada',
  `administratively_shutdown` binary(1) DEFAULT NULL,
  `bgp_version` int(11) DEFAULT NULL COMMENT 'BGP version being used to communicate with the remote router.',
  `remote_router_id` int(11) DEFAULT NULL,
  `bgp_state` int(11) DEFAULT NULL COMMENT 'Finite state machine (FSM) stage of session negotiation: Idle, Connect, Active, OpenSent, OpenConfirm, Established.',
  `up_for` int(11) DEFAULT NULL COMMENT 'Up For - caso o "BGP state" (bgp_state_idorigin_code) estiver "Established" esse campo marca o tempo correspondente. Em segundos.',
  `last_read` int(11) DEFAULT NULL COMMENT 'Last read - Time, in hh:mm:ss, since BGP last received a message from this neighbor.',
  `last_write` int(11) DEFAULT NULL COMMENT 'Last write - Time, in hh:mm:ss, since BGP last sent a message to this neighbor.',
  `hold_time` int(11) DEFAULT NULL COMMENT 'hold time is - Time, in seconds, that BGP will maintain the session with this neighbor without receiving messages.',
  `keepalive_interval` int(11) DEFAULT NULL COMMENT 'keepalive interval is - Time interval, in seconds, at which keepalive messages are transmitted to this neighbor.',
  `four_byte_as` int(11) DEFAULT NULL COMMENT '4 Byte AS: ',
  `route_refresh` int(11) DEFAULT NULL COMMENT 'Route refresh - Status of the route refresh capability.',
  `address_family_ipv4_unicast` int(11) DEFAULT NULL COMMENT 'Address family IPv4 Unicast - IP Version 4 unicast-specific properties of this neighbor.',
  `address_family_ipv4_multicast` int(11) DEFAULT NULL COMMENT 'em Neighbor Capabilities: Address family IPv4 Multicast',
  `address_family_ipv6_unicast` int(11) DEFAULT NULL COMMENT '''Address family IPv6 Unicast: '' em neighbor capabilities',
  `address_family_ipv6_multicast` int(11) DEFAULT NULL,
  `graceful_restart_capability` int(11) DEFAULT NULL COMMENT 'Graceful Restart Capabilty - Status of the graceful restart capability.',
  `remote_restart_timer` int(11) DEFAULT NULL COMMENT 'Remote Restart timer is - in second',
  `address_families_by_peer` int(11) DEFAULT NULL,
  `end_of_rib_send` int(11) DEFAULT NULL COMMENT 'End-of-RIB send',
  `end_of_rib_received` int(11) DEFAULT NULL COMMENT 'End-of-Rib received',
  `inq_deph` int(11) DEFAULT NULL COMMENT 'Inq depth is - Number of messages in the input queue.',
  `outq_deph` int(11) DEFAULT NULL COMMENT 'Outq depth is - Number of messages in the output queue.',
  `opens_sent` int(11) DEFAULT NULL COMMENT 'Message statistics: Opens - Sent',
  `opens_rcvd` int(11) DEFAULT NULL COMMENT 'Message statistics: Opens - Received',
  `notifications_sent` int(11) DEFAULT NULL COMMENT 'Message statistics: Notifications - sent',
  `notifications_rcvd` int(11) DEFAULT NULL COMMENT 'Message statistics: Notifications - Received',
  `updates_sent` int(11) DEFAULT NULL COMMENT 'Message statistics: updates - sent',
  `updates_rcvd` int(11) DEFAULT NULL COMMENT 'Message statistics: updates - received',
  `keepalives_sent` int(11) DEFAULT NULL COMMENT 'Message statistics: Keepalives - Sent',
  `keepalives_rcvd` int(11) DEFAULT NULL COMMENT 'Message statistics: Keepalives - Received',
  `route_refresh_sent` int(11) DEFAULT NULL COMMENT 'Message statistics: Route Refresh - Sent',
  `route_refresh_rcvd` int(11) DEFAULT NULL COMMENT 'Message statistics: Route Refresh - Received',
  `capability_sent` int(11) DEFAULT NULL COMMENT 'Message statistics: Capability - Sent',
  `capability_rcvd` int(11) DEFAULT NULL COMMENT 'Message statistics: Capability - Received',
  `minimum_time_between_advertisement_runs` int(11) DEFAULT NULL COMMENT 'Minimum time between advertisement runs - in seconds - Time, in seconds, between advertisement transmissions.',
  `address_family` int(11) DEFAULT NULL COMMENT 'For address family: - Address family to which the following fields refer.',
  `inbound_soft_reconfiguration_allowed` binary(1) DEFAULT NULL,
  `community_attribute_sent_to_this_neighbor_both` binary(1) DEFAULT NULL,
  `inbound_path_policy_configured` binary(1) DEFAULT NULL,
  `outbound_path_policy_configured` binary(1) DEFAULT NULL,
  `incoming_update_network_filter_list` varchar(45) DEFAULT NULL,
  `outgoing_update_network_filter_list` varchar(45) DEFAULT NULL,
  `incoming_update_as_path_filter_list` varchar(45) DEFAULT NULL,
  `outgoing_update_as_path_filter_list` varchar(45) DEFAULT NULL,
  `incoming_update_prefix_filter_list` varchar(45) DEFAULT NULL,
  `outgoing_update_prefix_filter_list` varchar(45) DEFAULT NULL,
  `as_path_is_propagated_unchanged_to_this_neighbor` binary(1) DEFAULT NULL,
  `next_hop_is_propagated_unchanged_to_this_neighbor` binary(1) DEFAULT NULL,
  `accepted_prefixes` int(11) DEFAULT NULL,
  `connection_established` int(11) DEFAULT NULL COMMENT 'Connections established - Number of times a TCP and BGP connection has been successfully established.',
  `dropped` int(11) DEFAULT NULL COMMENT 'Dropped - Number of times that a valid session has failed or been taken down.',
  `last_reset` int(11) DEFAULT NULL COMMENT 'Last reset - Time, in hh:mm:ss, since this peering session was last reset. The reason for the reset is displayed on this line. (in Unix Epoch time)',
  `last_reset_motivation` int(11) DEFAULT NULL,
  `next_connect_timer` int(11) DEFAULT NULL COMMENT '''Next connect timer due in '' em segundos',
  `local_host` int(11) DEFAULT NULL,
  `local_port` int(11) DEFAULT NULL COMMENT 'Local port -  BGP port number 179 no lado do servidor da sessao',
  `foreign_host` int(11) DEFAULT NULL,
  `foreign_port` int(11) DEFAULT NULL,
  `nexthop` int(11) DEFAULT NULL,
  `nexthop_global` int(11) DEFAULT NULL,
  `nexthop_local` int(11) DEFAULT NULL,
  `bgp_connection` int(11) DEFAULT NULL,
  `next_start_timer` int(11) DEFAULT NULL COMMENT '''Next start timer due in '' em segundos',
  `read_thread` binary(1) DEFAULT NULL,
  `write_thread` binary(1) DEFAULT NULL,
  PRIMARY KEY (`idlooking_glass`),
  KEY `fk_looking_glass_origin_code1_idx` (`origin_code`),
  KEY `fk_looking_glass_as1_idx` (`remote_as`),
  KEY `fk_looking_glass_as2_idx` (`local_as`),
  KEY `fk_looking_glass_bgp_state1_idx` (`bgp_state`),
  KEY `fk_looking_glass_neighbor_capabilities1_idx` (`four_byte_as`),
  KEY `fk_looking_glass_neighbor_capabilities2_idx` (`route_refresh`),
  KEY `fk_looking_glass_neighbor_capabilities3_idx` (`address_family_ipv4_unicast`),
  KEY `fk_looking_glass_neighbor_capabilities4_idx` (`graceful_restart_capability`),
  KEY `fk_looking_glass_address_families_by_peer1_idx` (`address_families_by_peer`),
  KEY `fk_looking_glass_end_of_rib1_idx` (`end_of_rib_send`),
  KEY `fk_looking_glass_end_of_rib2_idx` (`end_of_rib_received`),
  KEY `fk_looking_glass_address_family1_idx` (`address_family`),
  KEY `fk_looking_glass_file1_idx` (`idfile`),
  KEY `fk_looking_glass_bgp_connection1_idx` (`bgp_connection`),
  KEY `fk_looking_glass_last_reset_motivation1_idx` (`last_reset_motivation`),
  KEY `fk_looking_glass_ip1_idx` (`bgp_neighbor`),
  KEY `fk_looking_glass_ip2_idx` (`remote_router_id`),
  KEY `fk_looking_glass_ip3_idx` (`local_host`),
  KEY `fk_looking_glass_ip4_idx` (`foreign_host`),
  KEY `fk_looking_glass_ip5_idx` (`nexthop`),
  KEY `fk_looking_glass_ip6_idx` (`nexthop_global`),
  KEY `fk_looking_glass_ip7_idx` (`nexthop_local`),
  KEY `fk_looking_glass_neighbor_capabilities5_idx` (`address_family_ipv6_unicast`),
  KEY `fk_looking_glass_neighbor_capabilities6_idx` (`address_family_ipv4_multicast`),
  KEY `fk_looking_glass_neighbor_capabilities7_idx` (`address_family_ipv6_multicast`),
  CONSTRAINT `fk_looking_glass_address_families_by_peer1` FOREIGN KEY (`address_families_by_peer`) REFERENCES `address_families_by_peer` (`idaddress_families_by_peer`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_address_family1` FOREIGN KEY (`address_family`) REFERENCES `address_family` (`idaddress_family`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_as1` FOREIGN KEY (`remote_as`) REFERENCES `ases` (`idases`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_as2` FOREIGN KEY (`local_as`) REFERENCES `ases` (`idases`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_bgp_connection1` FOREIGN KEY (`bgp_connection`) REFERENCES `bgp_connection` (`idbgp_connection`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_bgp_state1` FOREIGN KEY (`bgp_state`) REFERENCES `bgp_state` (`idbgp_state`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_end_of_rib1` FOREIGN KEY (`end_of_rib_send`) REFERENCES `end_of_rib` (`idend_of_rib`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_end_of_rib2` FOREIGN KEY (`end_of_rib_received`) REFERENCES `end_of_rib` (`idend_of_rib`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_file1` FOREIGN KEY (`idfile`) REFERENCES `file` (`idfile`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_ip1` FOREIGN KEY (`bgp_neighbor`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_ip2` FOREIGN KEY (`remote_router_id`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_ip3` FOREIGN KEY (`local_host`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_ip4` FOREIGN KEY (`foreign_host`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_ip5` FOREIGN KEY (`nexthop`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_ip6` FOREIGN KEY (`nexthop_global`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_ip7` FOREIGN KEY (`nexthop_local`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_last_reset_motivation1` FOREIGN KEY (`last_reset_motivation`) REFERENCES `last_reset_motivation` (`idlast_reset_motivation`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_neighbor_capabilities1` FOREIGN KEY (`four_byte_as`) REFERENCES `neighbor_capabilities` (`idneighbor_capabilities`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_neighbor_capabilities2` FOREIGN KEY (`route_refresh`) REFERENCES `neighbor_capabilities` (`idneighbor_capabilities`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_neighbor_capabilities3` FOREIGN KEY (`address_family_ipv4_unicast`) REFERENCES `neighbor_capabilities` (`idneighbor_capabilities`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_neighbor_capabilities4` FOREIGN KEY (`graceful_restart_capability`) REFERENCES `neighbor_capabilities` (`idneighbor_capabilities`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_neighbor_capabilities5` FOREIGN KEY (`address_family_ipv6_unicast`) REFERENCES `neighbor_capabilities` (`idneighbor_capabilities`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_neighbor_capabilities6` FOREIGN KEY (`address_family_ipv4_multicast`) REFERENCES `neighbor_capabilities` (`idneighbor_capabilities`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_neighbor_capabilities7` FOREIGN KEY (`address_family_ipv6_multicast`) REFERENCES `neighbor_capabilities` (`idneighbor_capabilities`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_looking_glass_origin_code1` FOREIGN KEY (`origin_code`) REFERENCES `origin_code` (`idorigin_code`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3085711 DEFAULT CHARSET=utf8 COMMENT='Imagem do looking glass de cada IX no tempo t. Cada registro armazena infomacoes de peering com cada neighbor no tempo t';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `neighbor_capabilities`
--

DROP TABLE IF EXISTS `neighbor_capabilities`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `neighbor_capabilities` (
  `idneighbor_capabilities` int(11) NOT NULL AUTO_INCREMENT,
  `neighbor_capabilities` varchar(45) NOT NULL COMMENT 'BGP capabilities advertised and received from this neighbor. “advertised and received” is displayed when a capability is successfully exchanged between two routers.',
  PRIMARY KEY (`idneighbor_capabilities`),
  UNIQUE KEY `neighbor_capabilities_UNIQUE` (`neighbor_capabilities`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COMMENT='BGP capabilities advertised and received from this neighbor. “advertised and received” is displayed when a capability is successfully exchanged between two routers.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `origin_code`
--

DROP TABLE IF EXISTS `origin_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `origin_code` (
  `idorigin_code` int(11) NOT NULL AUTO_INCREMENT,
  `origin_code` varchar(45) NOT NULL COMMENT '“internal link” is displayed for iBGP neighbors; “external link” is displayed for external BGP (eBGP) neighbors.',
  PRIMARY KEY (`idorigin_code`),
  UNIQUE KEY `origin_code_UNIQUE` (`origin_code`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='Codigo das origens das rotas BGP - “internal link” is displayed for iBGP neighbors; “external link” is displayed for external BGP (eBGP) neighbors.';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `routes`
--

DROP TABLE IF EXISTS `routes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `routes` (
  `idroute` int(11) NOT NULL AUTO_INCREMENT,
  `idfile` int(11) NOT NULL,
  `network` int(11) NOT NULL,
  `nexthop` int(11) NOT NULL,
  `supressed` binary(1) DEFAULT NULL,
  `dumped` binary(1) DEFAULT NULL,
  `history` binary(1) DEFAULT NULL,
  `valid` binary(1) DEFAULT NULL,
  `best` binary(1) DEFAULT NULL,
  `internal` binary(1) DEFAULT NULL,
  `rib_failure` binary(1) DEFAULT NULL,
  `stale` binary(1) DEFAULT NULL,
  `removed` binary(1) DEFAULT NULL,
  `oc_igp` binary(1) DEFAULT NULL,
  `oc_egp` binary(1) DEFAULT NULL,
  `oc_incomplete` binary(1) DEFAULT NULL,
  `metric` int(11) DEFAULT NULL,
  `loc_prf` int(11) DEFAULT NULL,
  `weight` int(11) NOT NULL,
  PRIMARY KEY (`idroute`),
  KEY `fk_idfile1` (`idfile`),
  KEY `fk_network1` (`network`),
  KEY `fk_nexthop1` (`nexthop`),
  CONSTRAINT `fk_idfile1` FOREIGN KEY (`idfile`) REFERENCES `file` (`idfile`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_network1` FOREIGN KEY (`network`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_nexthop1` FOREIGN KEY (`nexthop`) REFERENCES `ip` (`idip`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-05-16  9:29:21
