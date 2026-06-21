-- Scenario 3: Insert a new customer; log an error and prevent insertion
-- if a customer with the same ID already exists.

CREATE OR REPLACE PROCEDURE AddNewCustomer (
    p_customer_id IN Customers.CustomerID%TYPE,
    p_name        IN Customers.Name%TYPE,
    p_dob         IN Customers.DOB%TYPE,
    p_balance     IN Customers.Balance%TYPE
) AS
BEGIN
    INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
    VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE);

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Customer ' || p_customer_id || ' added successfully.');

EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Customer ID ' || p_customer_id || ' already exists.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Could not add customer - ' || SQLERRM);
END AddNewCustomer;
/

-- Sample call:
-- BEGIN
--     AddNewCustomer(3, 'Carlos Diaz', TO_DATE('1992-01-10','YYYY-MM-DD'), 2200);
-- END;
-- /
