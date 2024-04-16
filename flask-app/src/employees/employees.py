from flask import Blueprint, request, jsonify, make_response, current_app
import json
from src import db


employees = Blueprint('employees', __name__)

# Get all employees from the DB
@employees.route('/employees', methods=['GET'])
def get_employees():
    cursor = db.get_db().cursor()
    cursor.execute(
        'SELECT `EmployeeID`, `ManagerID`, `FirstName`, `LastName`, \
            `Position`, `Email`, `HireDate`, `AccessLevel` \
        FROM Employees \
        ORDER BY EmployeeID')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# Get employees detail for employees with particular EmployeeID
@employees.route('/employees/<employeesID>', methods=['GET'])
def get_employees(employeesID):
    cursor = db.get_db().cursor()
    cursor.execute(
        f"SELECT EmployeeID, ManagerID, FirstName, LastName, \
            Position, Email, HireDate, AccessLevel \
        FROM Employees \
        WHERE EmployeeID = '{employeesID}'
        ORDER BY EmployeeID")
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# add a book to the db
@employees.route('/employees', methods=['POST'])
def add_new_book():
    
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # extracting the variable
    employee_id = the_data['employee_id']
    manager_id = the_data['manager_id']
    firstname = the_data['employee_firstname']
    lastname = the_data['employee_lastname']
    position = the_data['position']
    email = the_data['email']
    hiredate = the_data['hiredate']
    accesslevel = the_data['accesslevel']

    # # Constructing the query
    query = f"insert into employees (EmployeeID, ManagerID, FirstName, LastName, \
            Position, Email, HireDate, AccessLevel) values ('{employee_id}', '{manager_id}', \
                {firstname}, '{lastname}', '{position}', \
        {email}, {hiredate}, {accesslevel})"

    # executing and committing the insert statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

@books.route('/employees', methods=['PUT'])
def update_book():
    # collecting data from the request object 
    the_data = request.json
    current_app.logger.info(the_data)

    # extracting the variable
    employee_id = the_data['employee_id']
    manager_id = the_data['manager_id']
    firstname = the_data['employee_firstname']
    lastname = the_data['employee_lastname']
    position = the_data['position']
    email = the_data['email']
    hiredate = the_data['hiredate']
    accesslevel = the_data['accesslevel']

    # Constructing the query 
    query = f'update employees set `EmployeeID` = "{employee_id}", `manager_id` = "{title}",\
          `FirstName` = {firstname}, `lastname` = "{firstname}", `Position` = "{position}", \
            `Email` = {email} where `HireDate` = "{hiredate}", `AccessLevel` = "{accesslevel}"'
    current_app.logger.info(query)

    # executing and committing the update statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'

# remove an employees from the database
@employees.route('/employees', methods=['DELETE'])
def remove_book():
    the_data = request.json
    current_app.logger.info(the_data)

    employee_id = the_data['employee_id']

    query = f'delete from employees where `EmployeeID`="{employee_id}"'
    current_app.logger.info(query)

    # executing and committing the update statement 
    cursor = db.get_db().cursor()
    cursor.execute(query)
    db.get_db().commit()
    
    return 'Success!'
