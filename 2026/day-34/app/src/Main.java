package src;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class Main {

    public static void main(String[] args) {
        String url = "jdbc:mysql://db:3306/testdb"; // 'db' is docker-compose service name
        String user = "root";
        String password = "password";

        try {
            Connection conn = DriverManager.getConnection(url, user, password);
            Statement stmt = conn.createStatement();

            // Create employee table
            stmt.execute("CREATE TABLE IF NOT EXISTS employee (" +
                    "id INT PRIMARY KEY, " +
                    "name VARCHAR(100), " +
                    "department VARCHAR(50), " +
                    "salary DOUBLE)");

            // CREATE - Insert employees
            stmt.execute("INSERT IGNORE INTO employee (id, name, department, salary) " +
                    "VALUES (1, 'Ajay Kumar', 'IT', 50000.0), " +
                    "(2, 'Rita Singh', 'HR', 45000.0)");

            // READ - Select all employees
            System.out.println("=== Employee List ===");
            ResultSet rs = stmt.executeQuery("SELECT * FROM employee");
            while (rs.next()) {
                System.out.println(
                        "ID: " + rs.getInt("id") +
                        ", Name: " + rs.getString("name") +
                        ", Dept: " + rs.getString("department") +
                        ", Salary: " + rs.getDouble("salary")
                );
            }

            // UPDATE - Change salary for employee id 1
            stmt.execute("UPDATE employee SET salary = 55000.0 WHERE id = 1");

            // DELETE - Remove employee id 2
            stmt.execute("DELETE FROM employee WHERE id = 2");

            System.out.println("=== Employee List After Update/Delete ===");
            rs = stmt.executeQuery("SELECT * FROM employee");
            while (rs.next()) {
                System.out.println(
                        "ID: " + rs.getInt("id") +
                        ", Name: " + rs.getString("name") +
                        ", Dept: " + rs.getString("department") +
                        ", Salary: " + rs.getDouble("salary")
                );
            }

            conn.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}