-- Scenario 1: Transfer funds between accounts, rolling back and logging
-- an error message if anything goes wrong (e.g. insufficient funds).

CREATE OR REPLACE PROCEDURE SafeTransferFunds (
    p_from_account IN Accounts.AccountID%TYPE,
    p_to_account   IN Accounts.AccountID%TYPE,
    p_amount       IN NUMBER
) AS
    v_from_balance       Accounts.Balance%TYPE;
    e_insufficient_funds EXCEPTION;
BEGIN
    SELECT Balance INTO v_from_balance
    FROM Accounts
    WHERE AccountID = p_from_account
    FOR UPDATE;

    IF v_from_balance < p_amount THEN
        RAISE e_insufficient_funds;
    END IF;

    UPDATE Accounts
    SET Balance = Balance - p_amount, LastModified = SYSDATE
    WHERE AccountID = p_from_account;

    UPDATE Accounts
    SET Balance = Balance + p_amount, LastModified = SYSDATE
    WHERE AccountID = p_to_account;

    COMMIT;
    DBMS_OUTPUT.PUT_LINE('Transfer of ' || p_amount || ' from account ' ||
        p_from_account || ' to account ' || p_to_account || ' completed successfully.');

EXCEPTION
    WHEN e_insufficient_funds THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Insufficient funds in account ' || p_from_account || '.');
    WHEN NO_DATA_FOUND THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: One or both account IDs do not exist.');
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: Transfer failed - ' || SQLERRM);
END SafeTransferFunds;
/

-- Sample call:
-- BEGIN
--     SafeTransferFunds(1, 2, 200);
-- END;
-- /
