# Spring 2024 ETL advanced project
This monorepo contains all the necessary code for the project.
 
## Intro

For the ETL project, the approach that we took is using AWS-related tools, such as AWS RDS for our OLTP database, and AWS Redshift for the data warehouse. For the actual process, we used AWS glue to extract, transform, and load to the data warehouse and accomplished the full data load and incremental data load.

The sections below will go through the whole process of what we did in each part.

## OLTP

We already have two CSV files, to simulate the business data that we have:
* One has properties like address (from regions down to zip codes), customer information, order information and such.
* One has information about if the order is being returned. 

We then analyzed the business case, normalized the CSV file based on observation, designed the schema on Oracle data modeler, implemented using MySQL, and loaded all data to the entities. The schema is shown below:

<img width="1642" alt="image" src="https://github.com/jLiucoder/Awesome_Inc_ETL_Project/blob/main/oltp.png">

## Data Warehouse

We again used Oracle data modeler to design the schema of our DW, to make it easier for analysts to use and query, we denormalized the database and made it a star schema, as shown below:

<img width="442" alt="image" src="https://github.com/jLiucoder/Awesome_Inc_ETL_Project/blob/main/dw.png">

## ETL 

We took a detour on this part, we were going to use one local machine to control the workflow of the ETL process using the command line, like if we have an Oracle VM and do that locally on the VM. However AWS RDS doesn't support "FILE" SQL functionalities because of security reasons, thus the dumping data part can't be automated through RDS. And after research, we decided glue would be straightforward to integrate within the AWS ecosystem that we already have.

Since the AWS Glue is a serverless ETL approach and the RDS limitations on file manipulation, there's not much code that we need to write, Glue provides a UI for low code operation, we set the source, destination and choose what field we would like to match and transform and it will apply and run the job to extract, transform and load to destination. The full loading and the incremental data loading use the same approach.

In the end, over 100k records are being loaded successfully into the data warehouse, and we can use this as a resource pool for the analysts to perform BI works such as Tablaeu visulizations from day to day.

## Tableau Viz

to be continued...


