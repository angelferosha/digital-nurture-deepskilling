-- Scenario 2: Insert a record into AuditLog whenever a transaction is
-- inserted into Transactions. (AuditLog table is created in schema.sql.)

CREATE OR REPLACE TRIGGER LogTransaction
AFTER INSERT ON Transactions
FOR EACH ROW
BEGIN
    INSERT INTO AuditLog (TableName, RecordID, Action, ActionDate)
    VALUES ('Transactions', :NEW.TransactionID, 'INSERT', SYSDATE);
END;
/
