-- Scenario 3: Group account-related operations into a package.

CREATE OR REPLACE PACKAGE AccountOperations AS
    PROCEDURE OpenAccount (
        p_account_id   IN Accounts.AccountID%TYPE,
        p_customer_id  IN Accounts.CustomerID%TYPE,
        p_account_type IN Accounts.AccountType%TYPE,
        p_balance      IN Accounts.Balance%TYPE
    );

    PROCEDURE CloseAccount (
        p_account_id IN Accounts.AccountID%TYPE
    );

    FUNCTION GetTotalBalance (
        p_customer_id IN Accounts.CustomerID%TYPE
    ) RETURN NUMBER;
END AccountOperations;
/

CREATE OR REPLACE PACKAGE BODY AccountOperations AS

    PROCEDURE OpenAccount (
        p_account_id   IN Accounts.AccountID%TYPE,
        p_customer_id  IN Accounts.CustomerID%TYPE,
        p_account_type IN Accounts.AccountType%TYPE,
        p_balance      IN Accounts.Balance%TYPE
    ) IS
    BEGIN
        INSERT INTO Accounts (AccountID, CustomerID, AccountType, Balance, LastModified)
        VALUES (p_account_id, p_customer_id, p_account_type, p_balance, SYSDATE);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Account ' || p_account_id || ' opened.');
    EXCEPTION
        WHEN DUP_VAL_ON_INDEX THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Error: Account ID ' || p_account_id || ' already exists.');
    END OpenAccount;

    PROCEDURE CloseAccount (
        p_account_id IN Accounts.AccountID%TYPE
    ) IS
        v_balance Accounts.Balance%TYPE;
    BEGIN
        SELECT Balance INTO v_balance
        FROM Accounts
        WHERE AccountID = p_account_id;

        IF v_balance != 0 THEN
            DBMS_OUTPUT.PUT_LINE('Error: Cannot close account ' || p_account_id ||
                ' - balance must be zero (current balance: ' || v_balance || ').');
        ELSE
            DELETE FROM Accounts WHERE AccountID = p_account_id;
            COMMIT;
            DBMS_OUTPUT.PUT_LINE('Account ' || p_account_id || ' closed.');
        END IF;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Error: Account ID ' || p_account_id || ' not found.');
    END CloseAccount;

    FUNCTION GetTotalBalance (
        p_customer_id IN Accounts.CustomerID%TYPE
    ) RETURN NUMBER IS
        v_total NUMBER;
    BEGIN
        SELECT NVL(SUM(Balance), 0) INTO v_total
        FROM Accounts
        WHERE CustomerID = p_customer_id;
        RETURN v_total;
    END GetTotalBalance;

END AccountOperations;
/

-- Sample calls:
-- BEGIN
--     AccountOperations.OpenAccount(3, 1, 'Savings', 500);
-- END;
-- /
-- SELECT AccountOperations.GetTotalBalance(1) FROM DUAL;
