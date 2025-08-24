package DAO;

import Model.Course;
import java.sql.*;
import java.util.*;

public class CourseDAO {

    public static List<Course> getCoursesByLecturerId(int lecturerId) {
        List<Course> courses = new ArrayList<>();

        try (Connection conn = LoginDao.getConnection()) {
            String query = "SELECT DISTINCT c.course_code, c.course_name " +
                           "FROM Course c " +
                           "JOIN GroupTable g ON c.course_code = g.course_code " +
                           "JOIN CourseGroup cg ON g.group_id = cg.group_id " +
                           "WHERE cg.lecturer_id = ?";
            PreparedStatement ps = conn.prepareStatement(query);
            ps.setInt(1, lecturerId);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Course c = new Course();
                c.setCourseCode(rs.getString("course_code"));
                c.setCourseName(rs.getString("course_name"));
                courses.add(c);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return courses;
    }
}

