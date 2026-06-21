-- Scenario 3: Transfer a specified amount between accounts, checking that
-- the source account has a sufficient balance before transferring.

CREATE OR REPLACE PROCEDURE TransferFunds (
    p_from_account IN Accounts.AccountID%TYPE,
    p_to_account   IN Accounts.AccountID%TYPE,
    p_amount       IN NUMBER
) AS
    v_from_balance Accounts.Balance%TYPE;
BEGIN
    SELECT Balance INTO v_from_balance
    FROM Accounts
    WHERE AccountID = p_from_account
    FOR UPDATE;

    IF v_from_balance >= p_amount THEN
        UPDATE Accounts
        SET Balance = Balance - p_amount, LastModified = SYSDATE
        WHERE AccountID = p_from_account;

        UPDATE Accounts
        SET Balance = Balance + p_amount, LastModified = SYSDATE
        WHERE AccountID = p_to_account;

        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Transferred ' || p_amount || ' from account ' ||
            p_from_account || ' to account ' || p_to_account || '.');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Transfer failed: account ' || p_from_account ||
            ' has insufficient balance.');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Error: Source account ' || p_from_account || ' not found.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Transfer failed - ' || SQLERRM);
END TransferFunds;
/

-- Sample call:
-- BEGIN
--     TransferFunds(1, 2, 150);
-- END;
-- /
