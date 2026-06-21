-- Scenario 1: Automatically set LastModified to the current date whenever
-- a customer's record is updated.

CREATE OR REPLACE TRIGGER UpdateCustomerLastModified
BEFORE UPDATE ON Customers
FOR EACH ROW
BEGIN
    :NEW.LastModified := SYSDATE;
END;
/
