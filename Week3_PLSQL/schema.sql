-- ============================================================
-- Schema for PL/SQL Banking Exercises
-- ============================================================
-- Note: two columns/tables beyond the original spec are added here
-- because later exercises depend on them:
--   - Customers.IsVIP   (Exercise 1, Scenario 2)
--   - AuditLog table    (Exercise 5, Scenario 2)
-- ============================================================

CREATE TABLE Customers (
    CustomerID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    DOB DATE,
    Balance NUMBER,
    LastModified DATE,
    IsVIP CHAR(1) DEFAULT 'N'
);

CREATE TABLE Accounts (
    AccountID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    AccountType VARCHAR2(20),
    Balance NUMBER,
    LastModified DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Transactions (
    TransactionID NUMBER PRIMARY KEY,
    AccountID NUMBER,
    TransactionDate DATE,
    Amount NUMBER,
    TransactionType VARCHAR2(10),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

CREATE TABLE Loans (
    LoanID NUMBER PRIMARY KEY,
    CustomerID NUMBER,
    LoanAmount NUMBER,
    InterestRate NUMBER,
    StartDate DATE,
    EndDate DATE,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

CREATE TABLE Employees (
    EmployeeID NUMBER PRIMARY KEY,
    Name VARCHAR2(100),
    Position VARCHAR2(50),
    Salary NUMBER,
    Department VARCHAR2(50),
    HireDate DATE
);

-- Used by Exercise 5, Scenario 2 (LogTransaction trigger)
CREATE TABLE AuditLog (
    AuditID NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    TableName VARCHAR2(50),
    RecordID NUMBER,
    Action VARCHAR2(20),
    ActionDate DATE
);
