SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `shadow` ;
CREATE SCHEMA IF NOT EXISTS `shadow` DEFAULT CHARACTER SET latin1 ;
USE `shadow` ;


CREATE TABLE Employees (
    EmployeeID CHAR(10) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Position VARCHAR(50) NOT NULL,
    ManagerID CHAR(10),
    Salary INT NOT NULL,
    HireDate DATETIME NOT NULL,
    AccessLevel TINYINT(3),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID) ON UPDATE CASCADE
);

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100),
    ManagerID CHAR(10),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID) ON UPDATE CASCADE
);

CREATE TABLE Genre(
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL
);

CREATE TABLE Publisher(
    PublisherID INT PRIMARY KEY,
    Publisher VARCHAR(100) NOT NULL
);

CREATE TABLE Books (
    BookID VARCHAR(15) PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Year INT,
    AuthorFirstName VARCHAR(100),
    AuthorLastName VARCHAR(100),
    PublisherID INT,
    GenreID INT NOT NULL,
    FOREIGN KEY (GenreID) REFERENCES Genre(GenreID) ON UPDATE CASCADE,
    FOREIGN KEY (PublisherID) REFERENCES Publisher(PublisherID) ON UPDATE CASCADE
);
CREATE INDEX authorName ON Books(AuthorLastName);
CREATE INDEX bookTitle ON Books(Title);

CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    FirstName VARCHAR(100),
    LastName VARCHAR(100),
    Email VARCHAR(100)
);

CREATE TABLE Sales(
    SaleID INT PRIMARY KEY,
    Date DATETIME DEFAULT CURRENT_TIMESTAMP NOT NULL,
    Customer INT NOT NULL,
    Employee CHAR(10) NOT NULL,
    FOREIGN KEY (Customer) REFERENCES Customers(CustomerID) ON UPDATE CASCADE,
    FOREIGN KEY (Employee) REFERENCES Employees(EmployeeID) ON UPDATE CASCADE
);

CREATE TABLE Inventory (
    BookID VARCHAR(15),
    CopyID INT PRIMARY KEY,
    Cursed TINYINT(1),
    CurrentPrice FLOAT,
    Sale INT,
    FOREIGN KEY (BookID) REFERENCES Books(BookID) ON UPDATE CASCADE,
    FOREIGN KEY (Sale) REFERENCES Sales(SaleID) ON UPDATE CASCADE
);

CREATE TABLE BookPrices(
    CopyID INT,
    DateSet DATETIME DEFAULT CURRENT_TIMESTAMP,
    Price FLOAT NOT NULL,
    PRIMARY KEY (CopyID, DateSet),
    FOREIGN KEY (CopyID) REFERENCES Inventory(CopyID) ON UPDATE CASCADE
);

CREATE TABLE CounterCurses(
    CounterID INT PRIMARY KEY,
    Name VARCHAR(50),
    Instructions TEXT NOT NULL
);
CREATE INDEX ccName ON CounterCurses(Name);

CREATE TABLE Curses(
    CurseID INT PRIMARY KEY,
    Name VARCHAR(50) UNIQUE,
    Effect VARCHAR(100),
    DangerLevel TINYINT(3) NOT NULL,
    Description TEXT,
    Countercurse INT NOT NULL,
    FOREIGN KEY (Countercurse) REFERENCES CounterCurses(CounterID) ON UPDATE CASCADE
);
CREATE INDEX curseName ON Curses(Name);

CREATE TABLE Projects(
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE ResearchCurseIDs(
    ProjectID INT,
    ResearchCurseID INT,
    PRIMARY KEY (ProjectID, ResearchCurseID),
    FOREIGN KEY (ResearchCurseID) REFERENCES Curses(CurseID) ON UPDATE CASCADE,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON UPDATE CASCADE
);

CREATE TABLE ResearchCountercurseIDs(
    ProjectID INT,
    ResearchCountercurseID INT,
    PRIMARY KEY (ProjectID, ResearchCountercurseID),
    FOREIGN KEY (ResearchCountercurseID) REFERENCES CounterCurses(CounterID) ON UPDATE CASCADE,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON UPDATE CASCADE
);

CREATE TABLE Employees_Projects (
    EmployeeID CHAR(10),
    ProjectID INT,
    DateJoined DATE NOT NULL,
    DateLeft DATE,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON UPDATE CASCADE,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON UPDATE CASCADE
);

CREATE TABLE Inventory_Curses (
    CopyID INT,
    CurseID INT,
    PRIMARY KEY (CopyID, CurseID),
    FOREIGN KEY (CopyID) REFERENCES Inventory(CopyID) ON UPDATE CASCADE,
    FOREIGN KEY (CurseID) REFERENCES Curses(CurseID) ON UPDATE CASCADE
);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;