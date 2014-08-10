package spn_test;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
 
public class LoginDAO
{
	static Connection currentCon = null;
	static ResultSet rs = null;
	public static LoginBean login(LoginBean bean)
	{
		Statement stmt = null;
		String username = bean.getUsername();
		String password = bean.getPassword();
		String userType = bean.getUserType();
		String searchQuery = "select * from " + userType +  " where " + userType.charAt(0) + "_name ='" 
		+ username + "' AND password ='" + password + "'";

		try
		{
			//connecting to the DB
			currentCon = ConnectionManager.getConnection();
			stmt=currentCon.createStatement();
			rs = stmt.executeQuery(searchQuery);
			boolean userExists = rs.next();

			if (!userExists)
			{
				bean.setValid(false);
			}
			else if (userExists)
			{
				bean.setValid(true);
			}

		}
		catch (Exception ex)
		{
			System.out.println("Log In failed: An Exception has occurred! " + ex);
		}
		return bean;
	}
}