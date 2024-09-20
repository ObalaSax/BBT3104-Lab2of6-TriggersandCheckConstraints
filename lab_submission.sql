-- CREATE TRG_AFTER_UPDATE_ON_customers
CREATE TRIGGER TRG_BEFORE_UPDATE_ON_customers 
BEFORE UPDATE ON customers FOR EACH ROW 
INSERT INTO 
    `employees_undo` 
    SET `date_of_change` = CURRENT_TIMESTAMP(2), 
    `customerNumber` = OLD.`customerNumber` , 
    `customerLastName` = OLD.`customerLastName` , 
    `customerFirstName` = OLD.`customerFirstName` , 
    `phone` = OLD.`phone` , 
    `addressLine1` = OLD.`addressLine1` , 
    `addressLine2` = OLD.`addressLine2` , 
    `city` = OLD.`city` , 
    `country` = OLD.`country` , 
    `salesRepEmployeeNumber` =OLD.`salesRepEmployeeNumber`,
    `creditLimit` = OLD.`An creditLimit`;

-- UPDATE part
-- Update the check constraint in the table “part” 
--to implement a static and dynamic integrity constraint that states 
--that “part_sellingprice > part_buyingprice” (not greater than or equal to).
ALTER TABLE part
ADD CONSTRAINT CHK_part_sellingprice_GT_buyingprice
CHECK (part_sellingprice > part_buyingprice);


CREATE TABLE part (
    part_no VARCHAR(18) PRIMARY KEY,
    part_description VARCHAR(255),
    part_supplier_tax_PIN VARCHAR(11) CHECK (part_supplier_tax_PIN REGEXP '^[A-Z]{1}[0-9]{9}[A-Z]{1}$'),
    part_supplier_email VARCHAR(55),
    part_buyingprice DECIMAL(10, 2) NOT NULL CHECK (part_buyingprice >= 0),
    part_sellingprice DECIMAL(10, 2) NOT NULL,
    CONSTRAINT CHK_part_sellingprice_GT_buyingprice CHECK (part_sellingprice > part_buyingprice),
    CONSTRAINT CHK_part_valid_supplier_email CHECK (part_supplier_email REGEXP '^[a-zA-Z0-9]{3,}@[a-zA-Z0-9]{1,}\.[a-zA-Z0-9.]{1,}$')
);