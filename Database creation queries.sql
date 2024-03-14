-- Tao DIM
CREATE TABLE Pet_DIM_DEL
(
Pet_Key int not null identity(1,1)
, [Type] varchar(3)
,[Age] int
,Breed1 varchar(255)
,Breed2 varchar(255)
,Gender varchar(6)
,Color1 varchar(255)
,Color2 varchar(255)
,Color3 varchar(255)
,MaturitySize varchar(13)
,FurLength varchar(13)
,Vaccinated varchar(8)
,Dewormed varchar(8)
,Sterilized varchar(8)
,Health varchar(14)
,Quantity int
,Fee int
,[State] varchar(255)
,Primary key (Pet_Key)
)
;

-- Tao FACT

CREATE TABLE Rescue_FACT
(
PetID int not null
,Pet_Key int 
,RescuerID int
,Primary key (PetID)
,Foreign key(Pet_Key) REFERENCES Pet_DIM(Pet_Key)
)
;
-- Có bao nhiêu con mèo đã hoàn thành toàn bộ tiêm vắc xin, tẩy giun và triệt sản
SELECT
	COUNT(*)
FROM dbo.Rescue_FACT A
	JOIN dbo.Pet_DIM B
		ON A.Pet_Key = B.Pet_Key
WHERE B.Type = 'Cat'
	AND B.Dewormed = 'Yes'
	AND B.Vaccinated = 'Yes'
	AND B.Sterilized = 'Yes'

-- Thống kê theo từng bang có bao nhiêu con vật đang bị thương nặng
;
SELECT
	B.State
	,[Count of injury pet] = COUNT(B.Pet_Key)
FROM dbo.Rescue_FACT A
	JOIN dbo.Pet_DIM B
		ON A.Pet_Key = B.Pet_Key
WHERE B.Health = 'Serious Injury'
GROUP BY B.State
ORDER BY COUNT(B.Pet_Key) DESC

-- Đang có bao nhiêu chó và mèo được chia theo giới tính trong bộ dữ liệu
SELECT
	B.Type
	,B.Gender
	,Total = COUNT(B.Pet_Key)
FROM dbo.Rescue_FACT A
	JOIN dbo.Pet_DIM B
		ON A.Pet_Key = B.Pet_Key
GROUP BY B.Type, B.Gender
ORDER BY B.Type, B.Gender
;

-- Pivot
SELECT
[Type]
[Male],
[Female],
[Mixed]
FROM 
(
SELECT
	B.Type
	,B.Gender
	,B.Pet_Key
FROM dbo.Rescue_FACT A
	JOIN dbo.Pet_DIM B
		ON A.Pet_Key = B.Pet_Key
) C

PIVOT(
COUNT(Pet_Key)
FOR [Gender] IN ([Male],[Female],[Mixed])
) D