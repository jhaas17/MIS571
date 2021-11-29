Fitness Club Queries

# List Customers from Worcester.
SELECT *
FROM Customer
WHERE Customer.City = "Worcester";

#List all the customers with Elite Plus membership type.
SELECT Customer.CID, Customer.FName, Customer.LName, MembershipType.MName FROM Customer, MembershipSales, MembershipType
WHERE Customer.CID=MembershipSales.M_CID AND MembershipSales.M_MTypeID = MembershipType.MTypeID AND MembershipType.MName = "Elite Plus"; 

#List Instructor’s first name, last name and details of  the classes that  he/she coaches. 
SELECT Instructor.FName, Instructor.LName, Classes.ClassDesc, Classes.ClassTime,Classes.ClassLength
FROM Instructor, Classes
WHERE Instructor.IID = Classes.IID
ORDER BY Instructor.FName;

#List Customers who take bodybuild class.
SELECT Customer.CID, Customer.FName, Customer.LName, Classes.ClassDesc
FROM Customer, Classes, ClassEnroll
WHERE Customer.CID = ClassEnroll.CE_CID
AND ClassEnroll.CE_ClassID =Classes.ClassID
AND Classes.ClassDesc = "Bodybuilding";

#List Customer ID, first name, last name and Membership price that he/she paid.
SELECT Customer.cid, Customer.FName, Customer.LName, MembershipType.MPrice FROM Customer, MembershipSales, MembershipType
WHERE Customer.CID=MembershipSales.M_CID AND MembershipType.MTypeID= MembershipSales.M_MTypeID;

#List Customer ID, first name, last name and Membership price that he/she paid, but only list the customers and the membership price for those customers whose price amount is greater than $120.
SELECT Customer.CID, Customer.FName, Customer.LName, MembershipType.MPrice FROM Customer, MembershipSales, MembershipType
WHERE Customer.CID=MembershipSales.M_CID AND MembershipType.MTypeID= MembershipSales.M_MTypeID AND MembershipType.MPrice>120;

#List the average price of merchandise items.
SELECT AVG(ItemPrice) as Average_Price 
FROM Merchandise;

#List SalesPerson ID and number of Membership that he/she sold.
SELECT SalesPerson.SPID,SalesPerson.FName, SalesPerson.LName, COUNT(MembershipType.MName)
FROM SalesPerson, MembershipSales, MembershipType
WHERE SalesPerson.SPID=MembershipSales.M_SPID AND 
MembershipSales.M_MTypeID=MembershipType.MTypeID 
GROUP by MembershipType.MName; 


#List all the sales that are done by Salesperson Jason Wu. 
SELECT SUM(MembershipType.MPrice) AS SALES_BY_JASON
FROM SalesPerson, MembershipSales, MembershipType
WHERE SalesPerson.SPID=MembershipSales.M_SPID AND 
MembershipSales.M_MTypeID=MembershipType.MTypeID 
AND SalesPerson.FName='Jason' AND SalesPerson.LName='Wu'; 


#List salesperson who has not sold any membership.
SELECT SalesPerson.SPID, SalesPerson.FName, SalesPerson.LName 
FROM SalesPerson  where SalesPerson.SPID NOT IN 
(SELECT SalesPerson.SPID 
FROM SalesPerson, MembershipSales
WHERE SalesPerson.SPID=MembershipSales.M_SPID); 


#List all the membership sales in order by Date.
SELECT MembershipSales.M_CID, MembershipSales.DateSold, SalesPerson.FName, SalesPerson.LName
FROM MembershipSales, SalesPerson
WHERE MembershipSales.M_SPID= SalesPerson.SPID 
ORDER BY MembershipSales.DateSold DESC; 

#List total price of retail items that each customer paid for.
SELECT   Customer.FName, Customer.LName, SUM(ItemPrice) AS Total_Price 
FROM Customer, RetailSales, RS_Details, Merchandise
WHERE Customer.CID = RetailSales.RS_CID
AND RetailSales.RSID = RS_Details.D_RSID
AND RS_Details.D_ItemID = Merchandise.ItemID
GROUP BY Customer.CID;


#List total number of each membership type sold. 
SELECT  MembershipType.MName, COUNT(MembershipType.MPrice) AS TOTAL_SALES
FROM MembershipType, MembershipSales
WHERE MembershipSales.M_MTypeID = MembershipType.MTypeID 
GROUP BY MembershipType.MName; 
        

#Calculate the value of each merchandise item. 
SELECT ItemDesc, (ItemPrice * QOH) as Value FROM Merchandise;



