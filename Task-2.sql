use Travego;
select * from passenger;
select * from price;

-- 2. (Medium) Perform read operation on the designed table created in the above task.
-- a. How many female passengers traveled a minimum distance of 600 KMs? (1 mark)
select count(*) as count_female 
from passenger 
where gender = 'F' and distance < 600;

-- b. Write a query to display the passenger details whose travel distance is greater than 500 and who are traveling in a sleeper bus. (2 marks)
select * from passenger
where distance > 500 and bus_type = 'sleeper';

-- c. Select passenger names whose names start with the character 'S'.(2 marks)
select * from passenger where passenger_name like 's%';

-- d. Calculate the price charged for each passenger, displaying the Passenger name, Boarding City,Destination City, Bus type, and Price in the output. (3 marks)
select pa.Passenger_name,pa.boarding_City,pa.Destination_City, pa.bus_type,pa.distance,p.Price 
from passenger pa
left join 
price p
on pa.distance = p.distance and pa.bus_type = p.bus_type;

-- e. What are the passenger name(s) and the ticket price for those who traveled 1000 KMs Sitting in a bus? (4 marks)
select p.passenger_name,pr.price
from passenger p
left join price pr
on p.distance = pr.distance and p.bus_type = pr.bus_type
where p.distance = 1000 and p.bus_type='sitting' and pr.distance = 1000 and pr.bus_type='sitting';

-- f. What will be the Sitting and Sleeper bus charge for Pallavi to travel from Bangalore to Panaji? (5marks)
select  p.passenger_name,pr.price,pr.distance,pr.bus_type
from passenger p,price pr
where pr.bus_type in ('Sleeper','Sitting')  and p.passenger_name = 'Pallavi' and pr.distance=
(select distance from passenger where boarding_city='Panaji' and destination_city='Bengaluru');

-- g. Alter the column category with the value "Non-AC" where the Bus_Type is sleeper (2 marks)
update passenger
set category = 'Non-AC'
where bus_type = 'Sleeper';
select * from passenger;

-- h. Delete an entry from the table where the passenger name is Piyush and commit this change in the database. (1 mark)
delete from passenger
where passenger_name = 'Piyush';
select * from passenger;

-- i. Truncate the table passenger and comment on the number of rows in the table (explain if required). (1 mark)
truncate table passenger;
select * from passenger;
-- explain:
-- 1.zero number of rows in table because TRUNCATE TABLE removes all rows from a table, but the table structure and its columns, constraints, indexes, and so on remain

-- j. Delete the table passenger from the database. (1 mark)
drop table passenger;