# MIS571 Fitness Studio Database

## Group Members
   Arushi Vyas, Hamidullah Sakhi, Jannik Haas, Raymond Magambo, Ruyun Chen

## Problem Description
Our goal is to design a database for our fitness studio to keep a better overview of our accounts and memberships. The fitness studio offers a variety of daily classes and offers different membership options with varying number of classes that members are allowed to take. The studio also sells retail merchandise such as T-shirts, water bottles, sweatshirts, etc. We will also need to keep track of our employees which include salespeople and instructors. 

### What our database will include and generate reports on: 
- Revenue: The income that our business takes in from normal operations and activities. We will be able to track and compare the different sources of income such as merchandise and memberships. This will also help us be able to understand what items sell the best and be able to focus on advertising these items.
- Class enrollment: Our database will also track class enrollment so we can see which members are signed up for which classes. This will also give us a better understanding of what type of class members enjoy and adjust our schedule to accommodate customers' needs.
- Membership sales: The Fitness studio offers various membership options with varying numbers of classes that customers are allowed to take per month. Tracking how many customers hold each type of membership will give us a better understanding of our customers’ needs. 
- Retail sales: Tracking retails sales allows us to order more merchandise when we are running low as well as seeing what type of items sell best and creating more similar items.
- Employee performance: The database will keep track of the number of memberships sold by each employee which will give the manager concrete statistics to reward outstanding employees and to focus on improving the performance of underperforming employees.

## Conceptual Model 
![Alt text](images/ConceptualModel.png)

## Third Normal Form Relations

**Customer (<u>CID</u>**, FName, LName, Birthdate, Address, City, State, Zip, Phone)

**MembershipSales (<u>M_CID, M_SPID, M_MTypeID</u>**, Date_Sold)

**SalesPerson (<u>SPID</u>**, FName, LName, Address, City, State, Zip, Phone, Birthdate)

**MembershipType (<u>MTypeID</u>**, Num_Classes, MPrice, MName)

**RetailSales (<u>RSID</u>**, RS_CID, DateSold)

**RS_Details (<u>D_RSID, D_ItemID</u>**, Quantity)

**Merchandise (<u>ItemID</u>**, ItemDesc, ItemPrice, QOH)

**ClassEnroll (<u>CE_ClassID, Class_Date,CE_CID</u>**)

**Classes (<u>ClassID</u>**, ClassDesc, ClassLength, ClassTime, IID)

**Instructor (<u>IID</u>**, FName, LName, Address, City, State, Zip, Phone, Birthdate)
 
## Entity Relationships 

The relationships captured in our database are as follows: Each customer buys a membership from one salesperson. The relationship is 1:N so that a customer can change their membership later on to a different membership without the database losing information from the first membership sales. Customers can also enroll in many classes and each class can have many customers in it, but customers do not have to be enrolled in classes so that we can store customer information before they have signed up for a class. Similarly, classes do not have to have enrollment so that we can add classes before members sign up for them. Each class is taught by one instructor, and every instructor can teach many classes. On the membership sales aspect of the business, every salesperson can sell many memberships and each type of membership can be sold to many members. Our merchandise is purchased by customers and since customers may buy more than one item at once we have included a detailed table to keep track of the items sold. 

### Business/Employee Queries:
1. List all customers from a specific City (Worcester)
~~~~mysql
SELECT *
FROM Customer
WHERE Customer.City = 'Worcester';
~~~~

2. List all customers with a specific membership type (Elite Plus)
~~~~mysql
SELECT Customer.CID, Customer.FName, Customer.LName, MembershipType.MName 
FROM Customer, MembershipSales, MembershipType
WHERE Customer.CID=MembershipSales.M_CID AND MembershipSales.M_MTypeID = MembershipType.MTypeID AND MembershipType.MName = 'Elite Plus'; 
~~~~

3. List all customers who are enrolled in a specific class (Bodybuilding)
~~~~mysql
SELECT Customer.FName, Customer.LName
FROM Customer, Classes, ClassEnroll
WHERE Customer.CID = ClassEnroll.CE_CID
AND ClassEnroll.CE_ClassID = Classes.ClassID
AND Classes.ClassDesc = 'Bodybuilding';
~~~~

4. List all customers and their membership type 
~~~~mysql
SELECT Customer.Cid, Customer.FName, Customer.LName, MembershipType.MName 
FROM Customer, MembershipSales, MembershipType
WHERE Customer.CID = MembershipSales.M_CID AND MembershipType.MTypeID = MembershipSales.M_MTypeID;
~~~~

5. List customers and membership price that he/she paid, but only list those customers whose membership costs more than $120
~~~~mysql
SELECT Customer.cid, Customer.FName, Customer.LName, MembershipType.MPrice 
FROM Customer, MembershipSales, MembershipType
WHERE Customer.CID=MembershipSales.M_CID 
AND MembershipType.MTypeID= MembershipSales.M_MTypeID 
AND MembershipType.MPrice > 120
ORDER BY MembershipType.MPrice;
~~~~

6. List the sales person and the number of each membership type that he/she sold
~~~~mysql
SELECT SalesPerson.SPID,SalesPerson.FName, SalesPerson.LName, MembershipType.MName, COUNT(MembershipType.MName)
FROM SalesPerson, MembershipSales, MembershipType
WHERE SalesPerson.SPID=MembershipSales.M_SPID AND 
MembershipSales.M_MTypeID=MembershipType.MTypeID 
GROUP BY SalesPerson.SPID, MembershipType.MName;
~~~~

6. Show the overall revenue from the membership sales of a specific salesperson (Jason Wu)
~~~~mysql 
SELECT SUM(MembershipType.MPrice) AS SALES_BY_JASON
FROM SalesPerson, MembershipSales, MembershipType
WHERE SalesPerson.SPID=MembershipSales.M_SPID AND 
MembershipSales.M_MTypeID=MembershipType.MTypeID 
AND SalesPerson.FName='Jason' AND SalesPerson.LName='Wu'; 
~~~~

7. List all sales persons who haven’t sold any memberships
~~~~mysql
SELECT SalesPerson.SPID,SalesPerson.FName,SalesPerson.LName 
FROM SalesPerson  where SalesPerson.SPID NOT IN 
(SELECT SalesPerson.SPID 
FROM SalesPerson, MembershipSales
WHERE SalesPerson.SPID=MembershipSales.M_SPID); 
~~~~

8. List all the membership sales in order by date
~~~~mysql
SELECT MembershipSales.DateSold, SalesPerson.FName, SalesPerson.LName
FROM MembershipSales, SalesPerson
WHERE MembershipSales.M_SPID= SalesPerson.SPID 
ORDER BY MembershipSales.DateSold; 
~~~~
9. List all retail sales, the customer that bought it and the total price of the sale
~~~~mysql
SELECT   RetailSales.RSID, Customer.FName, Customer.LName, SUM(ItemPrice) AS Total_Price 
FROM Customer, RetailSales, RS_Details, Merchandise
WHERE Customer.CID = RetailSales.RS_CID
AND RetailSales.RSID = RS_Details.D_RSID
AND RS_Details.D_ItemID = Merchandise.ItemID
GROUP BY Customer.CID, RetailSales.RSID
ORDER BY RetailSales.RSID;
~~~~

10. Show the total number of each item sold
~~~~mysql
SELECT Merchandise.ItemDesc, SUM(RS_Details.Quantity) AS Tot_Quant
FROM RS_Details, Merchandise
WHERE Merchandise.ItemID = RS_Details.D_ItemID
GROUP BY ItemID
ORDER BY Tot_Quant DESC;
~~~~

11. List the total number of customers that hold each membership type
~~~~mysql
SELECT  MembershipType.MName, COUNT(MembershipType.MPrice) AS TOTAL_SALES
FROM MembershipType, MembershipSales
WHERE MembershipSales.M_MTypeID = MembershipType.MTypeID 
GROUP BY MembershipType.MName; 
~~~~

12. Calculate the total value of the inventory of each merchandise item
~~~~mysql
SELECT Merchandise.ItemDesc, (Merchandise.ItemPrice * Merchandise.QOH) as Inventory_Value 
FROM Merchandise, RS_Details
WHERE Merchandise.ItemID = RS_Details.D_ItemID;
~~~~

13. Show the number of people enrolled in each class 
~~~~mysql
SELECT Classes.ClassDesc, ClassEnroll.Class_Date, Count(CE_ClassID) 
FROM Classes, ClassEnroll
WHERE Classes.ClassID = ClassEnroll.CE_ClassID
GROUP BY ClassID, Class_Date
ORDER BY ClassDesc;
~~~~

### Customer Queries
1. Show all the membership options and the number of classes allowed 
~~~~mysql 
SELECT MName, MPrice, Num_Classes
FROM MembershipType;
~~~~

2. Show all classes available and the instructor that coaches it
~~~~mysql
SELECT Classes.ClassDesc, Classes.ClassTime, Classes.ClassLength, Instructor.FName
FROM Instructor, Classes
WHERE Instructor.IID = Classes.IID;
~~~~ 

3. Show all the merchandise available for purchase
~~~~mysql
SELECT ItemDesc, ItemPrice
FROM Merchandise;
~~~~ 

4. Show all the instructors at the studio
~~~~mysql
SELECT FName, LName
FROM Instructor;
~~~~

## Android App Navigation 

As shown in the hierarchy chart of the app. The main homepage of the app consists of two buttons: Employee and Customer. Then based on the user selection, it will be directed to either employee or customer subpages. In Employee, the login page will be shown and after user authentication main employee page will appear where the employee can add classes, update customer information, and generate reports. On the other hand, if in the main page user selects the Customer button, it will be directed to the Customer main page where new customer can sign up, if already signed up, he can enroll in classes or get more information about  the Membership  Options, Classes, Merchandise Items, and Instructors. 

![Alt text](images/AppHierarchy.png)
App screenshots: 
![Alt text](images/AppScreenshots.png)
![Alt text](images/AppScreenshots2.png)

## Potential Data Quality Problems and How to Reduce Them

Without the use of other advanced or medium levels of relational database management systems, data quality and data insurance is hard to implement. In this project, using the features of relational databases and SQlite, we have implemented constraints and limitations to ensure duplicated data is not entered. Also, using the NOT NULL constraints, we have made sure that all required information is entered while filling out the forms. 

However, there are still some risks identified in this system. Right now, Fitness Studio cannot verify the information that the users provide. Besides, right now the customer can fill as many forms as he wants and this will create data discrepancy and data reliability problem.
