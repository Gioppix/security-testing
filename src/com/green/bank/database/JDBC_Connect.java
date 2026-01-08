package com.green.bank.database;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class JDBC_Connect {
	private Connection connection = null;

	public Connection getConnection() throws SQLException {
		try {

			//Class.forName("oracle.jdbc.driver.OracleDriver");
			//Class.forName("com.mysql.cj.jdbc.Driver");
			Class.forName("com.mysql.jdbc.Driver");

			// Support Docker environment variables
			String dbHost = System.getenv("DB_HOST") != null ? System.getenv("DB_HOST") : "localhost";
			String dbPort = System.getenv("DB_PORT") != null ? System.getenv("DB_PORT") : "3306";
			String dbName = System.getenv("DB_NAME") != null ? System.getenv("DB_NAME") : "PIAL";
			String dbUser = System.getenv("DB_USER") != null ? System.getenv("DB_USER") : "root";
			String dbPassword = System.getenv("DB_PASSWORD") != null ? System.getenv("DB_PASSWORD") : "root";

			String jdbcUrl = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName;
			connection = DriverManager.getConnection(jdbcUrl, dbUser, dbPassword);
			System.out.print("connected");

		} catch (ClassNotFoundException e) {

			System.out.println("Where is your JDBC Driver?");
			e.printStackTrace();

		}

		return connection;

	}

}
