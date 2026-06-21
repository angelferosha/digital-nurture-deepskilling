-- Scenario 3: Before a transaction is inserted, ensure withdrawals don't
-- exceed the account balance and deposits are positive.

CREATE OR REPLACE TRIGGER CheckTransactionRules
BEFORE INSERT ON Transactions
FOR EACH ROW
DECLARE
    v_balance Accounts.Balance%TYPE;
BEGIN
    SELECT Balance INTO v_balance
    FROM Accounts
    WHERE AccountID = :NEW.AccountID;

    IF :NEW.TransactionType = 'Withdrawal' AND :NEW.Amount > v_balance THEN
        RAISE_APPLICATION_ERROR(-20001, 'Withdrawal amount exceeds account balance.');
    ELSIF :NEW.TransactionType = 'Deposit' AND :NEW.Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20002, 'Deposit amount must be positive.');
    ELSIF :NEW.TransactionType = 'Withdrawal' AND :NEW.Amount <= 0 THEN
        RAISE_APPLICATION_ERROR(-20003, 'Withdrawal amount must be positive.');
    END IF;
END;
/
