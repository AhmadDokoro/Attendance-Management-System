/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;



import Model.StudentHistory;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentHistoryDao {

    public static List<StudentHistory> getAttendanceHistory(String matricNumber) {
        List<StudentHistory> historyList = new ArrayList<>();

        try (Connection con = LoginDao.getConnection()) {
            String sql = "SELECT s.course_code, s.program_type, s.location, s.date, s.duration, s.start_time, s.end_time " +
                         "FROM Attendance a " +
                         "JOIN Student st ON a.student_id = st.student_id " +
                         "JOIN Session s ON a.session_id = s.session_id " +
                         "WHERE st.matric_number = ? " +
                         "ORDER BY s.date DESC, s.start_time DESC";

            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, matricNumber);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                StudentHistory sh = new StudentHistory();
                sh.setCourseCode(rs.getString("course_code"));
                sh.setProgramType(rs.getString("program_type"));
                sh.setLocation(rs.getString("location"));
                sh.setDate(rs.getString("date"));
                sh.setDuration(rs.getInt("duration"));
                sh.setStartTime(rs.getString("start_time"));
                sh.setEndTime(rs.getString("end_time"));
                historyList.add(sh);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return historyList;
    }
}

