-- Scenario 1: Return a customer's age in years from their date of birth.

CREATE OR REPLACE FUNCTION CalculateAge (
    p_dob IN DATE
) RETURN NUMBER
AS
    v_age NUMBER;
BEGIN
    v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, p_dob) / 12);
    RETURN v_age;
END CalculateAge;
/

-- Sample call:
-- SELECT CustomerID, Name, CalculateAge(DOB) AS Age FROM Customers;
