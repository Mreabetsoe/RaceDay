
-- =============================================
-- RACEDAY DATABASE
-- =============================================

CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO


-- =============================================
-- 1. USER TABLE
-- =============================================

CREATE TABLE [User]
(
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role VARCHAR(20) NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT CK_User_Role
        CHECK (Role IN ('Organiser', 'Participant'))
);
GO


-- =============================================
-- 2. EVENT TABLE
-- =============================================

CREATE TABLE Event
(
    EventID INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserID INT NOT NULL,
    Name VARCHAR(100) NOT NULL,
    Description VARCHAR(500) NOT NULL,
    EventDate DATE NOT NULL,
    Location VARCHAR(150) NOT NULL,
    DistanceKm DECIMAL(6,2) NOT NULL,
    Capacity INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Event_Organiser
        FOREIGN KEY (OrganiserID)
        REFERENCES [User](UserID),

    CONSTRAINT CK_Event_Distance
        CHECK (DistanceKm > 0),

    CONSTRAINT CK_Event_Capacity
        CHECK (Capacity > 0)
);
GO


-- =============================================
-- 3. CATEGORY TABLE
-- =============================================

CREATE TABLE Category
(
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Description VARCHAR(300) NULL
);
GO


-- =============================================
-- 4. EVENT CATEGORY TABLE
-- =============================================

CREATE TABLE EventCategory
(
    EventID INT NOT NULL,
    CategoryID INT NOT NULL,

    CONSTRAINT PK_EventCategory
        PRIMARY KEY (EventID, CategoryID),

    CONSTRAINT FK_EventCategory_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    CONSTRAINT FK_EventCategory_Category
        FOREIGN KEY (CategoryID)
        REFERENCES Category(CategoryID)
);
GO


-- =============================================
-- 5. ENROLMENT TABLE
-- =============================================

CREATE TABLE Enrolment
(
    EnrolmentID INT IDENTITY(1,1) PRIMARY KEY,
    EventID INT NOT NULL,
    UserID INT NOT NULL,
    EnrolmentDate DATETIME NOT NULL DEFAULT GETDATE(),
    Status VARCHAR(20) NOT NULL DEFAULT 'Confirmed',

    CONSTRAINT FK_Enrolment_Event
        FOREIGN KEY (EventID)
        REFERENCES Event(EventID),

    CONSTRAINT FK_Enrolment_User
        FOREIGN KEY (UserID)
        REFERENCES [User](UserID),

    CONSTRAINT UQ_Enrolment_Event_User
        UNIQUE (EventID, UserID),

    CONSTRAINT CK_Enrolment_Status
        CHECK (
            Status IN (
                'Pending',
                'Confirmed',
                'Cancelled',
                'Completed'
            )
        )
);
GO


-- =============================================
-- 6. RESULT TABLE
-- =============================================

CREATE TABLE Result
(
    ResultID INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentID INT NOT NULL UNIQUE,
    FinishTime TIME NULL,
    Position INT NULL,
    RecordedAt DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT FK_Result_Enrolment
        FOREIGN KEY (EnrolmentID)
        REFERENCES Enrolment(EnrolmentID),

    CONSTRAINT CK_Result_Position
        CHECK (Position IS NULL OR Position > 0)
);
GO


-- =============================================
-- SEED DATA: USERS
-- 2 ORGANISERS + 2 PARTICIPANTS
-- =============================================

INSERT INTO [User]
    (FirstName, LastName, Email, PasswordHash, Role)
VALUES
    ('Thabo', 'Mokoena', 'thabo@raceday.co.za',
     'HASHED_PASSWORD_1', 'Organiser'),

    ('Naledi', 'Khumalo', 'naledi@raceday.co.za',
     'HASHED_PASSWORD_2', 'Organiser'),

    ('Lerato', 'Maseko', 'lerato@gmail.com',
     'HASHED_PASSWORD_3', 'Participant'),

    ('Sipho', 'Dlamini', 'sipho@gmail.com',
     'HASHED_PASSWORD_4', 'Participant');
GO


-- =============================================
-- SEED DATA: CATEGORIES
-- =============================================

INSERT INTO Category
    (Name, Description)
VALUES
    ('Running', 'Road and distance running events'),

    ('Walking', 'Walking and recreational walking events'),

    ('Cycling', 'Road and recreational cycling events'),

    ('10K', 'Events with a distance of approximately 10 kilometres'),

    ('Charity', 'Events organised to support charitable causes');
GO


-- =============================================
-- SEED DATA: EVENTS
-- MINIMUM 3 EVENTS
-- =============================================

INSERT INTO Event
    (
        OrganiserID,
        Name,
        Description,
        EventDate,
        Location,
        DistanceKm,
        Capacity
    )
VALUES
    (
        1,
        'Soweto 10K Run',
        'A 10 kilometre community road race in Soweto.',
        '2026-10-10',
        'Soweto, Gauteng',
        10.00,
        500
    ),

    (
        1,
        'Pretoria Charity Walk',
        'A community walking event supporting local charities.',
        '2026-11-02',
        'Pretoria, Gauteng',
        5.00,
        300
    ),

    (
        2,
        'Cape Town Cycle Challenge',
        'A recreational cycling event for registered participants.',
        '2026-12-05',
        'Cape Town, Western Cape',
        40.00,
        800
    );
GO


-- =============================================
-- LINK CATEGORIES TO EVENTS
-- =============================================

INSERT INTO EventCategory
    (EventID, CategoryID)
VALUES
    (1, 1),
    (1, 4),
    (2, 2),
    (2, 5),
    (3, 3);
GO


-- =============================================
-- SAMPLE ENROLMENTS
-- =============================================

INSERT INTO Enrolment
    (EventID, UserID, EnrolmentDate, Status)
VALUES
    (1, 3, '2026-09-15', 'Confirmed'),
    (1, 4, '2026-09-16', 'Confirmed'),
    (2, 3, '2026-09-20', 'Confirmed'),
    (3, 4, '2026-09-25', 'Confirmed');
GO


-- =============================================
-- SAMPLE RESULTS
-- =============================================

INSERT INTO Result
    (EnrolmentID, FinishTime, Position, RecordedAt)
VALUES
    (1, '00:52:35', 12, '2026-10-10 12:00:00'),
    (2, '01:03:20', 28, '2026-10-10 12:05:00');
GO


-- =============================================
-- CHECK THE DATA
-- =============================================

SELECT * FROM [User];
SELECT * FROM Event;
SELECT * FROM Category;
SELECT * FROM EventCategory;
SELECT * FROM Enrolment;
SELECT * FROM Result;
GO