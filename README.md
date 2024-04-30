# Spring 2024 ETL advanced project.
This monorepo contains all the necessary code for the project.
 
## Intro

For the ETL project, the approach that we took is using AWS-related tools, such as AWS RDS for our OLTP database, and AWS Redshift for data warehouse. And for the actual process, we used AWS glue to extract, transform and load to the data warehouse, and accomplished the full data load and incremental data load.

The sections below will go through the whole process of what we did in each part.

## OLTP

To simulate the business data, what we already have is two CSV files:
* One has properties like address (from regions down to zip codes), customer information, order information and such.
* One has information about if the order is being returned. 

We then analyzed the business case, normalized the CSV file based on observation, designed the schema on Oracle data modeler and implemented using MySQL, and loaded all data to the entities. The schema is shown below:

<img width="1642" alt="image" src="https://github.com/jLiucoder/Awesome_Inc_ETL_Project/blob/main/oltp.png">
## Data Warehouse

We again used Oracle data modeler to design the schema of our DW, to make it easier for analysts to use and query, we denormalized the database and made it a star schema, as shown below:

<img width="642" alt="image" src="https://github.com/jLiucoder/Awesome_Inc_ETL_Project/blob/main/dw.png">

## ETL 

We took a detour on this part, we were going to use one local machine to control and workflow of the ETL process using command line, like what we went over in class. But AWS RDS doesn't support out-of-file SQL functionalities because of security reasons, thus we decided to use the AWS approach, after research we decided glue would be straight forward to integrate.

.. to be continued


