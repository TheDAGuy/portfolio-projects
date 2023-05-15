select * from Nashville_housing_data_2013_2016

-- For allowing  updates in the table
set sql_safe_updates = 0;				

-- Standardize Date Format

select 'sale date' 
from Nashville_housing_data_2013_2016

select 'sale date', convert('sale date', date)
from Nashville_housing_data_2013_2016

update Nashville_housing_data_2013_2016
set 'sale date' = convert('sale date', date)


-- Breaking out Address into Individual Columns (Address, City, State)

select 
substring('property address', 1 , locate(',','property address') -1) as address 1
, substring('property address', locate(',','property address') +1, len('property address')) as address 2
from Nashville_housing_data_2013_2016


alter table Nashville_housing_data_2013_2016
Add 'Only Address' varchar(255);

Update Nashville_housing_data_2013_2016
SET 'Only Address' = SUBSTRING('property address', 1 , locate(',','property address') -1)


alter table Nashville_housing_data_2013_2016
Add 'City' varchar(255);

Update Nashville_housing_data_2013_2016
SET 'City' = SUBSTRING('property address', locate(',','property address') +1, len('property address'))

select 'owner address' from Nashville_housing_data_2013_2016

Select
SUBSTRING_INDEX (month_and_day,'-',1)
,SUBSTRING_INDEX (month_and_day,'-',2)
,SUBSTRING_INDEX (month_and_day,'-',-1)
From Nashville_housing_data_2013_2016


alter table Nashville_housing_data_2013_2016
Add 'Owner Address' varchar(255);

Update Nashville_housing_data_2013_2016
SET 'Owner Address' = SUBSTRING_INDEX (month_and_day,'-',1)


alter table Nashville_housing_data_2013_2016
Add 'Owner city' varchar(255);

Update Nashville_housing_data_2013_2016
SET 'Owner city' = SUBSTRING_INDEX (month_and_day,'-',2)



alter table Nashville_housing_data_2013_2016
Add 'Owner state' varchar(255);


Update Nashville_housing_data_2013_2016
SET 'Owner state' = SUBSTRING_INDEX (month_and_day,'-',-1)


-- Change Y and N to Yes and No in "Sold as Vacant" field

Select 'sold as vacant'
, CASE
	   When 'sold as vacant' = 'Y' THEN 'Yes'
	   When 'sold as vacant' = 'N' THEN 'No'
	   ELSE 'sold as vacant'
	   END
From Nashville_housing_data_2013_2016


Update Nashville_housing_data_2013_2016
SET 'sold as vacant' =  CASE
	   When 'sold as vacant' = 'Y' THEN 'Yes'
	   When 'sold as vacant' = 'N' THEN 'No'
	   ELSE 'sold as vacant'
	   END
       

-- Delete Unused Columns

alter table Nashville_housing_data_2013_2016	
drop column 'Owner Address', 'Tax District', 'Property Address', 'Sale Date';


set sql_safe_updates = 1;
