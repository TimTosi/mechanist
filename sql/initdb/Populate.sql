CREATE DATABASE IF NOT EXISTS fishfinger;

CREATE TABLE IF NOT EXISTS fishfinger.components (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`),
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Insert test data.
--
INSERT INTO fishfinger.components
(name)
VALUES
('Kakarotto'),
('Bejita'),
('Burori');
