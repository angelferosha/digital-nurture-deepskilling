-- Scenario 1: Group customer-related procedures and functions into a package.

CREATE OR REPLACE PACKAGE CustomerManagement AS
    PROCEDURE AddCustomer (
        p_customer_id IN Customers.CustomerID%TYPE,
        p_name        IN Customers.Name%TYPE,
        p_dob         IN Customers.DOB%TYPE,
        p_balance     IN Customers.Balance%TYPE
    );

    PROCEDURE UpdateCustomerDetails (
        p_customer_id IN Customers.CustomerID%TYPE,
        p_name        IN Customers.Name%TYPE DEFAULT NULL,
        p_balance     IN Customers.Balance%TYPE DEFAULT NULL
    );

    FUNCTION GetCustomerBalance (
        p_customer_id IN Customers.CustomerID%TYPE
    ) RETURN NUMBER;
END CustomerManagement;
/

CREATE OR REPLACE PACKAGE BODY CustomerManagement AS

    PROCEDURE AddCustomer (
        p_customer_id IN Customers.CustomerID%TYPE,
        p_name        IN Customers.Name%TYPE,
        p_dob         IN Customers.DOB%TYPE,
        p_balance     IN Customers.Balance%TYPE
    ) IS
    BEGIN
        INSERT INTO Customers (CustomerID, Name, DOB, Balance, LastModified)
        VALUES (p_customer_id, p_name, p_dob, p_balance, SYSDATE);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Customer ' || p_customer_id || ' added.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error: Customer ID ' || p_customer_id || ' already exists.');
    END AddCustomer;

    PROCEDURE UpdateCustomerDetails (
        p_customer_id IN Customers.CustomerID%TYPE,
        p_name        IN Customers.Name%TYPE DEFAULT NULL,
        p_balance     IN Customers.Balance%TYPE DEFAULT NULL
    ) IS
    BEGIN
        UPDATE Customers
        SET Name = NVL(p_name, Name),
            Balance = NVL(p_balance, Balance)
        WHERE CustomerID = p_customer_id;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Error: Customer ID ' || p_customer_id || ' not found.');
        ELSE
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Customer ' || p_customer_id || ' updated.');
        END IF;
    END UpdateCustomerDetails;

    FUNCTION GetCustomerBalance (
        p_customer_id IN Customers.CustomerID%TYPE
    ) RETURN NUMBER IS
        v_balance Customers.Balance%TYPE;
    BEGIN
        SELECT Balance INTO v_balance
        FROM Customers
        WHERE CustomerID = p_customer_id;
        RETURN v_balance;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RETURN NULL;
    END GetCustomerBalance;

END CustomerManagement;
/

-- Sample calls:
-- BEGIN
--     CustomerManagement.AddCustomer(4, 'Mia Chen', TO_DATE('1995-03-02','YYYY-MM-DD'), 3000);
--     CustomerManagement.UpdateCustomerDetails(4, p_balance => 3500);
-- END;
-- /
-- SELECT CustomerManagement.GetCustomerBalance(4) FROM DUAL;
