/* =========================================================
   LocationFormApp - Complete Database Script
   ASP.NET Core MVC + ADO.NET + SQL Server
   ========================================================= */


-- 1. CREATE DATABASE

IF DB_ID('LocationDB') IS NULL
BEGIN
    CREATE DATABASE LocationDB;
END
GO

USE LocationDB;
GO


-- =========================================================
-- 2. COUNTRY TABLE

IF OBJECT_ID('Country', 'U') IS NULL
BEGIN
    CREATE TABLE Country
    (
        CountryId INT IDENTITY(1,1) PRIMARY KEY,
        CountryName NVARCHAR(100) NOT NULL,
        IsActive BIT NOT NULL DEFAULT 1
    );
END
GO


-- =========================================================
-- 3. STATE TABLE

IF OBJECT_ID('State', 'U') IS NULL
BEGIN
    CREATE TABLE State
    (
        StateId INT IDENTITY(1,1) PRIMARY KEY,
        StateName NVARCHAR(100) NOT NULL,
        CountryId INT NOT NULL,
        IsActive BIT NOT NULL DEFAULT 1,

        CONSTRAINT FK_State_Country
            FOREIGN KEY (CountryId)
            REFERENCES Country(CountryId)
    );
END
GO


-- =========================================================
-- 4. CITY TABLE

IF OBJECT_ID('City', 'U') IS NULL
BEGIN
    CREATE TABLE City
    (
        CityId INT IDENTITY(1,1) PRIMARY KEY,
        CityName NVARCHAR(100) NOT NULL,
        StateId INT NOT NULL,
        IsActive BIT NOT NULL DEFAULT 1,

        CONSTRAINT FK_City_State
            FOREIGN KEY (StateId)
            REFERENCES State(StateId)
    );
END
GO


-- =========================================================
-- 5. USER SELECTION TABLE

IF OBJECT_ID('UserSelection', 'U') IS NULL
BEGIN
    CREATE TABLE UserSelection
    (
        Id INT IDENTITY(1,1) PRIMARY KEY,
        CountryId INT NOT NULL,
        StateId INT NOT NULL,
        CityId INT NOT NULL,

        CONSTRAINT FK_UserSelection_Country
            FOREIGN KEY (CountryId)
            REFERENCES Country(CountryId),

        CONSTRAINT FK_UserSelection_State
            FOREIGN KEY (StateId)
            REFERENCES State(StateId),

        CONSTRAINT FK_UserSelection_City
            FOREIGN KEY (CityId)
            REFERENCES City(CityId)
    );
END
GO


-- =========================================================
-- 6. INSERT COUNTRIES

IF NOT EXISTS
(
    SELECT 1
    FROM Country
    WHERE CountryName = 'India'
)
BEGIN
    INSERT INTO Country
    (
        CountryName,
        IsActive
    )
    VALUES
    ('India', 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM Country
    WHERE CountryName = 'USA'
)
BEGIN
    INSERT INTO Country
    (
        CountryName,
        IsActive
    )
    VALUES
    ('USA', 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM Country
    WHERE CountryName = 'Canada'
)
BEGIN
    INSERT INTO Country
    (
        CountryName,
        IsActive
    )
    VALUES
    ('Canada', 1);
END
GO


-- =========================================================
-- 7. GET COUNTRY IDs

DECLARE @IndiaId INT;
DECLARE @USAId INT;
DECLARE @CanadaId INT;

SELECT @IndiaId = CountryId
FROM Country
WHERE CountryName = 'India';

SELECT @USAId = CountryId
FROM Country
WHERE CountryName = 'USA';

SELECT @CanadaId = CountryId
FROM Country
WHERE CountryName = 'Canada';


-- =========================================================
-- 8. INSERT STATES - INDIA

IF NOT EXISTS
(
    SELECT 1
    FROM State
    WHERE StateName = 'Gujarat'
    AND CountryId = @IndiaId
)
BEGIN
    INSERT INTO State
    (
        StateName,
        CountryId,
        IsActive
    )
    VALUES
    ('Gujarat', @IndiaId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM State
    WHERE StateName = 'Maharashtra'
    AND CountryId = @IndiaId
)
BEGIN
    INSERT INTO State
    (
        StateName,
        CountryId,
        IsActive
    )
    VALUES
    ('Maharashtra', @IndiaId, 1);
END


-- =========================================================
-- 9. INSERT STATES - USA

IF NOT EXISTS
(
    SELECT 1
    FROM State
    WHERE StateName = 'California'
    AND CountryId = @USAId
)
BEGIN
    INSERT INTO State
    (
        StateName,
        CountryId,
        IsActive
    )
    VALUES
    ('California', @USAId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM State
    WHERE StateName = 'Texas'
    AND CountryId = @USAId
)
BEGIN
    INSERT INTO State
    (
        StateName,
        CountryId,
        IsActive
    )
    VALUES
    ('Texas', @USAId, 1);
END


-- =========================================================
-- 10. INSERT STATES - CANADA

IF NOT EXISTS
(
    SELECT 1
    FROM State
    WHERE StateName = 'Ontario'
    AND CountryId = @CanadaId
)
BEGIN
    INSERT INTO State
    (
        StateName,
        CountryId,
        IsActive
    )
    VALUES
    ('Ontario', @CanadaId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM State
    WHERE StateName = 'Quebec'
    AND CountryId = @CanadaId
)
BEGIN
    INSERT INTO State
    (
        StateName,
        CountryId,
        IsActive
    )
    VALUES
    ('Quebec', @CanadaId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM State
    WHERE StateName = 'Alberta'
    AND CountryId = @CanadaId
)
BEGIN
    INSERT INTO State
    (
        StateName,
        CountryId,
        IsActive
    )
    VALUES
    ('Alberta', @CanadaId, 1);
END
GO


-- =========================================================
-- 11. GET STATE IDs

DECLARE @GujaratId INT;
DECLARE @MaharashtraId INT;

DECLARE @CaliforniaId INT;
DECLARE @TexasId INT;

DECLARE @OntarioId INT;
DECLARE @QuebecId INT;
DECLARE @AlbertaId INT;


SELECT @GujaratId = StateId
FROM State
WHERE StateName = 'Gujarat'
AND CountryId =
(
    SELECT CountryId
    FROM Country
    WHERE CountryName = 'India'
);


SELECT @MaharashtraId = StateId
FROM State
WHERE StateName = 'Maharashtra'
AND CountryId =
(
    SELECT CountryId
    FROM Country
    WHERE CountryName = 'India'
);


SELECT @CaliforniaId = StateId
FROM State
WHERE StateName = 'California'
AND CountryId =
(
    SELECT CountryId
    FROM Country
    WHERE CountryName = 'USA'
);


SELECT @TexasId = StateId
FROM State
WHERE StateName = 'Texas'
AND CountryId =
(
    SELECT CountryId
    FROM Country
    WHERE CountryName = 'USA'
);


SELECT @OntarioId = StateId
FROM State
WHERE StateName = 'Ontario'
AND CountryId = @CanadaId;


SELECT @QuebecId = StateId
FROM State
WHERE StateName = 'Quebec'
AND CountryId = @CanadaId;


SELECT @AlbertaId = StateId
FROM State
WHERE StateName = 'Alberta'
AND CountryId = @CanadaId;


-- =========================================================
-- 12. INSERT CITIES - GUJARAT

IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Rajkot'
    AND StateId = @GujaratId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Rajkot', @GujaratId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Ahmedabad'
    AND StateId = @GujaratId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Ahmedabad', @GujaratId, 1);
END


-- =========================================================
-- 13. INSERT CITIES - MAHARASHTRA

IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Mumbai'
    AND StateId = @MaharashtraId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Mumbai', @MaharashtraId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Pune'
    AND StateId = @MaharashtraId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Pune', @MaharashtraId, 1);
END


-- =========================================================
-- 14. INSERT CITIES - CALIFORNIA

IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Los Angeles'
    AND StateId = @CaliforniaId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Los Angeles', @CaliforniaId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'San Francisco'
    AND StateId = @CaliforniaId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('San Francisco', @CaliforniaId, 1);
END


-- =========================================================
-- 15. INSERT CITIES - TEXAS

IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Houston'
    AND StateId = @TexasId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Houston', @TexasId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Dallas'
    AND StateId = @TexasId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Dallas', @TexasId, 1);
END


-- =========================================================
-- 16. INSERT CITIES - ONTARIO

IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Toronto'
    AND StateId = @OntarioId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Toronto', @OntarioId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Ottawa'
    AND StateId = @OntarioId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Ottawa', @OntarioId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Mississauga'
    AND StateId = @OntarioId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Mississauga', @OntarioId, 1);
END


-- =========================================================
-- 17. INSERT CITIES - QUEBEC

IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Montreal'
    AND StateId = @QuebecId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Montreal', @QuebecId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Quebec City'
    AND StateId = @QuebecId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Quebec City', @QuebecId, 1);
END


-- =========================================================
-- 18. INSERT CITIES - ALBERTA

IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Calgary'
    AND StateId = @AlbertaId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Calgary', @AlbertaId, 1);
END


IF NOT EXISTS
(
    SELECT 1
    FROM City
    WHERE CityName = 'Edmonton'
    AND StateId = @AlbertaId
)
BEGIN
    INSERT INTO City
    (
        CityName,
        StateId,
        IsActive
    )
    VALUES
    ('Edmonton', @AlbertaId, 1);
END
GO


-- =========================================================
-- 19. INSERT LOCATION STORED PROCEDURE

CREATE OR ALTER PROCEDURE sp_InsertLocation
(
    @CountryId INT,
    @StateId INT,
    @CityId INT
)
AS
BEGIN

    SET NOCOUNT ON;

    INSERT INTO UserSelection
    (
        CountryId,
        StateId,
        CityId
    )
    VALUES
    (
        @CountryId,
        @StateId,
        @CityId
    );

END
GO


-- =========================================================
-- 20. UPDATE COUNTRY STATUS

CREATE OR ALTER PROCEDURE sp_UpdateCountryStatus
(
    @CountryId INT,
    @IsActive BIT
)
AS
BEGIN

    SET NOCOUNT ON;

    UPDATE Country
    SET IsActive = @IsActive
    WHERE CountryId = @CountryId;

END
GO


-- =========================================================
-- 21. UPDATE STATE STATUS

CREATE OR ALTER PROCEDURE sp_UpdateStateStatus
(
    @StateId INT,
    @IsActive BIT
)
AS
BEGIN

    SET NOCOUNT ON;

    UPDATE State
    SET IsActive = @IsActive
    WHERE StateId = @StateId;

END
GO


-- =========================================================
-- 22. UPDATE CITY STATUS

CREATE OR ALTER PROCEDURE sp_UpdateCityStatus
(
    @CityId INT,
    @IsActive BIT
)
AS
BEGIN

    SET NOCOUNT ON;

    UPDATE City
    SET IsActive = @IsActive
    WHERE CityId = @CityId;

END
GO


-- =========================================================
-- 23. VERIFY DATA

SELECT * FROM Country;

SELECT * FROM State;

SELECT * FROM City;

SELECT * FROM UserSelection;
GO


-- =========================================================
-- 24. VERIFY STORED PROCEDURES

SELECT
    name
FROM sys.procedures
WHERE name IN
(
    'sp_InsertLocation',
    'sp_UpdateCountryStatus',
    'sp_UpdateStateStatus',
    'sp_UpdateCityStatus'
);
GO