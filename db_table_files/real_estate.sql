SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Database: `real_estate`
--

-- --------------------------------------------------------

--
-- Table structure for table 'estate_facts'
--

CREATE TABLE 'estate_facts' (
  'serial_number' int(11) NOT NULL,
  'assessed_value' bigint(20) NOT NULL,
  'sale_amount' bigint(20) NOT NULL,
  'sales_ratio' float NOT NULL,
  'year_id' int(11) NOT NULL,
  'town_id' int(11) NOT NULL,
  'type_id' int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'list_year'
--

CREATE TABLE 'list_year' (
  'year_id' int(11) NOT NULL,
  'year' int(4) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'residential_type'
--

CREATE TABLE 'residential_type' (
  'type_id' int(11) NOT NULL,
  'type_name' varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table 'towns'
--

CREATE TABLE 'towns' (
  'town_id' int(11) NOT NULL,
  'town_name' varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table 'estate_facts'
--
ALTER TABLE 'estate_facts'
  ADD KEY 'town_id' ('town_id'),
  ADD KEY 'type_id' ('type_id'),
  ADD KEY 'year_id' ('year_id');

--
-- Indexes for table 'list_year'
--
ALTER TABLE 'list_year'
  ADD PRIMARY KEY ('year_id');

--
-- Indexes for table 'residential_type'
--
ALTER TABLE 'residential_type'
  ADD PRIMARY KEY ('type_id');

--
-- Indexes for table 'towns'
--
ALTER TABLE 'towns'
  ADD PRIMARY KEY ('town_id');


--
-- Constraints for table 'estate_facts'
--
ALTER TABLE 'estate_facts'
  ADD CONSTRAINT 'estate_facts_ibfk_1' FOREIGN KEY ('town_id') REFERENCES towns ('town_id'),
  ADD CONSTRAINT 'estate_facts_ibfk_2' FOREIGN KEY ('type_id') REFERENCES 'residential_type' ('type_id'),
  ADD CONSTRAINT 'estate_facts_ibfk_3' FOREIGN KEY ('year_id') REFERENCES 'list_year' ('year_id');
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
