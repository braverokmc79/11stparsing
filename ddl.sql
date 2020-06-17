
--	String dbURL = "jdbc:mysql://localhost:3305/Sprout?useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
--	String dbIO = "root";
--	String dbPassword = "qw660523";

create user `Sprout`@`localhost` identified by 'qw660523';
create user `Sprout`@`%` identified by 'qw660523';  
  
create database Sprout CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
  
grant all privileges on Sprout.* to `Sprout`@`localhost` ;
grant all privileges on Sprout.* to `Sprout`@`%` ;

create TABLE `BOARD`
(
	boardID int  not null AUTO_INCREMENT primary key,
	boardTitle varchar(50),
	userID 	varchar(20) ,
	boardDate DATETIME, 
	boardContent varchar(2048),
	boardAvailable int 
);


create TABLE `USER`
(
	userID varchar(20) not null primary key,
	userPassword varchar(20),
	userName varchar(20),
	userGender varchar(20),
	userEmail varchar(50)
);
