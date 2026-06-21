-- Scenario 1: Apply a 1% discount to loan interest rates for customers above 60.

DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, DOB FROM Customers;

    v_age NUMBER;
BEGIN
    FOR cust IN c_customers LOOP
        v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, cust.DOB) / 12);

        IF v_age > 60 THEN
            UPDATE Loans
            SET InterestRate = InterestRate - (InterestRate * 0.01)
            WHERE CustomerID = cust.CustomerID;
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Senior loan discount applied.');
END;
/
