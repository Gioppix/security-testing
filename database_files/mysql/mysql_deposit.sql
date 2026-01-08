  CREATE TABLE `PIAL`.`deposit` 
   (	`id` VARCHAR(10), 
	`year` DECIMAL(38,0), 
	`interest` DECIMAL(38,0), 
	`amount` DECIMAL(38,0), 
	`deposit_date` VARCHAR(30)
   ) 
 ;

/* SET DEFINE OFF; */
Insert into PIAL.deposit (id,year,interest,amount,deposit_date) values ('PiSa532991',1,8,100000,'2017/04/20 04:19:56');