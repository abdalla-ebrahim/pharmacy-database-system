-- the Pharmacy Management System

-- Table for Doctors
CREATE TABLE Doctors (
    SSN VARCHAR(15) PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255),
    YearsOfExperience INT,
    PhoneNumber VARCHAR(15)
);

-- Table for Patients
CREATE TABLE Patients (
    SSN VARCHAR(15) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    MiddleName VARCHAR(50),
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Gender CHAR(1),
    Age INT,
    PrimaryDoctorSSN VARCHAR(15),
    FOREIGN KEY (PrimaryDoctorSSN) REFERENCES Doctors(SSN)
);

-- Table for Drug Manufacturers
CREATE TABLE DrugManufacturers (
    CompanyID INT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL,
    Address VARCHAR(255)
);

-- Table for Drugs
CREATE TABLE Drugs (
    TradeName VARCHAR(100) PRIMARY KEY,
    Formula VARCHAR(255) NOT NULL,
    ExpiryDate DATE,
    ManufacturerID INT,
    FOREIGN KEY (ManufacturerID) REFERENCES DrugManufacturers(CompanyID) 
    ON DELETE CASCADE
);

-- Table for Pharmacies
CREATE TABLE Pharmacies (
    Name VARCHAR(100) PRIMARY KEY,
    Address VARCHAR(255),
    PhoneNumber VARCHAR(15),
    Location VARCHAR(100)
);

-- Table for Prescriptions
CREATE TABLE Prescriptions (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    PatientSSN VARCHAR(15),
    DoctorSSN VARCHAR(15),
    DrugTradeName VARCHAR(100),
    Quantity INT,
    FOREIGN KEY (PatientSSN) REFERENCES Patients(SSN),
    FOREIGN KEY (DoctorSSN) REFERENCES Doctors(SSN),
    FOREIGN KEY (DrugTradeName) REFERENCES Drugs(TradeName)
);

-- Table for Drug Prices at Pharmacies
CREATE TABLE PharmacyDrugPrices (
    PharmacyName VARCHAR(100),
    DrugTradeName VARCHAR(100),
    Price DECIMAL(10, 2),
    PRIMARY KEY (PharmacyName, DrugTradeName),
    FOREIGN KEY (PharmacyName) REFERENCES Pharmacies(Name),
    FOREIGN KEY (DrugTradeName) REFERENCES Drugs(TradeName)
);

-- Table for Contracts
CREATE TABLE Contracts (
    ContractID INT AUTO_INCREMENT PRIMARY KEY,
    PharmacyName VARCHAR(100),
    ManufacturerID INT,
    StartDate DATE,
    EndDate DATE,
    TextOfContract TEXT,
    Supervisor VARCHAR(100),
    FOREIGN KEY (PharmacyName) REFERENCES Pharmacies(Name),
    FOREIGN KEY (ManufacturerID) REFERENCES DrugManufacturers(CompanyID)
);

-- Insert examples for Doctors
INSERT INTO Doctors (SSN, Name, Address, YearsOfExperience, PhoneNumber) 
VALUES ('234567891', 'Dr. Ahmed', 'Smouha', 9, '01055501234'),
       ('345678912', 'Dr. Mostafa', 'Sidi Gaber', 7, '01155502345'),
       ('456789123', 'Dr. Mona', 'Stanley', 12, '01255503456');

-- Insert examples for Patients
INSERT INTO Patients (SSN, FirstName, MiddleName, LastName, Address, PhoneNumber, Gender, Age, PrimaryDoctorSSN) 
VALUES ('511223344', 'Abdalla', 'M.', 'Hassan', 'Fleming', '01055504567', 'M', 21, '234567891'),
       ('522334455', 'Ahmed', 'K.', 'Youssef', 'Miami', '01155505678', 'M', 23, '345678912'),
       ('533445566', 'Sara', 'T.', 'Mahmoud', 'Louran', '01255506789', 'F', 26, '456789123'),
       ('544556677', 'Omar', 'N.', 'Farouk', 'San Stefano', '01555507890', 'M', 30, '234567891');

-- Insert examples for Drug Manufacturers
INSERT INTO DrugManufacturers (CompanyID, Name, Address) 
VALUES (1, 'Alex Pharma', 'Alexandria'),
       (2, 'Nile Care', 'Cairo'),
       (3, 'Delta Medical', 'Tanta');

-- Insert examples for Drugs
INSERT INTO Drugs (TradeName, Formula, ExpiryDate, ManufacturerID) 
VALUES ('Panadol Extra', 'C8H9NO2 + C8H10N4O2', '2027-05-31', 1),
       ('Vitamin C 500', 'C6H8O6', '2027-11-30', 2),
       ('Brufen 400', 'C13H18O2', '2026-12-31', 1),
       ('Antinal', 'C12H9N3O5', '2027-03-31', 3),
       ('Aspocid 75', 'C9H8O4', '2028-01-31', 2);

-- Insert examples for Pharmacies
INSERT INTO Pharmacies (Name, Address, PhoneNumber, Location) 
VALUES ('Ahmed Pharmacy', 'Sporting', '03-4245759', 'Alexandria'),
       ('El Shifa Pharmacy', 'Ibrahimia', '03-4249663', 'Alexandria'),
       ('El Salam Pharmacy', 'Miami', '03-5831207', 'Alexandria');

-- Insert examples for Prescriptions
INSERT INTO Prescriptions (PatientSSN, DoctorSSN, DrugTradeName, Quantity) 
VALUES ('511223344', '234567891', 'Panadol Extra', 2),
       ('522334455', '345678912', 'Brufen 400', 1),
       ('533445566', '456789123', 'Vitamin C 500', 3),
       ('544556677', '234567891', 'Antinal', 1),
       ('511223344', '234567891', 'Aspocid 75', 2);

-- Insert examples for Pharmacy Drug Prices
INSERT INTO PharmacyDrugPrices (PharmacyName, DrugTradeName, Price) 
VALUES ('Ahmed Pharmacy', 'Panadol Extra', 18.00),
       ('Ahmed Pharmacy', 'Brufen 400', 30.50),
       ('El Shifa Pharmacy', 'Vitamin C 500', 25.00),
       ('El Shifa Pharmacy', 'Panadol Extra', 17.50),
       ('El Salam Pharmacy', 'Antinal', 22.75),
       ('El Salam Pharmacy', 'Aspocid 75', 12.25);

-- Insert examples for Contracts
INSERT INTO Contracts (PharmacyName, ManufacturerID, StartDate, EndDate, TextOfContract, Supervisor) 
VALUES ('Ahmed Pharmacy', 1, '2024-01-01', '2026-12-31', 'Supply agreement between Ahmed Pharmacy and Alex Pharma.', 'Eng. Karim'),
       ('El Shifa Pharmacy', 2, '2024-06-01', '2027-05-31', 'Supply agreement between El Shifa Pharmacy and Nile Care.', 'Mr. Tarek'),
       ('El Salam Pharmacy', 3, '2024-09-15', '2026-09-14', 'Supply agreement between El Salam Pharmacy and Delta Medical.', 'Mrs. Heba');

-- Select queries for each table
SELECT * FROM Doctors;
SELECT * FROM Patients;
SELECT * FROM DrugManufacturers;
SELECT * FROM Drugs;
SELECT * FROM Pharmacies;
SELECT * FROM Prescriptions;
SELECT * FROM PharmacyDrugPrices;
SELECT * FROM Contracts;
