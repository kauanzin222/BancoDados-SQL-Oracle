# FATEC SOROCABA
  
# LIST 01 - SQL 🔐
An academic repository destiny to learn some concepts and sintaxes of SQL Developer (Oracle). [Click here to see the resolution script](https://github.com/kauanzin222/DataBase-Activities/blob/main/lists/script_list1.sql).
  
### Prepare the database for the tests to be performed as follows:

    - Add a new patient with code = 55

    - Add a query with code 200 with the query value column equal to zero.
  

### Write SQL commands to:

    1. Create a new column in the patient table with the name "Country" varchar2(15);
  
    2. Change the address column in the patient table to 28 positions.
  
    3. Delete the new column created in exercise 1.
  
    4. Include the NOT NULL constraint in the address column.
  
    5. Change the patient's date of birth from code = 1 to "01-09-1990".
  
    6. Change the discount field for all patients to "N".
  
    7. In the Patient table, change the address field to 'Rua Melo Alves, 40' and the city to 'Itu' for patient code = 2.
  
    8. Delete appointment 200 only if the appointment value field is zero.
  
    9. Delete patient code 55.

    10. Delete all female patients from the city of Sorocaba.

    11. Change the discount field for all female patients over 60 to 'S'.

    12. Create a new field in the patient table to record the patient's cell phone number. This field should be varchar2(15). Enter the patient's phone number in this new field.
---


### - Table_Consulta 📑
| CODCONSULTA 	| CODPACIENTE 	| CODMEDICO 	| DATACONSULTA 	| VALORCONSULTA 	|
|-------------	|-------------	|-----------	|--------------	|---------------	|
| 100         	| 1           	| 5         	| 10/10/23     	| 150           	|
| 200         	| 3           	| 2         	| 11/10/23     	| 250.5         	|
| 300         	| 2           	| 1         	| 12/10/23     	| 300           	|
| 400         	| 5           	| 4         	| 12/10/23     	| 220           	|
| 500         	| 4           	| 3         	| 13/10/23     	| 280.75        	|
| 600         	| 7           	| 5         	| 14/10/23     	| 150           	|
| 700         	| 6           	| 2         	| 15/10/23     	| 250.5         	|
| 800         	| 9           	| 1         	| 16/10/23     	| 300           	|
| 900         	| 8           	| 4         	| 17/10/23     	| 220           	|
| 1000        	| 10          	| 3         	| 18/10/23     	| 280.75        	|

---

### - Table_Paciente 🙍
| CODPACIENTE 	| NOME                     	| SEXO 	| DATANASC 	| ENDERECO                   	| CIDADE         	| IDADE 	| DESCONTO 	| TELEFONE     	|
|-------------	|--------------------------	|------	|----------	|----------------------------	|----------------	|-------	|----------	|--------------	|
| 1           	| Ana Clara Silva          	| F    	| 01/09/90 	| Rua das Flores, 123        	| São Paulo      	| 45    	| N        	| 15 991202020 	|
| 2           	| João Pedro Santos        	| M    	| 20/02/85 	| Rua Melo Alves,40          	| Itu            	| 55    	| N        	| 15 991202020 	|
| 4           	| Carlos Alberto Pereira   	| M    	| 10/07/78 	| Alameda dos Anjos, 45      	| Campinas       	| 35    	| N        	| 15 991202020 	|
| 5           	| Fernanda Lima Costa      	| F    	| 25/01/95 	| Travessa das Palmeiras, 99 	| Santos         	| 50    	| N        	| 15 991202020 	|
| 6           	| Lucas Gabriel Souza      	| M    	| 03/09/98 	| Rua do Comércio, 500       	| Jundiaí        	| 46    	| N        	| 15 991202020 	|
| 7           	| Juliana Martins Lima     	| F    	| 12/03/82 	| Avenida Brasil, 210        	| Rio de Janeiro 	| 25    	| N        	| 15 991202020 	|
| 8           	| Rafael Augusto Ferreira  	| M    	| 08/06/05 	| Praça da Sé, 1             	| São Paulo      	| 15    	| N        	| 15 991202020 	|
| 9           	| Camila Vitória Alves     	| F    	| 19/08/99 	| Rua Augusta, 1120          	| São Paulo      	| 75    	| S        	| 15 991202020 	|
| 10          	| Bruno Henrique Rodrigues 	| M    	| 01/12/88 	| Rua Direita, 32            	| Sorocaba       	| 40    	| N        	| 15 991202020 	|
