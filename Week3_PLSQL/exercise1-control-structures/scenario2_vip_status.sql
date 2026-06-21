-- Scenario 2: Set IsVIP = 'Y' for customers with balance over $10,000.
-- (Customers.IsVIP is added in schema.sql.)

DECLARE
    CURSOR c_customers IS
        SELECT CustomerID, Balance FROM Customers;
BEGIN
    FOR cust IN c_customers LOOP
        IF cust.Balance > 10000 THEN
            UPDATE Customers
            SET IsVIP = 'Y'
            WHERE CustomerID = cust.CustomerID;
        ELSE
            UPDATE Customers
            SET IsVIP = 'N'
            WHERE CustomerID = cust.CustomerID;
        END IF;
    END LOOP;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('VIP status refreshed for all customers.');
END;
/
