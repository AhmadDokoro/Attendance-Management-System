/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import Model.Attendance;
import java.util.ArrayList;
import java.util.List;
import java.sql.*;

/**
 *
 * @author PC
 */
public class SessionAttendanceListDao {
    
        public static List<Attendance> getAttendanceForSession(int sessionId) {
        List<Attendance> list = new ArrayList<>();

        try (Connection con = LoginDao.getConnection()) {
            String sql = "SELECT s.matric_number, s.name, a.scan_time, a.ip_address " +
                         "FROM Attendance a " +
                         "JOIN Student s ON a.student_id = s.student_id " +
                         "WHERE a.session_id = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, sessionId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Attendance att = new Attendance();
                att.setMatric(rs.getString("matric_number"));
                att.setStudentName(rs.getString("name"));
                att.setScanTime(rs.getString("scan_time"));
                att.setIpAddress(rs.getString("ip_address"));
                list.add(att);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
