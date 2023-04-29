select * from Nashville_housing_data_2013_2016

-- Standardize Date Format

select 'sale date' 
from Nashville_housing_data_2013_2016

select 'sale date', convert ( date, 'sale date')
from Nashville_housing_data_2013_2016

update Nashville_housing_data_2013_2016
set 'sale date' =convert(date, 'sale date'))


-- Populate Property Address data

select 'Property Address' 
from Nashville_housing_data_2013_2016

select * from Nashville_housing_data_2013_2016
where 'property address' is null
order by 'parcel ID'

select a.'parcel id', a.'property address', b.'parcel id', b.'property address', isnull(a.'property address',b.'property address')
From Nashville_housing_data_2013_2016 a
join Nashville_housing_data_2013_2016 b 
	on a.'parcel id' = b.'parcel id'
    and a.[unique_ID] != b.[unique_ID]
where a.'property address' is null

update a
set 'property address' =  isnull(a.'property address',b.'property address')
From Nashville_housing_data_2013_2016 a
join Nashville_housing_data_2013_2016 b 
	on a.'parcel id' = b.'parcel id'
    and a.[unique_ID] != b.[unique_ID]
where a.'property address' is null

-- Breaking out Address into Individual Columns (Address, City, State)

select 'property address' from Nashville_housing_data_2013_2016

select 
substring('property address', 1 , charindex(',','property address') -1) as address
, substring('property address', charindex(',','property address') +1, len('property address')) as address
from Nashville_housing_data_2013_2016


alter table Nashville_housing_data_2013_2016
Add 'Only Address' varchar(255);

Update Nashville_housing_data_2013_2016
SET 'Only Address' = SUBSTRING('property address', 1 , charindex(',','property address') -1)


alter table Nashville_housing_data_2013_2016
Add 'City' varchar(255);

Update Nashville_housing_data_2013_2016
SET 'City' = SUBSTRING('property address', charindex(',','property address') +1, len('property address'))

select 'owner address' from Nashville_housing_data_2013_2016

Select
parsename(replace('owner address', ',', '.') , 3)
,parsename(replace('owner address', ',', '.') , 2)
,parsename(replace('owner address', ',', '.') , 1)
From Nashville_housing_data_2013_2016


alter table Nashville_housing_data_2013_2016
Add 'Owner Address' varchar(255);

Update Nashville_housing_data_2013_2016
SET 'Owner Address' = parsename(replace('owner address', ',', '.') , 3)


alter table Nashville_housing_data_2013_2016
Add 'Owner city' varchar(255);

Update Nashville_housing_data_2013_2016
SET 'Owner city' = parsename(replace('owner address', ',', '.') , 2)



alter table Nashville_housing_data_2013_2016
Add 'Owner state' varchar(255);


Update Nashville_housing_data_2013_2016
SET 'Owner state' = parsename(replace('owner address', ',', '.') , 1)

select distinct('sold as vacant'), count('sold as vacant')
From Nashville_housing_data_2013_2016
Group by 'sold as vacant'
order by 'sold as vacant'

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
       
 -- Remove Duplicates
 
with rownumcte as (
Select *,
	row_number() over (
	partition by 'parcel ID',
				 'Property Address',
				 'Sale Price',
				 'Sale Date',
				 'Legal Reference'
				 order by 
					unique_ID
					) row_num

From Nashville_housing_data_2013_2016
)

Delete
from RowNumCTE
Where row_num > 1;

-- Delete Unused Columns

alter table Nashville_housing_data_2013_2016	
drop column `Owner Address`, `Tax District`, `Property Address`, `Sale Date`;