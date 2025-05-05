-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Apr 28, 2025 at 11:47 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `healthcare_db2`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_user'),
(22, 'Can change user', 6, 'change_user'),
(23, 'Can delete user', 6, 'delete_user'),
(24, 'Can view user', 6, 'view_user'),
(25, 'Can add medical', 7, 'add_medical'),
(26, 'Can change medical', 7, 'change_medical'),
(27, 'Can delete medical', 7, 'delete_medical'),
(28, 'Can view medical', 7, 'view_medical'),
(29, 'Can add profile', 8, 'add_profile'),
(30, 'Can change profile', 8, 'change_profile'),
(31, 'Can delete profile', 8, 'delete_profile'),
(32, 'Can view profile', 8, 'view_profile'),
(33, 'Can add ment', 9, 'add_ment'),
(34, 'Can change ment', 9, 'change_ment'),
(35, 'Can delete ment', 9, 'delete_ment'),
(36, 'Can view ment', 9, 'view_ment'),
(37, 'Can add diagnosis', 10, 'add_diagnosis'),
(38, 'Can change diagnosis', 10, 'change_diagnosis'),
(39, 'Can delete diagnosis', 10, 'delete_diagnosis'),
(40, 'Can view diagnosis', 10, 'view_diagnosis');

-- --------------------------------------------------------

--
-- Table structure for table `core_medical`
--

CREATE TABLE `core_medical` (
  `id` bigint(20) NOT NULL,
  `s1` varchar(255) DEFAULT NULL,
  `s2` varchar(255) DEFAULT NULL,
  `s3` varchar(255) DEFAULT NULL,
  `s4` varchar(255) DEFAULT NULL,
  `s5` varchar(255) DEFAULT NULL,
  `disease` varchar(200) NOT NULL,
  `medicine` varchar(200) NOT NULL,
  `created_on` datetime(6) NOT NULL,
  `doctor_id` bigint(20) DEFAULT NULL,
  `patient_id` bigint(20) NOT NULL,
  `full_name` varchar(200) DEFAULT NULL,
  `disease_by_doctor` text DEFAULT NULL,
  `checked_by_id` bigint(20) DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT 0,
  `additional_symptoms` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional_symptoms`))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `core_medical`
--

INSERT INTO `core_medical` (`id`, `s1`, `s2`, `s3`, `s4`, `s5`, `disease`, `medicine`, `created_on`, `doctor_id`, `patient_id`, `full_name`, `disease_by_doctor`, `checked_by_id`, `is_approved`, `additional_symptoms`) VALUES
(41, 'dizziness', 'headache', 'breathlessness', 'chest_pain', 'fatigue', 'Hypertension ', 'See Doctor', '2024-11-18 20:18:58.006291', NULL, 52, '', NULL, 44, 0, NULL),
(42, 'breathlessness', 'cough', 'chest_pain', 'fatigue', 'continuous_sneezing', 'Heart attack', 'See Doctor', '2024-11-18 20:28:12.175005', NULL, 53, '', NULL, 44, 0, NULL),
(43, 'continuous_feel_of_urine', 'dehydration', 'fatigue', 'watering_from_eyes', 'weight_loss', 'Jaundice', 'See Doctor', '2024-11-18 20:39:28.145335', NULL, 54, '', 'Acne', 76, 1, NULL),
(44, 'fatigue', 'headache', 'continuous_sneezing', 'indigestion', 'muscle_weakness', 'Allergy', 'Leet Syrup 60ml', '2024-11-18 21:37:09.720650', NULL, 55, '', NULL, NULL, 0, NULL),
(45, 'chest_pain', 'breathlessness', 'fatigue', 'swelling_joints', 'fast_heart_rate', 'Pneumonia', 'See Doctor', '2024-11-18 21:43:23.166054', NULL, 56, '', NULL, NULL, 0, NULL),
(46, 'weight_gain', 'fatigue', 'drying_and_tingling_lips', 'cold_hands_and_feets', 'depression', 'Migraine', 'Pacimol M 5/500mg Tablet 10\'S', '2024-11-18 21:48:25.607939', NULL, 57, '', NULL, NULL, 0, NULL),
(47, 'continuous_sneezing', 'itching', 'watering_from_eyes', 'cough', 'headache', 'Allergy', 'Histafree M Tablet 10\'S', '2024-11-18 21:55:20.054572', NULL, 58, '', NULL, NULL, 0, NULL),
(48, 'headache', 'visual_disturbances', 'dizziness', 'fatigue', 'history_of_alcohol_consumption', 'Alcoholic hepatitis', 'See Doctor', '2024-11-18 22:03:18.453582', NULL, 59, '', NULL, NULL, 0, NULL),
(49, 'headache', 'indigestion', 'fatigue', 'continuous_sneezing', 'runny_nose', 'Allergy', 'HYNOSURE 10mg Tablet 10\'sHynosure 25Mg Tablet 10\'s', '2024-11-18 22:11:01.337094', NULL, 60, '', NULL, NULL, 0, NULL),
(50, 'continuous_sneezing', 'runny_nose', 'itching', 'watering_from_eyes', 'throat_irritation', 'Allergy', 'Cetiz 10mg Tablet 10\'SCetiz 5mg Syrup 30ml', '2024-11-18 22:16:21.637504', NULL, 61, '', NULL, NULL, 0, NULL),
(51, 'back_pain', 'movement_stiffness', 'knee_pain', 'joint_pain', 'muscle_pain', 'Malaria', 'Gamma I.V. 500 mg Injection 10mlGamma I.V. 5000 mg Infusion 100ml', '2024-11-18 22:25:47.765159', NULL, 62, '', NULL, NULL, 0, NULL),
(52, 'headache', 'fatigue', 'indigestion', 'mild_fever', 'muscle_weakness', 'Peptic ulcer diseae', 'See Doctor', '2024-11-18 22:33:30.423335', NULL, 63, '', NULL, NULL, 0, NULL),
(53, 'chest_pain', 'breathlessness', 'dizziness', 'swelling_joints', 'fatigue', 'Hypertension ', 'See Doctor', '2024-11-18 22:38:40.932808', NULL, 64, '', NULL, NULL, 0, NULL),
(54, 'restlessness', 'lack_of_concentration', 'dizziness', 'fast_heart_rate', 'painful_walking', 'Pneumonia', 'See Doctor', '2024-11-18 22:44:31.935599', NULL, 65, '', NULL, NULL, 0, NULL),
(55, 'headache', 'indigestion', 'breathlessness', 'continuous_sneezing', 'runny_nose', 'Allergy', '', '2024-11-18 22:53:13.003293', NULL, 66, '', NULL, NULL, 0, NULL),
(56, 'abnormal_menstruation', 'weight_gain', 'painful_walking', 'anxiety', 'bruising', 'Hyperthyroidism', 'See Doctor', '2024-11-18 22:58:49.619639', NULL, 67, '', NULL, NULL, 0, NULL),
(57, 'cough', 'breathlessness', 'chest_pain', 'cold_hands_and_feets', 'dizziness', 'Hypertension ', 'See Doctor', '2024-11-18 23:04:46.619417', NULL, 68, '', NULL, NULL, 0, NULL),
(58, 'cramps', 'dark_urine', 'continuous_feel_of_urine', 'dizziness', 'fatigue', 'Cervical spondylosis', 'See Doctor', '2024-11-18 23:10:08.305156', NULL, 69, '', NULL, NULL, 0, NULL),
(59, 'abdominal_pain', 'cold_hands_and_feets', 'distention_of_abdomen', 'fatigue', 'high_fever', 'AIDS', '', '2024-11-18 23:14:26.796923', NULL, 70, '', NULL, NULL, 0, NULL),
(60, 'dehydration', 'excessive_hunger', 'continuous_sneezing', 'continuous_feel_of_urine', 'headache', 'Allergy', '', '2024-11-18 23:17:39.785514', NULL, 71, '', NULL, NULL, 0, NULL),
(61, 'runny_nose', 'itching', 'skin_rash', 'cramps', 'continuous_sneezing', 'Allergy', '', '2024-11-21 13:35:42.789334', NULL, 53, '', NULL, NULL, 0, NULL),
(62, 'headache', 'nausea', 'vomiting', 'neck_pain', 'dizziness', 'Cervical spondylosis', 'See Doctor', '2024-11-21 13:45:06.465459', NULL, 53, '', NULL, NULL, 0, NULL),
(63, 'headache', 'nausea', 'vomiting', 'congestion', 'dizziness', 'Cervical spondylosis', 'See Doctor', '2024-11-21 13:45:43.687178', NULL, 53, '', NULL, NULL, 0, NULL),
(64, 'headache', 'nausea', 'vomiting', 'congestion', 'dizziness', 'Cervical spondylosis', 'See Doctor', '2024-11-21 13:45:48.719751', NULL, 53, '', NULL, NULL, 0, NULL),
(65, 'runny_nose', 'cough', 'itching', 'continuous_sneezing', 'breathlessness', 'Common Cold', 'See Doctor', '2024-12-14 13:35:49.262596', NULL, 62, '', NULL, NULL, 0, NULL),
(66, 'anxiety', 'bladder_discomfort', 'brittle_nails', 'chills', 'belly_pain', 'Allergy', '', '2025-02-26 09:00:41.591158', NULL, 64, '', NULL, NULL, 0, NULL),
(67, 'anxiety', 'bladder_discomfort', 'brittle_nails', 'chills', 'belly_pain', 'Allergy', '', '2025-02-26 09:00:51.094160', NULL, 64, '', NULL, NULL, 0, NULL),
(68, 'anxiety', 'bladder_discomfort', 'brittle_nails', 'chills', 'belly_pain', 'Allergy', '', '2025-02-26 09:01:17.279124', NULL, 64, '', NULL, NULL, 0, NULL),
(69, 'anxiety', 'belly_pain', 'brittle_nails', 'chest_pain', 'acidity', 'Heart attack', '', '2025-02-26 09:03:04.771316', NULL, 64, '', NULL, NULL, 0, NULL),
(70, 'anxiety', 'belly_pain', 'brittle_nails', 'chest_pain', 'acidity', 'Heart attack', '', '2025-02-26 09:04:05.855560', NULL, 64, '', NULL, NULL, 0, NULL),
(71, 'anxiety', 'belly_pain', 'brittle_nails', 'chest_pain', 'acidity', 'Heart attack', '', '2025-02-26 09:04:23.077305', NULL, 64, '', NULL, NULL, 0, NULL),
(72, 'anxiety', 'belly_pain', 'brittle_nails', 'chest_pain', 'acidity', 'Heart attack', '', '2025-02-26 09:05:06.502374', NULL, 64, '', NULL, NULL, 0, NULL),
(73, 'bladder_discomfort', 'bloody_stool', 'burning_micturition', 'chills', 'altered_sensorium', 'Allergy', '', '2025-02-26 09:05:18.279648', NULL, 44, '', NULL, NULL, 0, NULL),
(74, 'blackheads', 'acidity', 'belly_pain', 'breathlessness', 'brittle_nails', 'Acne', 'Fexolife 180mg Tablet 10\'S', '2025-02-26 09:06:38.237833', NULL, 64, '', NULL, 44, 1, NULL),
(75, 'bladder_discomfort', 'brittle_nails', 'cold_hands_and_feets', 'cold_hands_and_feets', 'coma', 'Hepatitis E', 'See Doctor', '2025-02-26 09:28:07.791828', NULL, 64, '', NULL, 44, 1, NULL),
(76, 'blackheads', 'bloody_stool', 'bloody_stool', 'breathlessness', 'burning_micturition', 'Acne', 'Fexolife 180mg Tablet 10\'S', '2025-02-26 09:54:32.851231', NULL, 64, '', 'Acne', 44, 1, NULL),
(77, 'belly_pain', 'throat_irritation', 'chest_pain', 'abdominal_pain', 'coma', 'Hepatitis E', 'See Doctor', '2025-03-19 10:01:56.055330', NULL, 53, '', NULL, 44, 1, NULL),
(78, 'abdominal_pain', 'chest_pain', 'headache', 'fatigue', 'high_fever', 'Heart attack', 'See Doctor', '2025-03-19 10:06:21.829315', NULL, 53, '', NULL, NULL, 0, NULL),
(93, 'blackheads', 'blackheads', 'bloody_stool', 'breathlessness', 'burning_micturition', 'Acne', 'Fextral 120mg Tablet 10\'SFextral 180mg Tablet 10\'S', '2025-04-14 21:17:02.679856', NULL, 54, '', 'Acne', NULL, 0, NULL),
(94, 'fast_heart_rate', 'chest_pain', 'congestion', 'chills', 'chest_pain', 'Allergy', 'Fenixa M Tablet 10\'S', '2025-04-14 21:48:51.438250', NULL, 54, '', 'Allergy', NULL, 0, NULL),
(138, 'foul_smell_of urine', 'brittle_nails', '', '', '', 'Heart attack', '', '2025-04-28 00:30:27.072145', NULL, 54, '', NULL, NULL, 0, '[]'),
(139, 'blister', 'brittle_nails', '', '', '', 'Impetigo', '', '2025-04-28 21:19:58.232763', NULL, 54, '', NULL, NULL, 0, '[]'),
(140, 'belly_pain', 'blood_in_sputum', '', '', '', 'Tuberculosis', '', '2025-04-28 21:45:00.964461', NULL, 54, '', NULL, NULL, 0, '[]');

-- --------------------------------------------------------

--
-- Table structure for table `core_ment`
--

CREATE TABLE `core_ment` (
  `id` bigint(20) NOT NULL,
  `approved` tinyint(1) NOT NULL,
  `time` varchar(200) DEFAULT NULL,
  `ment_day` datetime(6) DEFAULT NULL,
  `created_on` datetime(6) NOT NULL,
  `doctor_id` bigint(20) DEFAULT NULL,
  `medical_id` bigint(20) DEFAULT NULL,
  `patient_id` bigint(20) NOT NULL,
  `done` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `core_ment`
--

INSERT INTO `core_ment` (`id`, `approved`, `time`, `ment_day`, `created_on`, `doctor_id`, `medical_id`, `patient_id`, `done`) VALUES
(11, 1, '13:00 PM', '2022-12-12 00:00:00.000000', '2024-11-18 20:19:17.822856', 44, 41, 52, 1),
(12, 1, '02:42', '2025-04-29 23:42:00.000000', '2024-11-18 20:28:42.749030', 43, 42, 53, 1),
(13, 1, '2', '2022-11-29 22:00:00.000000', '2024-11-18 20:39:32.930421', 43, 43, 54, 1),
(14, 1, '16:16', '2025-04-30 13:16:00.000000', '2024-11-18 21:37:17.121248', NULL, 44, 55, 1),
(15, 1, '02:44', '2025-04-29 23:44:00.000000', '2024-11-18 21:43:28.645314', 43, 45, 56, 1),
(16, 1, '02:38', '2025-04-29 21:00:00.000000', '2024-11-18 21:48:29.468545', 43, 46, 57, 0),
(17, 1, '15:06', '2025-04-30 12:06:00.000000', '2024-11-18 21:55:24.215862', NULL, 47, 58, 0),
(18, 1, '21:15', '2025-04-30 18:15:00.000000', '2024-11-18 22:03:27.911825', NULL, 48, 59, 0),
(19, 1, '02:44', '2025-04-28 23:44:00.000000', '2024-11-18 22:11:06.706417', 43, 49, 60, 0),
(20, 1, '15:12', '2025-04-30 12:12:00.000000', '2024-11-18 22:16:25.394403', NULL, 50, 61, 0),
(21, 1, '21:17', '2025-04-30 18:17:00.000000', '2024-11-18 22:25:49.777767', NULL, 51, 62, 0),
(22, 1, '16:13', '2025-04-30 13:13:00.000000', '2024-11-18 22:33:51.416855', NULL, 52, 63, 0),
(23, 1, '16:38', '2025-04-29 21:00:00.000000', '2024-11-18 22:38:45.461092', 43, 53, 64, 0),
(24, 1, '14:40', '2025-04-23 21:00:00.000000', '2024-11-18 22:44:35.335410', 43, 54, 65, 0),
(25, 1, '14:39', '2025-04-22 21:00:00.000000', '2024-11-18 22:53:16.206063', 43, 55, 66, 0),
(26, 1, '20:41', '2025-04-29 21:00:00.000000', '2024-11-18 22:58:53.465764', 43, 56, 67, 0),
(27, 1, '16:05', '2025-04-30 13:05:00.000000', '2024-11-18 23:04:50.821101', NULL, 57, 68, 0),
(28, 1, '20:40', '2025-04-29 21:00:00.000000', '2024-11-18 23:10:13.506969', 43, 58, 69, 0),
(29, 1, '15:34', '2025-04-29 21:00:00.000000', '2024-11-18 23:14:34.091744', 43, 59, 70, 0),
(30, 1, '2:20', '2025-04-28 21:00:00.000000', '2024-11-18 23:17:44.162576', 43, 60, 71, 0),
(31, 1, '10:00 PM', '2022-12-12 00:00:00.000000', '2024-11-21 13:38:39.530629', 44, 61, 53, 0),
(33, 1, '07:56', '2025-04-26 04:56:00.000000', '2025-04-27 23:48:20.944796', 43, 130, 54, 1),
(41, 1, '21:04', '2025-04-30 18:04:00.000000', '2025-04-28 00:30:29.289154', NULL, 138, 54, 1),
(42, 1, '13:26', '2025-04-30 10:26:00.000000', '2025-04-28 21:20:00.908103', 43, 139, 54, 1),
(43, 0, NULL, NULL, '2025-04-28 21:45:49.283311', NULL, 140, 54, 0);

-- --------------------------------------------------------

--
-- Table structure for table `core_profile`
--

CREATE TABLE `core_profile` (
  `id` bigint(20) NOT NULL,
  `avatar` varchar(100) NOT NULL,
  `birth_date` date NOT NULL,
  `region` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `country` varchar(255) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `medical_history` text DEFAULT NULL,
  `symptoms` text DEFAULT NULL,
  `allergies` text DEFAULT NULL,
  `medications` text DEFAULT NULL,
  `family_history` text DEFAULT NULL,
  `lifestyle` text DEFAULT NULL,
  `full_name` varchar(200) DEFAULT NULL,
  `specialty` varchar(100) DEFAULT NULL,
  `license_number` varchar(100) DEFAULT NULL,
  `experience_years` int(11) DEFAULT NULL,
  `medical_school` varchar(200) DEFAULT NULL,
  `hospital_affiliation` varchar(200) DEFAULT NULL,
  `contact_info` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `core_profile`
--

INSERT INTO `core_profile` (`id`, `avatar`, `birth_date`, `region`, `gender`, `country`, `user_id`, `medical_history`, `symptoms`, `allergies`, `medications`, `family_history`, `lifestyle`, `full_name`, `specialty`, `license_number`, `experience_years`, `medical_school`, `hospital_affiliation`, `contact_info`) VALUES
(24, 'avatars/drsarahmitchell.jpg', '1982-04-15', 'NYC', 'Female', 'USA', 42, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Sarah Mitchell', 'cardiology', 'C-12345-NY', 18, 'Harvard Medical School', 'New York Presbyterian', '+1 555 678 1234'),
(25, 'avatars/dralirahman.jpg', '1979-11-12', 'Dubai', 'Male', 'UAE', 43, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Ali Rahman', 'orthopedic_surgery', 'O-56789-DU', 20, 'Royal College of Surgeons ', 'Dubai Health Hospital', '+971 50 123 456'),
(26, 'avatars/drelenapetrova.jpg', '1985-06-30', 'Moscow ', 'Female', 'Russia ', 44, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Elena Petrova', 'dermatology', 'D-34567-MO', 15, 'Moscow State University', 'Central Clinical Hospital', '+7 916 789 456'),
(27, 'avatars/Drjavierlopez.jfif', '1974-09-05', 'Madrid ', 'Male', 'Spain', 45, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Javier Lopez', 'neurology', 'N-45678-MD', 25, 'University of Barcelona ', 'Hospital Universitario ', '+34 600 456 789'),
(28, 'avatars/DrMayaPatel.jpg', '1990-02-20', 'Delhi', 'Female', 'India', 46, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Maya Patel', 'pediatrics', 'P-87654-DL', 10, 'All India Institute ', 'Apollo Hospital ', '+91 989 765 432'),
(29, 'avatars/DrOmarHassan.jpg', '1980-01-01', 'Cairo ', 'Male', 'Egypt', 47, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Omar Hassan', 'gastroenterology', 'G-65432-CA', 17, 'Cairo University', 'Kasr Al Ainy Hospital', '+20 101 234 567'),
(30, 'avatars/DrAnnaSchmidt.jfif', '1987-08-19', 'Berlin', 'Female', 'Germany', 48, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Anna Schmidt', 'endocrinology', 'E-54321_BR', 12, 'Heidelberg University', 'Charite Berlin Hospital', '+49 151 234 567'),
(31, 'avatars/DrEthanClark.jpg', '1988-03-28', 'London', 'Male', 'UK', 49, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Ethan Clark', 'radiology', 'R-23456-LN', 11, 'Cambridge University', 'St Thomas Hospital', '+44 770 456 789'),
(32, 'avatars/DrYukiTanaka.jfif', '1983-11-14', 'Tokyo', 'Female', 'Japan', 50, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Yuki Tanaka', 'oncology', 'O-32145-TK', 16, 'University of Tokyo', 'Tokyo Medical Center', '+81 70 234 5678'),
(33, 'avatars/DrCarlosSantos.jfif', '1986-05-02', 'Rio de Janeiro ', 'Male', 'Brazil', 51, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Carlos Santos', 'internal_medicine', 'IM-56789-RJ', 13, 'Federal University of Rio', 'Hospital das Clinicas', '+55 21 234 5678'),
(34, 'avatars/John_Doe.jfif', '1985-12-07', 'New York', 'Male', 'USA', 52, 'Diagnosed with hypertension five years ago; managed with medication.', NULL, 'Penicillin', 'Lisinopril', 'Hypertension', 'Non-smoker, Non-alcoholic, moderate exercise', 'John Doe', '', '', NULL, '', '', '+1 202 555 0143'),
(35, 'avatars/Jane_Smith.jfif', '1992-02-22', 'London', 'Female', 'UK', 53, 'Suffers from mild asthma since childhood; controlled with an inhaler.', NULL, 'Pollen', 'Albuterol', 'Asthma', 'Non-smoker, Alcoholic, regular exercise', 'Jane Smith', '', '', NULL, '', '', '+44 20 7946 0958'),
(36, 'avatars/Ahmed_Khan.jfif', '1988-11-03', 'Abudhabi', 'Male', 'UAE', 54, 'Type 2 diabetes diagnosed six years ago; follows a prescribed insulin regimen.', '', 'None', 'Insulin', 'Diabetes', 'Occasional smoker, sedentary', 'Ahmed Khan', '', '', NULL, '', '', '+971 55 123 4567'),
(37, 'avatars/Maria.jfif', '1995-09-10', 'Madrid ', 'Female', 'Spain', 55, 'No significant medical history; generally in good health.', NULL, 'Gluten', 'None', 'None', 'Non-smoker, Non_alcoholic, active lifestyle', 'Maria Gonzalez', '', '', NULL, '', '', '+34 600 123 456'),
(38, 'avatars/David.jpg', '1983-05-27', 'Sydney ', 'Male', 'Australia', 56, 'Underwent heart surgery ten years ago due to a congenital heart defect.', NULL, 'Shellfish', 'Warfarin', 'Heart disease', 'Non-smoker, Alcoholic, light exercise', 'David Johnson', '', '', NULL, '', '', '+61 400 123 789'),
(39, 'avatars/Fatima_Ali.jfif', '1990-12-18', 'Mumbai', 'Female', 'India', 57, 'Has a thyroid disorder diagnosed three years ago; treated with daily medication.', NULL, 'None', 'Levothyroxine', 'None', 'Non-smoker, moderate exercise', 'Fatima Ali', '', '', NULL, '', '', '+91 98765 43210'),
(40, 'avatars/Micheal_Brown.jfif', '1977-08-09', 'Denver', 'Male', 'USA', 58, 'No significant medical history; experiences seasonal allergies.', NULL, 'Nuts', 'None', 'None', 'Non-smoker, active lifestyle', 'Michael Brown', '', '', NULL, '', '', '+1 303 555 0199'),
(41, 'avatars/sophie.jpg', '1998-06-15', 'Paris', 'Female', 'France', 59, 'Suffers from chronic migraines triggered by stress and specific foods.', NULL, 'Lactose', 'Sumatriptan', 'Migraine', 'Non-smoker, Alcoholic, light exercise', 'Sophie Dubois', '', '', NULL, '', '', '+33 6 12 34 56 78'),
(42, 'avatars/carlos_silva.jfif', '1985-03-22', 'São Paulo', 'Male', 'Brazil', 60, 'No notable medical conditions; occasional colds and flu.', NULL, 'None', 'None', 'Diabetes', 'Non-smoker, sedentary', 'Carlos Silva', '', '', NULL, '', '', '+55 11 91234 5678'),
(43, 'avatars/hana.jfif', '1993-04-12', 'Tokyo', 'Female', 'Japan', 61, 'Diagnosed with allergic rhinitis in her teens; sensitive to dust and pollen.', NULL, 'Dust', 'Cetirizine', 'Allergies', 'Non-smoker, regular exercise', 'Hana Yamamoto', '', '', NULL, '', '', '+81 90 1234 5678'),
(44, 'avatars/Ali_hassan.jfif', '1987-10-05', 'Beirut', 'Male', 'Lebanon', 62, 'Experiences recurring back pain due to a past injury.', NULL, 'None', 'Ibuprofen', 'None', 'Occasional smoker, moderate exercise', 'Ali Hassan', '', '', NULL, '', '', '+961 70 123 456'),
(45, '', '1991-01-19', 'Riyadh', 'Female', 'Saudi Arabia', 63, 'Generally healthy with no known chronic conditions.', NULL, 'Aspirin', 'None', 'None', 'Non-smoker, active lifestyle', 'Sarah Ahmed', '', '', NULL, '', '', '+966 50 123 4567'),
(46, 'avatars/peter.jfif', '1980-09-25', 'Berlin', 'Male', 'Germany', 64, 'Diagnosed with high cholesterol; manages it with diet, exercise, and medication.', NULL, 'None', 'Atorvastatin', 'High Cholesterol', 'Non-smoker, Alcoholic, light exercise', 'Peter Muller', '', '', NULL, '', '', '+49 151 234 5678'),
(47, 'avatars/emily_carter.jfif', '1994-07-30', 'Melbourne', 'Female', 'Australia', 65, 'Struggles with anxiety for several years; under therapy and medication.', NULL, 'None', 'Sertraline', 'Anxiety', 'Non-smoker, moderate exercise', 'Emily Carter', '', '', NULL, '', '', '+61 412 345 678'),
(48, 'avatars/ahmed_omar.jfif', '1990-06-11', 'Cairo', 'Male', 'Egypt', 66, 'No significant health issues; occasional headaches.', NULL, 'None', 'None', 'Heart disease', 'Non-smoker, sedentary', 'Ahmed Omar', '', '', NULL, '', '', '+20 100 123 4567'),
(49, 'avatars/Anna_ivanova.jfif', '1996-02-18', 'Moscow', 'Female', 'Russia', 67, 'Diagnosed with PCOS; under treatment to manage symptoms.', NULL, 'None', 'Metformin', 'Diabetes', 'Non-smoker, light exercise', 'Anna Ivanova', '', '', NULL, '', '', '+7 900 123-45-67'),
(50, 'avatars/jacob.jfif', '1986-03-05', 'Seoul', 'Male', 'South Korea', 68, 'Suffers from chronic sinusitis exacerbated by seasonal allergies.', NULL, 'Dust, Pollen', 'Fluticasone Propionate', 'Allergies', 'Non-smoker, moderate exercise', 'Jacob Kim', '', '', NULL, '', '', '+82 10 1234 5678'),
(51, 'avatars/isabella.jfif', '1989-12-22', 'Rome', 'Female', 'Italy', 69, 'Diagnosed with anemia during pregnancy; treated with iron supplements.', NULL, 'None', 'Iron Supplements', 'Anemia', 'Non-smoker, active lifestyle', 'Isabella Rossi', '', '', NULL, '', '', '+39 320 123 4567'),
(52, '', '1979-11-30', 'Abu Dhabi', 'Male', 'UAE', 70, 'No significant medical history; has a family history of high blood pressure.', NULL, 'None', 'None', 'High Blood Pressure', '', 'Mohammed Saeed', '', '', NULL, '', '', '+971 56 987 6543'),
(53, '', '1992-08-17', 'Lyon', 'Female', 'France', 71, 'Has a thyroid disorder managed with daily hormone replacement therapy.', NULL, 'None', 'Levothyroxine', 'Thyroid Issues', 'Non-smoker, Alcoholic, moderate exercise', 'Chloe Martin', '', '', NULL, '', '', '+33 7 12 34 56 78'),
(54, '', '1984-10-18', 'africa', 'Male', 'Lebanon', 76, NULL, NULL, NULL, NULL, NULL, NULL, 'Dr Hiba', 'emergency_medicine', 'L12J45M12B', 30, 'BAU', 'BAU', '+961 81 867 634');

-- --------------------------------------------------------

--
-- Table structure for table `core_user`
--

CREATE TABLE `core_user` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `is_patient` tinyint(1) NOT NULL,
  `is_doctor` tinyint(1) NOT NULL,
  `phonenumber` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `core_user`
--

INSERT INTO `core_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `is_patient`, `is_doctor`, `phonenumber`) VALUES
(1, 'pbkdf2_sha256$260000$xyHNsMo0z4G2rLEo2NmfRK$g6u9pKK48dUEsFsbbk7bSbRpDPDQq1CJc7nnHTIBrz8=', '2024-11-22 13:21:01.298855', 1, 'admin', '', '', 'admin@gmail.com', 1, 1, '2022-08-02 20:11:03.218100', 0, 0, NULL),
(42, 'pbkdf2_sha256$260000$F7yYe10oqUDxFsNtZl0pyW$fq3ntkJQkztLnBOfXNg9MnhFc9rHkSm9Ox0PaqDGr7o=', '2024-11-17 23:33:19.083714', 0, 'Drsarahmitchell', '', '', 'sarahmitchell@gmail.com', 0, 1, '2024-11-17 23:24:32.783666', 0, 1, NULL),
(43, 'pbkdf2_sha256$260000$YI74xiTl6OuVIPZMTROUco$5lh/5GMT2fy45Z0eDcmI6QVrH4SyofhfPEyc3xEUHD4=', '2025-04-28 21:42:26.578537', 0, 'Dralirahman', '', '', 'alirahman@gmail.com', 0, 1, '2024-11-17 23:25:32.008999', 0, 1, NULL),
(44, 'pbkdf2_sha256$260000$eQ5ZZ98HD72zHoLGHkQzWz$Kw2FQwW24/ojev35w9BU3OyoSyfFuz53YoWTTwqSvzA=', '2025-04-15 20:48:24.461787', 0, 'Drelenapetrova', '', '', 'elenapetrova@gmail.com', 0, 1, '2024-11-17 23:26:24.504459', 0, 1, NULL),
(45, 'pbkdf2_sha256$260000$ENWGvOZJVaiyUMHfod54sx$rK88DQTxpYBq8d+Ne9haQXJHblxI+soSnnRrjGsDAyo=', '2024-11-17 23:43:28.399732', 0, 'Drjavierlopez', '', '', 'javierlopez@gmail.com', 0, 1, '2024-11-17 23:27:30.535583', 0, 1, NULL),
(46, 'pbkdf2_sha256$260000$W9jvQkkYeegGz8nYxVelaa$sK9gInD1uppjMe1oKMXeAr1ZcrTuK6usDLd+lSOLwig=', '2024-11-17 23:48:42.461800', 0, 'Drmayapatel', '', '', 'mayapatel@gmail.com', 0, 1, '2024-11-17 23:28:05.065757', 0, 1, NULL),
(47, 'pbkdf2_sha256$260000$pxxYYbcJqkEqq0rU94hnyZ$N1Eynf2hkTDTJyI1478VrrVOnc1JcLhOS4ivfia8itI=', '2025-04-28 00:54:07.306956', 0, 'Dromarhassan', '', '', 'omarhassan@gmail.com', 0, 1, '2024-11-17 23:28:35.227967', 0, 1, NULL),
(48, 'pbkdf2_sha256$260000$EFeEWz6i6Onhq9WvXPYROa$UFJ/FdbDZq0jkY6x6xOAebzx2ELCUQYi+kl5PttWytM=', '2024-11-17 23:54:00.279679', 0, 'Drannaschmidt', '', '', 'annaschmidt@gmail.com', 0, 1, '2024-11-17 23:29:11.811336', 0, 1, NULL),
(49, 'pbkdf2_sha256$260000$uze166EOARjl84W4W8wDP9$1rAJ1pXwI8TnkEKFQ7+n1kNYoSnDuPPU591hQiaeP4Y=', '2024-11-17 23:58:33.233276', 0, 'Drethanclark', '', '', 'ethanclark@gmail.com', 0, 1, '2024-11-17 23:29:49.289585', 0, 1, NULL),
(50, 'pbkdf2_sha256$260000$YbsvFseGzr2xB1jlkO2Ghu$FG2giuoPQNCsr3BPVnoKvKYSjVCcxxSqHnkrQfb3WG0=', '2024-11-18 00:01:04.918929', 0, 'Dryukitanaka', '', '', 'yukitanaka@gmail.com', 0, 1, '2024-11-17 23:30:29.213893', 0, 1, NULL),
(51, 'pbkdf2_sha256$260000$sN2kyyUKKFi4dU2H22XHdQ$qhFbdY+maq61vfO+3Uw9X8lXuRec6WpvJyU14OmLsKQ=', '2024-11-18 00:03:18.211386', 0, 'Drcarlossantos', '', '', 'carlossantos@gmail.com', 0, 1, '2024-11-17 23:31:03.828627', 0, 1, NULL),
(52, 'pbkdf2_sha256$260000$LCHFVQCjmTNerQHtF2Bee7$6/l2sSre+nBRLSF3mi2zwdXBRUsu0Y37E4YY6NQ/kU0=', '2024-11-22 16:27:48.976113', 0, 'JohnDoe', '', '', 'JohnDoe@gmail.com', 0, 1, '2024-11-18 20:06:36.268094', 1, 0, NULL),
(53, 'pbkdf2_sha256$260000$BYXy5xlHVeTRqI74it5mp0$JeK2MXRlq485Tx2QA2KzigoZ+A6PzGNn8MtjF8mnYrg=', '2025-03-19 10:04:36.669812', 0, 'JaneSmith', '', '', 'JaneSmith@gmail.com', 0, 1, '2024-11-18 20:21:10.625977', 1, 0, NULL),
(54, 'pbkdf2_sha256$260000$TGtrqssnOoirIJmnHqSev2$zTId91sJPp8KY7VkasEjTEMUPeMGO615IGxqfqwv3Ow=', '2025-04-28 21:45:44.206252', 0, 'AhmedKhan', '', '', 'AhmedKhan@gmail.com', 0, 1, '2024-11-18 20:30:17.954038', 1, 0, NULL),
(55, 'pbkdf2_sha256$260000$9sGlFyKbxNU051nJVzUcUL$NHPxzrdD75BzgSXM1yHLt6vA+jcUPegwXEqcSfVgI7U=', '2025-04-09 21:24:54.359500', 0, 'MariaGonzalez', '', '', 'MariaGonzalez@gmail.com', 0, 1, '2024-11-18 21:30:47.187703', 1, 0, NULL),
(56, 'pbkdf2_sha256$260000$DD00246q128aotTTj19Aj9$C2AmOaeN5oJMKbJEga/5ACjiCBSmdyPyWK+lv33yMgk=', '2024-11-18 21:38:24.672573', 0, 'DavidJohnson', '', '', 'DavidJohnson@gmail.com', 0, 1, '2024-11-18 21:38:14.937652', 1, 0, NULL),
(57, 'pbkdf2_sha256$260000$gkbALDfhgOffAsjaWvGjYn$sIvXPMm0K3Y1bAHekn5F5dvptXGeqivnKRRiXNvcq0M=', '2025-03-03 12:10:59.368610', 0, 'FatimaAli', '', '', 'FatimaAli@gmail.com', 0, 1, '2024-11-18 21:44:31.399115', 1, 0, NULL),
(58, 'pbkdf2_sha256$260000$jZRD5hGCcTMY3lidJDuQ2B$3AQYrtDU4t5refvbcL3IXPyNKi5AWdw4ExNBqycFdpg=', '2024-11-18 21:51:30.124142', 0, 'MichaelBrown', '', '', 'MichaelBrown@gmail.com', 0, 1, '2024-11-18 21:51:24.598465', 1, 0, NULL),
(59, 'pbkdf2_sha256$260000$oxsLZ3CU6N2DfKW6OdleD8$43U7ErWQ6UilMGkrikS8+mcJHeaSCsTaqJR7wz/fRVk=', '2024-11-18 21:57:18.811466', 0, 'SophieDubois', '', '', 'SophieDubois@gmail.com', 0, 1, '2024-11-18 21:57:12.240762', 1, 0, NULL),
(60, 'pbkdf2_sha256$260000$DV14ogmBt6wghyjDBt5gI6$u0TLBgz4zUrQlUEdIXf5rpB8pyKlwROnsKd5s8qQ6QI=', '2024-11-18 22:06:52.714700', 0, 'CarlosSilva', '', '', 'CarlosSilva@gmail.com', 0, 1, '2024-11-18 22:06:45.677275', 1, 0, NULL),
(61, 'pbkdf2_sha256$260000$4LWl8VcpEEwZUhyPRB7bGJ$hx1Ni2FPl7EcNZaIraeWIIPrBosM/f3cMcaYWh3EQ70=', '2024-11-18 22:12:03.120440', 0, 'HanaYamamoto', '', '', 'HanaYamamoto@gmail.com', 0, 1, '2024-11-18 22:11:57.196508', 1, 0, NULL),
(62, 'pbkdf2_sha256$260000$7YfakdEpsaQvz4rquRgnAq$uK/AfQ0KebovNN+KSatRhBjqqTc4GGtV3dk4p03h/2U=', '2024-12-14 13:34:46.997999', 0, 'AliHassan', '', '', 'AliHassan@gmail.com', 0, 1, '2024-11-18 22:17:41.931183', 1, 0, NULL),
(63, 'pbkdf2_sha256$260000$MrFgFjGNS6CTY6juk0CZsX$CfWnfJGrOH7Sw3sATuIz/uvYeLoRrBftyKQ/1pcuRLg=', '2024-11-18 22:29:47.473931', 0, 'SarahAhmed', '', '', 'SarahAhmed@gmail.com', 0, 1, '2024-11-18 22:28:34.509979', 1, 0, NULL),
(64, 'pbkdf2_sha256$260000$UJigv01qIpCzRn0y37pq69$dsF4WRg5IiiDUY6nTFRa6oDlbuJy71FLJE4fdhoWU+Y=', '2025-02-26 09:56:05.266218', 0, 'PeterMuller', '', '', 'PeterMuller@gmail.com', 0, 1, '2024-11-18 22:35:12.284168', 1, 0, NULL),
(65, 'pbkdf2_sha256$260000$ZjwgWvdM7g8ZBw3tIUgpjl$5OymO7BKi3eTn1s34OEbFrMx2B4D/LoPQlr1M8iMNy0=', '2024-11-18 22:48:35.811045', 0, 'EmilyCarter', '', '', 'EmilyCarter@gmail.com', 0, 1, '2024-11-18 22:39:38.224970', 1, 0, NULL),
(66, 'pbkdf2_sha256$260000$emJhYgf6aajZVF0wAgwQIH$foQ03qiakP9iC40wtzBblimSDEh42FtVEW17E62qVeE=', '2024-11-18 22:49:29.804599', 0, 'AhmedOmar', '', '', 'AhmedOmar@gmail.com', 0, 1, '2024-11-18 22:49:23.397067', 1, 0, NULL),
(67, 'pbkdf2_sha256$260000$vUKApuQSG2TPJLtWCzgg2q$ivYRL9sMqzGljv49PficOCzXvO+W4ISj6Sxi7to8UJE=', '2024-11-18 22:54:19.578117', 0, 'AnnaIvanova', '', '', 'AnnaIvanova@gmail.com', 0, 1, '2024-11-18 22:54:13.788929', 1, 0, NULL),
(68, 'pbkdf2_sha256$260000$AvMcyYn7hkKxyr3oJ1dNxm$BbBhmxddfy0MKrZIirhKAyOaj0mH1kRy7S4CnMuTLB8=', '2024-11-18 22:59:42.972841', 0, 'JacobKim', '', '', 'JacobKim@gmail.com', 0, 1, '2024-11-18 22:59:37.473051', 1, 0, NULL),
(69, 'pbkdf2_sha256$260000$PbMetkrnQCxsIiydOc309N$CsjGxtE6PyMFxQlhKLPPixgzgT76HixEpOwwcFFQ8mM=', '2024-11-18 23:06:27.152631', 0, 'IsabellaRossi', '', '', 'IsabellaRossi@gmail.com', 0, 1, '2024-11-18 23:06:06.473634', 1, 0, NULL),
(70, 'pbkdf2_sha256$260000$mBphiblZOqazPskJnrW0OU$giKrGppO0YiKRsQfVuyMv58wj7O81B1XKsVaYBHvfhI=', '2024-11-18 23:11:08.817987', 0, 'MohammedSaeed', '', '', 'MohammedSaeed@gmail.com', 0, 1, '2024-11-18 23:11:03.589341', 1, 0, NULL),
(71, 'pbkdf2_sha256$260000$eSQ67bFAT6CZeTyQGvFCop$dSFgymoe7wQCEAe52tMhuBWFkaERfu6uHU+6niDxPT4=', '2024-11-18 23:15:32.634032', 0, 'ChloeMartin', '', '', 'ChloeMartin@gmail.com', 0, 1, '2024-11-18 23:15:27.435915', 1, 0, NULL),
(75, 'pbkdf2_sha256$260000$ixvP4gezUZS8m5nasq4jFb$zYzTYgXCYA8Ueieb1M0zC1fdbTcYtE5k4X88YBM+vkM=', '2024-12-05 11:48:28.554081', 0, 'hadirida', '', '', 'hrida75@gmail.com', 0, 1, '2024-11-22 13:09:47.763051', 1, 0, NULL),
(76, 'pbkdf2_sha256$260000$9n7dPdslLbBlf6sShho5al$WFPrXEPaaRywk5jMLMGOFFDU/8nrfaFqqFrzdAfm8qM=', '2024-12-14 20:23:05.147172', 0, 'DrHiba', '', '', 'hrida9812@gmail.com', 0, 1, '2024-12-05 11:40:01.506204', 0, 1, NULL),
(77, 'pbkdf2_sha256$260000$tN5B9D55EaJtmAElVUyA46$KbDVnwEVBW0TXpcMBKKYDJZVXM5JFjn+MtoyV7Dbk/E=', NULL, 0, 'hiba', '', '', 'hibazzi@gamil.com', 0, 1, '2024-12-05 12:04:19.450183', 1, 0, NULL),
(78, 'pbkdf2_sha256$260000$qxNavm6GBlSQYhAqPnbq39$lcLYywM7zTUKa4VInSZXApUZ19accYba/rrJH2lffNY=', NULL, 0, 'DrAya', '', '', 'draya@gmail.com', 0, 1, '2024-12-14 20:23:43.800521', 1, 0, NULL),
(79, 'pbkdf2_sha256$260000$Xe7mwVtVw8MXw5r2mskTOS$tzLjRmtm+fHOmXj7I+xdpOqCDvybs8L/gpagXUdMQso=', '2025-03-19 09:56:36.354750', 0, 'Dr.Aaysh', '', '', 'Aayash@gmail.com', 0, 1, '2025-03-19 09:55:27.260787', 0, 1, NULL),
(80, 'pbkdf2_sha256$260000$PSeA4YDz6RUy3U417i2QUo$RikfEIsfnbaOBI111nyfFYtNYX5CN98Cv2y8mIbtvW0=', '2025-04-24 00:15:51.976636', 0, 'HadiBAU', '', '', 'hrida75@hotmail.com', 0, 1, '2025-04-24 00:15:39.605872', 1, 0, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `core_user_groups`
--

CREATE TABLE `core_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `core_user_user_permissions`
--

CREATE TABLE `core_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2022-08-02 20:15:07.156978', '2', 'usama', 1, '[{\"added\": {}}]', 6, 1),
(2, '2022-08-02 20:15:40.121734', '3', 'absar', 1, '[{\"added\": {}}]', 6, 1),
(3, '2022-08-02 20:16:07.053480', '3', 'absar', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 6, 1),
(4, '2022-08-02 20:16:15.287156', '2', 'usama', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 6, 1),
(5, '2022-08-02 20:17:25.367319', '2', 'usama', 2, '[]', 6, 1),
(6, '2022-08-02 21:41:15.137826', '2', 'usama', 2, '[{\"changed\": {\"fields\": [\"Email address\"]}}]', 6, 1),
(7, '2022-08-02 21:45:23.296368', '2', 'usama', 2, '[{\"changed\": {\"fields\": [\"Active\"]}}]', 6, 1),
(8, '2022-08-02 21:45:49.622705', '2', 'usama', 2, '[{\"changed\": {\"fields\": [\"Active\"]}}]', 6, 1),
(9, '2022-08-02 21:46:05.424582', '3', 'absar', 2, '[{\"changed\": {\"fields\": [\"Email address\", \"Active\"]}}]', 6, 1),
(10, '2022-08-02 21:46:52.184090', '3', 'absar', 2, '[{\"changed\": {\"fields\": [\"Active\"]}}]', 6, 1),
(11, '2022-08-04 15:12:37.764455', '2', 'usama', 2, '[{\"changed\": {\"fields\": [\"Password\"]}}]', 6, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(10, 'core', 'diagnosis'),
(7, 'core', 'medical'),
(9, 'core', 'ment'),
(8, 'core', 'profile'),
(6, 'core', 'user'),
(5, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(2, 'contenttypes', '0002_remove_content_type_name', '2022-08-02 20:07:11.991364'),
(3, 'auth', '0001_initial', '2022-08-02 20:07:12.172850'),
(4, 'auth', '0002_alter_permission_name_max_length', '2022-08-02 20:07:12.210672'),
(5, 'auth', '0003_alter_user_email_max_length', '2022-08-02 20:07:12.218232'),
(6, 'auth', '0004_alter_user_username_opts', '2022-08-02 20:07:12.224229'),
(7, 'auth', '0005_alter_user_last_login_null', '2022-08-02 20:07:12.232912'),
(8, 'auth', '0006_require_contenttypes_0002', '2022-08-02 20:07:12.234909'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2022-08-02 20:07:12.242904'),
(10, 'auth', '0008_alter_user_username_max_length', '2022-08-02 20:07:12.250544'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2022-08-02 20:07:12.257669'),
(12, 'auth', '0010_alter_group_name_max_length', '2022-08-02 20:07:12.273362'),
(13, 'auth', '0011_update_proxy_permissions', '2022-08-02 20:07:12.280288'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2022-08-02 20:07:12.286600'),
(15, 'core', '0001_initial', '2022-08-02 20:07:12.788235'),
(16, 'admin', '0001_initial', '2022-08-02 20:07:12.887972'),
(17, 'admin', '0002_logentry_remove_auto_add', '2022-08-02 20:07:12.906525'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2022-08-02 20:07:12.919273'),
(19, 'sessions', '0001_initial', '2022-08-02 20:07:12.952848');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('88jfulsq01snsmbfor2ckodoih8ykcfz', '.eJxVjUtuwzAMRO-idWroR1PusvucQSApKk5aWIXlICiK3r02kEW7nTfz5ttkum9zvndd87WYVxOjOf0NmeRdl4OUGy2XNkhbtvXKw1EZnrQP51b04-3Z_SeYqc_72pMTrMUFDRMiF0aoVJjA1hDUsfWJSBKqjxJGwkmSYkpFZZSKGA7pJ_X-aGvJq3bd8tb2t10tl680w0sEhgniyJaco6mCH4EYwCe1Vn0yP7-9tk00:1tEpLP:DGf2tZVIESqvlQzhZUHvYM5BhSMUYK07LCyl8AyFPek', '2024-12-07 12:34:35.316536'),
('bv75texjw8quxynb7fpu9oao8kvkwh9k', '.eJxVjEEOwiAQRe_C2pDCFAGX7nsGMsxMpWpoUtqV8e7apAvd_vfef6mE21rS1mRJE6uLMur0u2Wkh9Qd8B3rbdY013WZst4VfdCmh5nleT3cv4OCrXxr2wlFcdmM5EPvwTEFFymcUbyzI_YOcsw5IPgYGKzYDoCMGPDMxEa9P-jtOAo:1oJm2i:p7aBde_VFneuZyz75qZbYff4P-5gEwR4sEQUrR5KzhQ', '2022-08-19 01:22:24.885145'),
('cjs1emqaaa1tkf91wjfe75v5a5c7ej45', 'e30:1tMYg5:Qgpvq6PtLu7SLwfuu_7GwZugVWvkpngWS8NZoKcDW9A', '2024-12-28 20:23:53.123476'),
('fwp6zm7966lpmlown5c8rb05k1rg46nl', '.eJxVjEEOwiAQRe_C2hCwzoAu3XsGMjCDVA0kpV0Z726bdKHb_977bxVomUtYukxhZHVR4NThd4yUnlI3wg-q96ZTq_M0Rr0peqdd3xrL67q7fweFellrmyyCy2lAZASD1gNaEuslojXsMKdsfM4kEOHsYswIfEI-GhhkZerzBQEMOHk:1tp4dP:kO4QEEKBWxRtmgQ-fkuCHVIv0Fh9IiGsBTvpW7cFRlM', '2025-03-17 12:10:59.372456'),
('gumayflq8zniypraybnwjq65golzl98s', '.eJxVjDEOwjAMAP-SGUU1cZqEkZ03VI7tkgJKpaadEH9HlTrAene6txloW8uwNV2GSczFgDOnX5iJn1p3Iw-q99nyXNdlynZP7GGbvc2ir-vR_g0KtbJ_GTSEiIIjcYi5cyhM3bkfKXWiCcGDes9OQTBncIqBEjiOI_ae1Xy-Ea04XA:1tBKsD:Y5_y50ykXCC_cxWBL7DyBXI4-JQ5uujN3Lv2aWoShSQ', '2024-11-27 21:26:01.852742'),
('jffqusuq35rgmo7lr0fwxmv3ywpwx8mr', '.eJxVjDkOwjAQRe_iGllexhslPWewZrzgAHKkOKkQd4dIKaD9773_YhG3tcVtlCVOmZ0ZaHb6HQnTo_Sd5Dv228zT3NdlIr4r_KCDX-dcnpfD_TtoONq39tVTsqZIEGRdssFIrAZJqOCsdEph9g4R0GdRdSIAUWuxupKxgEGz9wcKUjg4:1u9Cr4:kPcyFT8vBSmmQuVmAg1mMu117HI-MnIH5eHCfBqgbWY', '2025-05-12 01:00:18.362581'),
('r6xmr3hl9efzgb1dkcz2j8dredhxgp3m', '.eJxVjMEOwiAQRP-FsyGVLgt49O43kIUFqRpISnsy_rtt0oMe5jLvzbyFp3Upfu1p9hOLi9AgTr9loPhMdSf8oHpvMra6zFOQuyIP2uWtcXpdD_fvoFAv2zoMUQ3aASIOHCmabMAgIARHCcluGXOG0bEybEhZk10ESkqh05bP4vMFBK439A:1u9Bsc:ZWlQkPUX7_6YfIw2kU3FX5GuEgYSVt_p92K8kToy7iI', '2025-05-11 23:57:50.872292'),
('tbr2dvd9oyqlxirquddu996wg0sxx6sb', '.eJxVjDsOwjAQBe_iGlnxJ1mHkp4zWOvdNQ4gR4qTCnF3iJQC2jcz76UibmuJW5MlTqzOynt1-h0T0kPqTviO9TZrmuu6TEnvij5o09eZ5Xk53L-Dgq18a4uGILNx4kaAxAn6jJyw77JzYlJnAyIFEOvJDQgjBYEQWGigDODU-wMtTjkD:1tuqK7:48ZJxp7fRM96Rs5HeWaN0JSMY6rw7_yce1m4VLHyH5o', '2025-04-02 10:06:55.810286'),
('w017t7jcyugw6xerynj67w349kspat96', '.eJxVjEEOgjAQRe_StWnamdKiS_ecgUxnBosaSCisjHdXEha6_e-9_zI9bWvpt6pLP4q5GN-a0--YiR867UTuNN1my_O0LmO2u2IPWm03iz6vh_t3UKiWbx1zUnBN4CQJlCk3ABQiOgRhIvQITWIGyDCoi4kdBMzoZcAWWM7m_QED6Dff:1tCnHp:D1bY8ltfj4M5x2_z7N3OFnBhaofYQ1hpFo5wf4ZuuOY', '2024-12-01 21:58:29.610444');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `core_medical`
--
ALTER TABLE `core_medical`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_medical_doctor_id_3d50ad37_fk_core_user_id` (`doctor_id`),
  ADD KEY `core_medical_patient_id_5344c821_fk_core_user_id` (`patient_id`),
  ADD KEY `fk_checked_by` (`checked_by_id`);

--
-- Indexes for table `core_ment`
--
ALTER TABLE `core_ment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `core_ment_doctor_id_60a15865_fk_core_user_id` (`doctor_id`),
  ADD KEY `core_ment_medical_id_f2161916_fk_core_medical_id` (`medical_id`),
  ADD KEY `core_ment_patient_id_d91dbfa4_fk_core_user_id` (`patient_id`);

--
-- Indexes for table `core_profile`
--
ALTER TABLE `core_profile`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `core_user`
--
ALTER TABLE `core_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `core_user_groups`
--
ALTER TABLE `core_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_user_groups_user_id_group_id_c82fcad1_uniq` (`user_id`,`group_id`),
  ADD KEY `core_user_groups_group_id_fe8c697f_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `core_user_user_permissions`
--
ALTER TABLE `core_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `core_user_user_permissions_user_id_permission_id_73ea0daa_uniq` (`user_id`,`permission_id`),
  ADD KEY `core_user_user_permi_permission_id_35ccf601_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_core_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=41;

--
-- AUTO_INCREMENT for table `core_medical`
--
ALTER TABLE `core_medical`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=141;

--
-- AUTO_INCREMENT for table `core_ment`
--
ALTER TABLE `core_ment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `core_profile`
--
ALTER TABLE `core_profile`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `core_user`
--
ALTER TABLE `core_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `core_user_groups`
--
ALTER TABLE `core_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `core_user_user_permissions`
--
ALTER TABLE `core_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `core_medical`
--
ALTER TABLE `core_medical`
  ADD CONSTRAINT `fk_checked_by` FOREIGN KEY (`checked_by_id`) REFERENCES `core_user` (`id`) ON DELETE SET NULL;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
