  CREATE TABLE `PIAL`.`loan` 
   (	`id` VARCHAR(10), 
	`amount` DECIMAL(38,0), 
	`status` VARCHAR(8), 
	`first_name` VARCHAR(20), 
	`last_name` VARCHAR(20), 
	`address` VARCHAR(60), 
	`email` VARCHAR(30)
   ) 
 ;

/* SET DEFINE OFF; */
Insert into PIAL.loan (id,amount,status,first_name,last_name,address,email) values ('RaBh863299',200000,'pending','Rajesh','Bhartia','Mymensingh','rbhartiamuk@gmail.com');
Insert into PIAL.loan (id,amount,status,first_name,last_name,address,email) values ('PiSa532991',100000,'pending','Pial Kanti','Samadder','Keranigonj,Dhaka','pialkanti2012@gmail.com');
Insert into PIAL.loan (id,amount,status,first_name,last_name,address,email) values ('PiSa532991',20000,'success','Pial Kanti','Samadder','Keranigonj,Dhaka','pialkanti2012@gmail.com');