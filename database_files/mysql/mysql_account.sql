  CREATE TABLE `PIAL`.`account` 
   (	`id` VARCHAR(10), 
	`f_name` VARCHAR(20), 
	`L_NAME` VARCHAR(20), 
	`address` VARCHAR(60), 
	`city` VARCHAR(15), 
	`branch` VARCHAR(15), 
	`zip` VARCHAR(8), 
	`username` VARCHAR(20), 
	`password` VARCHAR(30), 
	`phone` VARCHAR(15), 
	`email` VARCHAR(30), 
	`account_type` VARCHAR(15), 
	`reg_date` VARCHAR(15)
   ) 
 ;
-- INSERTING into PIAL.account
/* SET DEFINE OFF; */
Insert into PIAL.account (id,f_name,L_NAME,address,city,branch,zip,username,password,phone,email,account_type,reg_date) values ('PiSa532991','Pial Kanti','Samadder','Keranigonj,Dhaka','Dhaka','Dhaka','1304','PialKanti','1234','01676277976','pialkanti2012@gmail.com','Current Account','15/04/2017');
Insert into PIAL.account (id,f_name,L_NAME,address,city,branch,zip,username,password,phone,email,account_type,reg_date) values ('RaBh863299','Rajesh','Bhartia','Mymensingh','Mymensingh','Mymensingh','2210','rkBhartia','1234','01455699554','rbhartiamuk@gmail.com','Saving Account','16/04/2017');
Insert into PIAL.account (id,f_name,L_NAME,address,city,branch,zip,username,password,phone,email,account_type,reg_date) values ('GrBa240230','Green','Bank','KUET','Khulna','Khulna','1540','admin','admin','13234558','admin@greenbank.com','Saving Account','23/04/2017');
