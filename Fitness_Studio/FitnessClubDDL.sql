.echo ON
.mode list
.separator "  |  "
PRAGMA foreign_keys = ON;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS SalesPerson;
DROP TABLE IF EXISTS Instructor;
DROP TABLE IF EXISTS MembershipType;
DROP TABLE IF EXISTS MembershipSales;
DROP TABLE IF EXISTS Merchandise;
DROP TABLE IF EXISTS Classes;
DROP TABLE IF EXISTS ClassEnroll;
DROP TABLE IF EXISTS RetailSales;
DROP TABLE IF EXISTS RS_Details;
CREATE TABLE Customer (
           CID     CHAR(3)     CONSTRAINT Customer_CID_pk PRIMARY KEY,
           FName   VARCHAR(10) NOT NULL ,
           LName   VARCHAR(10)  NOT NULL,
           Address   VARCHAR(20),
           City      VARCHAR(15),
           State   CHAR(2),
           Zip     CHAR(5),
           Phone   CHAR(10),
           Birthdate DATE NOT NULL
           );
CREATE TABLE SalesPerson (
           SPID    CHAR(3)     CONSTRAINT SalesPerson_SPID_pk PRIMARY KEY,
           FName   VARCHAR(10) NOT NULL,
           LName   VARCHAR(10) NOT NULL,
           Address   VARCHAR(20),
           City    VARCHAR(15),
           State   CHAR(2),
           Zip    CHAR(5),
           Phone   CHAR(10),
           Birthdate DATE NOT NULL
           );
CREATE TABLE Instructor (
           IID     CHAR(3)     CONSTRAINT Instructor_IID_pk PRIMARY KEY,
           FName   VARCHAR(10)  NOT NULL,
           LName   VARCHAR(10) NOT NULL,
           Address   VARCHAR(20),
           City    VARCHAR(15),
           State   CHAR(2),
           Zip     CHAR(5),
           Phone   CHAR(10),
           Birthdate DATE NOT NULL
           );
CREATE TABLE MembershipType (
           MTypeID     CHAR(2)     CONSTRAINT MembershipType_MTypeID_pk PRIMARY KEY,
           MName       VARCHAR(10) NOT NULL,
           Num_Classes  INTEGER     CONSTRAINT MemType_cc CHECK((Num_Classes = 20) OR (Num_Classes = 15) OR (Num_Classes = 10)),
           MPrice      DECIMAL(5,2)
           );
CREATE TABLE MembershipSales (
           M_CID   CHAR(3)     CONSTRAINT MembershipSales_CID_fk REFERENCES Customer(CID),
           M_SPID   CHAR(3)       CONSTRAINT MembershipSales_SPID_fk REFERENCES SalesPerson(SPID),
           M_MTypeID   CHAR(2)   CONSTRAINT MembershipSales_MTypeID_fk REFERENCES MembershipType(MTypeID),
           DateSold DATE NOT NULL,
           CONSTRAINT MembershipSales_CID_SPID_pk PRIMARY KEY(M_CID, M_SPID, M_MTypeID)
           );
CREATE TABLE Merchandise(
           ItemID CHAR(2) CONSTRAINT Merchandise_ItemID_pk PRIMARY KEY,
           ItemDesc VARCHAR(20) NOT NULL,
           ItemPrice DECIMAL(3,2) NOT NULL,
           QOH INTEGER CONSTRAINT Merchandise_QOH_cc CHECK (QOH < 200)
           );
CREATE TABLE Classes(
           ClassID CHAR(3) CONSTRAINT Classes_ClassID_pk PRIMARY KEY,
           ClassDesc VARCHAR(20) NOT NULL,
           ClassTime INTEGER CONSTRAINT Classes_ClassTime_cc CHECK (ClassTime >= 0 AND ClassTime <2400),
           ClassLength INTEGER CONSTRAINT Classes_ClassLength_cc CHECK (ClassLength >= 0 AND ClassLength < 120),
           IID CHAR(3) CONSTRAINT Classes_IID_fk REFERENCES Instructor(IID)
           );
CREATE TABLE ClassEnroll(
           CE_ClassID  CHAR(3)  CONSTRAINT ClassEnroll_CE_ClassID_fk REFERENCES Classes(ClassID),
           CE_CID      CHAR(3)  CONSTRAINT ClassEnroll_CE_CID_fk REFERENCES Customer(CID),
           Class_Date  DATE   NOT NULL,
           CONSTRAINT ClassEnroll_ClassID_CID_pk PRIMARY KEY(CE_ClassID, CE_CID, Class_Date)
           );
CREATE TABLE RetailSales(
           RSID CHAR(2) CONSTRAINT RetailSales_RSID_pk PRIMARY KEY,
           RS_CID CONSTRAINT RetailSales_RS_CID_fk REFERENCES Customer(CID),
           DateSold DATE NOT NULL
           );
CREATE TABLE RS_Details (
           D_RSID  CHAR(2)   CONSTRAINT RS_Details_RSID_fk REFERENCES RetailSales(RSID),
           D_ItemID   CHAR(3)   CONSTRAINT RS_Details_ItemID_fk REFERENCES Merchandise(ItemID),
           Quantity INTEGER,
            CONSTRAINT RS_Details_RSID_ItemID_pk PRIMARY KEY(D_RSID, D_ItemID)
           );
INSERT INTO Customer VALUES(
   'C11', 'Jane', 'Smith', '124 Brooklyn Ln', 'Worcester', 'MA', '01609', '5083897562', DATE('1990-01-17'));
INSERT INTO Customer VALUES(
   'C12', 'Joe', 'Lambert', '69 Paradise St', 'Worcester', 'MA', '01607', '5084910283', DATE('1984-08-12'));
INSERT INTO Customer VALUES(
   'C13', 'Taylor', 'Johnson', '71 Main St', 'Shrewsbury', 'MA', '01705', '5089102842', DATE('1980-02-05'));
INSERT INTO Customer VALUES(
   'C14', 'Trevor', 'Baker', '192 Charmat Ct', 'Marlborough', 'MA', '01601', '6081926372', DATE('1987-12-07'));
INSERT INTO Customer VALUES(
   'C15', 'Steve', 'Alan', '12 New York St', 'Westborough', 'MA', '01701', '6094728162', DATE('1994-07-30'));
INSERT INTO Customer VALUES(
   'C16', 'Beth', 'Santos', '987 Mayor Ln', 'Springfield', 'MA', '01109', '4139104729', DATE('1997-07-02'));
INSERT INTO Customer VALUES(
   'C17', 'Daniella', 'Hope', '2419  Lake Floyd Circle', 'Worcester', 'MA', '01609', '6432951480', DATE('1993-09-27'));
INSERT INTO Customer VALUES(
   'C18', 'Tom', 'Clark', '1395  Hillside Drive', 'Leominster', 'MA', '01604', '2742283232', DATE('1989-10-31'));
INSERT INTO Customer VALUES(
   'C19', 'Grace', 'May', '2634  Gladwell Street', 'Leicester', 'MA', '01902', '8686213422', DATE('1991-08-09'));
INSERT INTO Customer VALUES(
   'C10', 'Faith', 'Baker', '192 Charmat Ct', 'Paxton', 'MA', '01389', '8255418640', DATE('1975-11-29'));
INSERT INTO Customer VALUES(
   'C21', 'DJ', 'Suarez', '1929  Lilac Lane', 'Natick', 'MA', '01634', '8882273379', DATE('1964-03-26'));
INSERT INTO Customer VALUES(
   'C22', 'Jack', 'Herman', '4278  Tecumsah Lane', 'Attleboro', 'MA', '01690', '9614605035', DATE('1967-12-06'));
INSERT INTO Customer VALUES(
   'C23', 'Nick', 'Dang', '4814  Coolidge Street', 'Boston', 'MA', '29103', '2306452170', DATE('1969-04-20'));
INSERT INTO SalesPerson VALUES(
   'SP1', 'Sarah', 'Cook', '129 Wooster St', 'Shrewsbury', 'MA', '01682', '81920891873', DATE('1983-03-19'));
INSERT INTO SalesPerson VALUES(
   'SP2', 'James', 'Marble', '390 Master Ln', 'Worcester', 'MA', '01602', '5089102932', DATE('1973-12-10'));
INSERT INTO SalesPerson VALUES(
   'SP3', 'Jason', 'Wu', '912 Higgins St', 'Marlborough', 'MA', '01819', '9281029181', DATE('1993-05-29'));
INSERT INTO SalesPerson VALUES(
   'SP4', 'Hannah', 'Gordon', '648 Salisbury St', 'Worcester', 'MA', '01582', '9741290192', DATE('1990-06-09'));
INSERT INTO Instructor VALUES(
   'I11', 'Steve', 'Mayberry', '389 Main St', 'Attleboro', 'MA', '01928', '6781637162', DATE('1976-01-10'));
INSERT INTO Instructor VALUES(
   'I22', 'Lexie', 'Diab', '319 Main St', 'Attleboro', 'MA', '01928', '9281028122', DATE('1979-10-10'));
INSERT INTO Instructor VALUES(
   'I33', 'Teresa', 'Lindell', '420 Plantation St', 'Shrewsbury', 'MA', '01819', '8270182373', DATE('1986-11-29'));
INSERT INTO MembershipType VALUES('A1', 'Elite Plus', 20, 199.99);
INSERT INTO MembershipType VALUES('A2', 'Elite', 15, 159.99);
INSERT INTO MembershipType VALUES('A3', 'Basic', 10, 119.99);
INSERT INTO MembershipSales VALUES('C11', 'SP3', 'A1', DATE('2018-11-28'));
INSERT INTO MembershipSales VALUES('C12', 'SP2', 'A2', DATE('2019-01-18'));
INSERT INTO MembershipSales VALUES('C13', 'SP2', 'A2', DATE('2018-11-18'));
INSERT INTO MembershipSales VALUES('C14', 'SP1', 'A3', DATE('2019-03-21'));
INSERT INTO MembershipSales VALUES('C15', 'SP2', 'A1', DATE('2018-10-12'));
INSERT INTO MembershipSales VALUES('C16', 'SP1', 'A1', DATE('2019-04-17'));
INSERT INTO MembershipSales VALUES('C17', 'SP3', 'A3', DATE('2019-02-11'));
INSERT INTO MembershipSales VALUES('C18', 'SP3', 'A2', DATE('2018-08-05'));
INSERT INTO MembershipSales VALUES('C19', 'SP2', 'A2', DATE('2018-09-19'));
INSERT INTO MembershipSales VALUES('C10', 'SP2', 'A2', DATE('2019-05-22'));
INSERT INTO MembershipSales VALUES('C21', 'SP3', 'A1', DATE('2019-07-31'));
INSERT INTO MembershipSales VALUES('C22', 'SP1', 'A3', DATE('2019-09-01'));
INSERT INTO MembershipSales VALUES('C23', 'SP3', 'A1', DATE('2018-05-15'));
INSERT INTO Merchandise VALUES('01', 'Sweatshirt', 39.99, 27);
INSERT INTO Merchandise VALUES('02', 'Tanktop', 19.99, 9);
INSERT INTO Merchandise VALUES('03', 'Hat', 25.99, 17);
INSERT INTO Merchandise VALUES('04', 'T-shirt', 19.99, 37);
INSERT INTO Merchandise VALUES('05', 'Water Bottle', 9.99, 7);
INSERT INTO Merchandise VALUES('06', 'Towel', 5.99, 39);
INSERT INTO Merchandise VALUES('07', 'Hoodie', 49.99, 22);
INSERT INTO Classes VALUES('CL1', 'Boot Camp', 0900, 60, 'I11');
INSERT INTO Classes VALUES('CL2', 'Yoga', 1000, 45, 'I22');
INSERT INTO Classes VALUES('CL3', 'HIIT', 1100, 60, 'I11');
INSERT INTO Classes VALUES('CL4', 'Aerobics', 1500, 60, 'I33');
INSERT INTO Classes VALUES('CL5', 'Pilates', 1800, 30, 'I33');
INSERT INTO Classes VALUES('CL6', 'Dance', 1200, 45, 'I11');
INSERT INTO Classes VALUES('CL7', 'Bodybuilding', 1900, 90, 'I11');
INSERT INTO ClassEnroll VALUES('CL1', 'C22', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL1', 'C12', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL1', 'C13', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL1', 'C15', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL1', 'C21', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL1', 'C23', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL1', 'C16', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL1', 'C18', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL1', 'C19', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL1', 'C11', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C11', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C12', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C13', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C14', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C15', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C16', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C17', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C18', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C19', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C10', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C21', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C22', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL2', 'C23', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL3', 'C16', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL3', 'C12', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL3', 'C23', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL3', 'C11', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL3', 'C19', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL3', 'C17', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL4', 'C10', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL4', 'C23', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL4', 'C19', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL4', 'C13', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL4', 'C14', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL4', 'C16', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL4', 'C18', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL4', 'C12', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL4', 'C21', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL5', 'C17', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL5', 'C23', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL5', 'C12', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL6', 'C13', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL6', 'C12', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL6', 'C21', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL6', 'C19', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL6', 'C10', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL7', 'C12', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL7', 'C14', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL7', 'C16', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL7', 'C18', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL7', 'C21', DATE('2019-12-11'));
INSERT INTO ClassEnroll VALUES('CL7', 'C23', DATE('2019-12-11'));
INSERT INTO RetailSales VALUES('01', 'C13', DATE('2019-07-09'));
INSERT INTO RetailSales VALUES('02', 'C15', DATE('2019-08-01'));
INSERT INTO RetailSales VALUES('03', 'C19', DATE('2019-07-11'));
INSERT INTO RetailSales VALUES('04', 'C21', DATE('2019-06-29'));
INSERT INTO RetailSales VALUES('05', 'C17', DATE('2019-10-19'));
INSERT INTO RetailSales VALUES('06', 'C13', DATE('2019-04-20'));
INSERT INTO RetailSales VALUES('07', 'C11', DATE('2019-08-19'));
INSERT INTO RetailSales VALUES('08', 'C22', DATE('2019-07-25'));
INSERT INTO RetailSales VALUES('09', 'C18', DATE('2019-09-30'));
INSERT INTO RetailSales VALUES('10', 'C12', DATE('2019-03-17'));
INSERT INTO RetailSales VALUES('11', 'C10', DATE('2019-07-06'));
INSERT INTO RS_Details VALUES('01', '03', 1);
INSERT INTO RS_Details VALUES('01', '07', 2);
INSERT INTO RS_Details VALUES('02', '01', 3);
INSERT INTO RS_Details VALUES('03', '02', 2);
INSERT INTO RS_Details VALUES('03', '07', 4);
INSERT INTO RS_Details VALUES('03', '03', 1);
INSERT INTO RS_Details VALUES('04', '02', 2);
INSERT INTO RS_Details VALUES('04', '05', 1);
INSERT INTO RS_Details VALUES('05', '06', 2);
INSERT INTO RS_Details VALUES('06', '01', 4);
INSERT INTO RS_Details VALUES('07', '02', 1);
INSERT INTO RS_Details VALUES('07', '05', 2);
INSERT INTO RS_Details VALUES('07', '07', 1);
INSERT INTO RS_Details VALUES('08', '02', 1);
INSERT INTO RS_Details VALUES('09', '04', 2);
INSERT INTO RS_Details VALUES('10', '06', 1);
INSERT INTO RS_Details VALUES('11', '01', 1);
INSERT INTO RS_Details VALUES('11', '07', 1);
.save Fitness_Club.DB
.output stdout
.echo OFF
