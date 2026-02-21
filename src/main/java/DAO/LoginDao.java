/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;


import Model.*;
import java.io.InputStream;
import java.sql.*;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;
public class LoginDao {
//    private static final String DB_URL = System.getenv("DB_URL");
//    private static final String DB_USER = System.getenv("DB_USER");
//    private static final String DB_PASS = System.getenv("DB_PASS");

    private static final Logger LOGGER = Logger.getLogger(LoginDao.class.getName());

    // Using static initializer block to load properties
    private static final Properties props = new Properties();
    private static final boolean DB_PROPS_FOUND;
    static {
        boolean found = false;
        try {
            try (InputStream input = LoginDao.class.getClassLoader().getResourceAsStream("db.properties")) {
                if (input == null) {
                    LOGGER.warning("db.properties not found on classpath (expected under src/main/resources -> WEB-INF/classes)." );
                } else {
                    props.load(input);
                    found = true;
                    LOGGER.info("db.properties loaded successfully from classpath.");
                }
            }
        } catch (Exception e) {
            LOGGER.log(Level.SEVERE, "Error loading db.properties from classpath: " + e.getMessage(), e);
        }

        DB_PROPS_FOUND = found;
    }

    private static String envOrProp(String envKey, String propKey) {
        String env = System.getenv(envKey);
        if (env != null && !env.trim().isEmpty()) {
            return env.trim();
        }
        return props.getProperty(propKey);
    }

    private static String maskJdbcUrl(String url) {
        if (url == null) return null;
        // Basic masking in case credentials are ever embedded in URL
        return url.replaceAll("(?i)(password=)[^&]*", "$1***");
    }
    
    //my connection object
    public static Connection getConnection()
    {
        try {
            // Ensure the driver is present (DriverManager will usually auto-load it, but this gives clearer failure if missing)
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Allow env vars to override properties (handy for Docker/CI), but db.properties remains the default.
            String url = envOrProp("DB_URL", "db.url");
            String user = envOrProp("DB_USER", "db.username");
            String pass = envOrProp("DB_PASS", "db.password");

            LOGGER.info("DB config source: db.properties found=" + DB_PROPS_FOUND
                    + ", using url=" + maskJdbcUrl(url)
                    + ", user=" + user);

            if (url == null || url.trim().isEmpty()) {
                throw new IllegalStateException("Missing DB URL (set DB_URL env var or db.url in db.properties)");
            }
            if (user == null || user.trim().isEmpty()) {
                throw new IllegalStateException("Missing DB username (set DB_USER env var or db.username in db.properties)");
            }

            return DriverManager.getConnection(url, user, pass);

        } catch (Exception e) {
            // Never return null silently: callers should see the real root cause in logs + stacktrace.
            String urlForLog = maskJdbcUrl(envOrProp("DB_URL", "db.url"));
            String msg = "Failed to obtain DB connection. url=" + urlForLog
                    + ", db.properties found=" + DB_PROPS_FOUND
                    + ", error=" + e.getClass().getName() + ": " + e.getMessage();
            LOGGER.log(Level.SEVERE, msg, e);
            throw new RuntimeException(msg, e);
        }
    }
    
    //Student function
    public static Student verifyStudent(Student student)
    {
        Student stud = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        
        String matric = student.getMatric();
        String password = student.getPassword();
        
        try{
            String query = "Select * from student where matric_number = ? And password = ?";
            con = LoginDao.getConnection();

            if (con == null) {
                // Defensive: getConnection should throw instead of returning null, but avoid NPE if ever changed.
                throw new IllegalStateException("Database connection is null (unexpected). Check DB configuration and connectivity.");
            }
            
            ps = con.prepareStatement(query);
            ps.setString(1, matric);
            ps.setString(2, password);
            
            rs = ps.executeQuery();
            if(rs.next())
            {
                stud = new Student();
                stud.setId(rs.getInt("student_id"));
                stud.setMatric(rs.getString("matric_number"));
                stud.setName(rs.getString("name"));
            }
            
        }catch(SQLException e){
            LOGGER.log(Level.SEVERE, "verifyStudent SQL error: " + e.getMessage(), e);
        }catch(RuntimeException e){
            // Let RuntimeException propagate after logging; it usually means DB connectivity/config issues.
            LOGGER.log(Level.SEVERE, "verifyStudent runtime error: " + e.getMessage(), e);
            throw e;
        }finally{
            try{
                //close all connections
                if(con != null) con.close();
                if(ps != null) ps.close();
                if(rs != null) rs.close();
            }catch(SQLException e){
                LOGGER.log(Level.WARNING, "verifyStudent cleanup error: " + e.getMessage(), e);
            }
        }
        return stud;
    }
    
    
    
    
    //lecturer function
    public static Lecturer verifyLecturer(Lecturer lecturer)
    {
        Lecturer lec = null;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        String email = lecturer.getEmail();
        String password = lecturer.getPassword();
        
        try{
            String query = "Select * from lecturer where email = ? And password = ?";
            con = LoginDao.getConnection();

            if (con == null) {
                // Defensive: getConnection should throw instead of returning null, but avoid NPE if ever changed.
                throw new IllegalStateException("Database connection is null (unexpected). Check DB configuration and connectivity.");
            }
            
            ps = con.prepareStatement(query);
            ps.setString(1, email);
            ps.setString(2, password);
            
            rs = ps.executeQuery();
            if(rs.next())
            {
                lec = new Lecturer();
                lec.setId(rs.getInt("lecturer_id"));
                lec.setName(rs.getString("name"));
                lec.setEmail(rs.getString("email"));
            }
            
        }catch(SQLException e){
            LOGGER.log(Level.SEVERE, "verifyLecturer SQL error: " + e.getMessage(), e);
        }catch(RuntimeException e){
            LOGGER.log(Level.SEVERE, "verifyLecturer runtime error: " + e.getMessage(), e);
            throw e;
        }finally{
            try{
                //close all connections
                if(con != null) con.close();
                if(ps != null) ps.close();
                if(rs != null) rs.close();  
            }catch(SQLException e){
                LOGGER.log(Level.WARNING, "verifyLecturer cleanup error: " + e.getMessage(), e);
            }
        }
        return lec;
    }
    
    
    
        public static int hasPendingRequests(int lecturerId) {
        int count = 0;
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            String query = "SELECT COUNT(*) AS total FROM leaverequest WHERE lecturer_id = ? AND status = 'Pending'";
            con = LoginDao.getConnection();
            if (con == null) {
                throw new IllegalStateException("Database connection is null (unexpected). Check DB configuration and connectivity.");
            }
            ps = con.prepareStatement(query);
            ps.setInt(1, lecturerId);
            rs = ps.executeQuery();

            if (rs.next()) {
                count = rs.getInt("total");
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "hasPendingRequests SQL error: " + e.getMessage(), e);
        } catch (RuntimeException e) {
            LOGGER.log(Level.SEVERE, "hasPendingRequests runtime error: " + e.getMessage(), e);
            throw e;
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (con != null) con.close();
            } catch (SQLException e) {
                LOGGER.log(Level.WARNING, "hasPendingRequests cleanup error: " + e.getMessage(), e);
            }
        }

        return count;
    }
}
